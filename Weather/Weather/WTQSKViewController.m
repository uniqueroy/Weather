//
//  WTQSKViewController.m
//  Weather
//
//  Created by Roy Hsiao on 4/9/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTQSKViewController.h"
#import "Constants.h"
#import "WTQSKDataHandle.h"
#import "WDataHandleBase.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "WPickerview.h"
#import "CustomNavigationBar.h"
#import "WPickerDetailViewController.h"
#import "WTQSKScrollView.h"
@interface WTQSKViewController ()

@end

@implementation WTQSKViewController

@synthesize scrollView = _scrollView, pageControl = _pageControl, rootCities, subCities, rootCity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pageControl = [[UIPageControl alloc] init];
        _titleView = [[UIView alloc] init];
        _scrollView = [[WTQSKScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        rootCities = [[NSMutableDictionary alloc] init];
        subCities = [[NSMutableDictionary alloc] init];
        rootCity = [[NSMutableDictionary alloc] init];
        _movingBlock = [[UIView alloc] init];
        _picker = [[WPickerview alloc] init];
    }
    return self;
}

- (void) loadView{
    [super loadView];
    
    UIImage * backImg = [UIImage imageNamed: @"flashbg.png"];
    UIImageView * backView = [[UIImageView alloc] initWithImage: backImg];
    backView.frame = self.view.bounds;
    [self.view addSubview: backView];
    
    CGRect rect = CGRectMake(self.view.frame.origin.x,
                             self.view.frame.origin.y - 20,
                             self.view.frame.size.width,
                             self.view.frame.size.height);
    CGRect titleViewRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 30);
    CGRect pickerViewRect = CGRectMake(titleViewRect.origin.x + 10,
                                       titleViewRect.origin.y + titleViewRect.size.height,
                                       self.view.frame.size.width - 20, 30);
    CGRect scrollViewRect = CGRectMake(rect.origin.x,
                                       titleViewRect.origin.y + pickerViewRect.size.height + titleViewRect.size.height,
                                       rect.size.width,
                                       rect.size.height - titleViewRect.size.height - pickerViewRect.size.height - 44);
    _titleView.frame = titleViewRect;
    _scrollView.frame = scrollViewRect;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 6, _scrollView.frame.size.height);
    _picker.frame = pickerViewRect;
    
    _pageControl.frame = CGRectMake(self.view.center.x - 25, self.view.frame.size.height - 70, 50, 10);
    
    _titleView = [self createTitleViewWithRect: titleViewRect];
    [self.view addSubview: _titleView];
    
    _scrollView.pagingEnabled = YES;
    [self.view addSubview: _scrollView];
    _pageControl.numberOfPages = 6;
    _pageControl.currentPage = _formerPage = 0;
    _pageControl.hidden = YES;
    [self.view addSubview: _pageControl];
    
    
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"tqsk_navbar.png"]];
    // Create a custom back button
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"navigationBarBackButton.png"] highlight:nil leftCapWidth:14.0];
    [customNavigationBar setText: @"返回" onBackButton: backButton];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

- (UIView *) createTitleViewWithRect: (CGRect) rect{
    CGFloat edgeWidth = 10;
    CGFloat edgeHeight = 5;
    CGFloat lblWidth = (rect.size.width - edgeWidth * 2) / 6;
    CGFloat lblHeight = 20;
    CGPoint lblOrigin = CGPointMake(rect.origin.x + edgeWidth, rect.origin.y + edgeHeight);
    UILabel * label;
    UIView * v = [[UIView alloc] initWithFrame: rect];
    NSArray * textArray = [NSArray arrayWithObjects: @"降水量", @"风力", @"风向", @"温度", @"湿度", @"气压", nil];
    for(int i = 0; i < 6; i ++){
        label = [[UILabel alloc] initWithFrame: CGRectMake(lblOrigin.x,
                                                           lblOrigin.y,
                                                          lblWidth, lblHeight)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [textArray objectAtIndex: i];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize: 14];
        [v addSubview: label];
        lblOrigin.x += label.frame.size.width;
    }
    UIView * grayLineView = [[UIView alloc] initWithFrame: CGRectMake(rect.origin.x + edgeWidth,
                                                                     label.frame.origin.y + lblHeight + 3,
                                                                     rect.size.width - edgeWidth * 2,
                                                                      2)];
    grayLineView.backgroundColor = [UIColor grayColor];
    [v addSubview:grayLineView];
    _movingBlock.backgroundColor = [UIColor whiteColor];
    _movingBlock.frame = CGRectMake(rect.origin.x + edgeWidth,
                                    label.frame.origin.y + lblHeight,
                                    lblWidth,
                                    5);
    [v addSubview: _movingBlock];
    return v;
}

- (void) goSwitch{
    WPickerDetailViewController * switchPanel = [[WPickerDetailViewController alloc] initWithStyle: UITableViewStyleGrouped];
    switchPanel.rootCityName = ((UIButton *)[_picker.buttonsArray objectAtIndex: 0]).titleLabel.text;
    switchPanel.subCityName = ((UIButton *)[_picker.buttonsArray objectAtIndex: 1]).titleLabel.text;
    switchPanel.cities = [[NSMutableDictionary alloc] initWithDictionary: [_dataHandle getData] ];
    [self.navigationController pushViewController: switchPanel animated: YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //Set data
    _dataHandle = [(WTQSKDataHandle *)[WTQSKDataHandle alloc] initWithUIDelegate: self firstNode: nil secondNode: @"items"];
    [DataFactory doDataWith: _dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
//    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(goSwitch)];
//    [_picker addGestureRecognizer: gesture];
}

- (void) pageChangedFromPage: (NSInteger) formerPage{
    NSInteger moveTo = 1;
    if(formerPage > _pageControl.currentPage)
        moveTo = -1;
    else if(formerPage == _pageControl.currentPage)
        moveTo = 0;
    CGRect rect = CGRectMake(_movingBlock.frame.origin.x + moveTo * _movingBlock.frame.size.width,
                             _movingBlock.frame.origin.y,
                             _movingBlock.frame.size.width, _movingBlock.frame.size.height);
    
    [UIView beginAnimations: @"" context: nil];
    [UIView setAnimationDuration: .5f];
    _movingBlock.frame = rect;
    [_movingBlock setNeedsDisplay];
    [UIView commitAnimations];
    _formerPage = _pageControl.currentPage;
    
}

- (void) getValueForPicker: (NSNotification *) noti{
    NSDictionary * returnItems = [noti userInfo];
    ((UIButton *)[_picker.buttonsArray objectAtIndex: 0]).titleLabel.text = [returnItems objectForKey: @"rootCity"];
    ((UIButton *)[_picker.buttonsArray objectAtIndex: 1]).titleLabel.text = [returnItems objectForKey: @"subCity"];
}

- (void) updateUI{
    NSMutableDictionary *dict = [_dataHandle getData];
    NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithDictionary: [dict objectForKey: @"items"]];
    for(int j = 0; j < [root count]; j++){
        NSMutableDictionary * rootCityDict = [[NSMutableDictionary alloc] initWithDictionary: [root objectForKey: [NSString stringWithFormat: @"item%d", j]]];
        NSArray * subCitiesAry = [rootCityDict objectForKey: @"items"];
        for(int i = 0; i < [subCitiesAry count]; i ++){
            [rootCityDict setObject: [subCitiesAry objectAtIndex: i] forKey: [NSString stringWithFormat: @"subCity%d", i]];
        }
        [rootCityDict removeObjectForKey: @"items"];
        [rootCities setObject: rootCityDict forKey: [NSString stringWithFormat: @"rootCity%d", j]];
    }
    rootCity = [rootCities objectForKey: @"rootCity0"];
    subCities = [rootCity objectForKey: @"subCity0"];
    
    _picker.backgroundColor = [UIColor clearColor];
    _picker.items = [NSDictionary dictionaryWithObjectsAndKeys: [rootCity objectForKey: @"city"], @"item0",
                    [subCities objectForKey: @"city"]  , @"item1", @"24小时", @"item2", nil];
    _picker.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(getValueForPicker:) name: @"pickerPassValue" object: nil];
    [self.view addSubview: _picker];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / 300;
    _pageControl.currentPage = page;
    [self pageChangedFromPage: _formerPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
