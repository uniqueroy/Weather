//
//  WTypeAViewController.m
//  Weather
//
//  Created by Roy Hsiao on 4/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTypeAViewController.h"
#import "WContentScrollView.h"
#import "Constants.h"
#import "WaitUIView.h"
#import "DataFactory.h"

#import "WYJXXDetailDataHandle.h"
#import "WZQYBDetailDataHandle.h"
#import "WQHYCDetailDataHandle.h"
#import "WDZZHDetailDataHandle.h"
#import "WSLHXDetailDataHandle.h"
#import "WQHPJDetailDataHandle.h"
#import "WNYQXDetailDataHandle.h"
#import "WYACXDetailDataHandler.h"
#import "WTZTGDetailDataHandle.h"


#import "WDisplayData.h"
#import "OperationQueueForServerAPIRequest.h"
#import "Utilities.h"
#import "CustomNavigationBar.h"

@interface WTypeAViewController ()

@end

@implementation WTypeAViewController

@synthesize finalArray, dataTag, redTitle = _redTitle, detailUrl = _detailUrl;

- (void) updateUI{
    if([[_dataHandle getData] count] != 0){
        [self setDataToViews];
        [self.view addSubview: _redTitle];
        [self.view addSubview: _leftBanner];
        [self.view addSubview: _rightBanner];
        [self.view addSubview: _redline];
        [self.view addSubview: _content];
    }
    [_waitView removeFromSuperview];
}

- (void) exitWithError{
    UIAlertView * a = [[UIAlertView alloc] initWithTitle: @"网络错误" message: @"请检查网络, 返回重试" delegate: self cancelButtonTitle: @"确定" otherButtonTitles: nil];
    [a show];
}

- (void) parseText: (NSString *) theText{
    NSArray * array = [theText componentsSeparatedByString: @"${"];
    for(NSString * str in array){
        NSArray * subArray = [str componentsSeparatedByString: @"}"];
        for(NSString * s in subArray)
            [self.finalArray addObject: s];
    }
    for(int i = 0; i < [finalArray count]; i ++){
        NSString * s = [finalArray objectAtIndex: i];
        if([s hasPrefix: @"UploadFile"])
            [finalArray replaceObjectAtIndex: i withObject: [NSString stringWithFormat: @"picture$%@%@", kSERVER_URL, s]];
        else
            [finalArray replaceObjectAtIndex: i withObject: [NSString stringWithFormat: @"text$%@", s]];
    }
}

- (void) setDataToViews{
    _redTitle.text = [NSString stringWithString:[[_dataHandle getData] objectForKey: @"title"]];
    NSString * bannerStr = [[_dataHandle getData] objectForKey: @"banner"];
    NSRange issueRange;
    NSString * issueStr ;
    NSString * dateStr ;
    if(self.dataTag == kYJXX){
        issueRange = [bannerStr rangeOfString: @"签发"];
        issueStr = [bannerStr substringToIndex: issueRange.location - 2];
        dateStr = [bannerStr substringFromIndex: issueRange.location];
    }else if(self.dataTag == kYACXD){
        issueStr = [[_dataHandle getData] objectForKey: @"publisher"];
        dateStr = [[_dataHandle getData] objectForKey: @"id"];
        _leftBanner.center = CGPointMake(_redTitle.center.x, _leftBanner.center.y);
        _leftBanner.textAlignment = UITextAlignmentCenter;
        _rightBanner.textAlignment = UITextAlignmentCenter;
        _rightBanner.center = CGPointMake(_leftBanner.center.x,
                                          _leftBanner.center.y + _leftBanner.frame.size.height / 2 + _rightBanner.frame.size.height / 2);
        _redline.frame = CGRectMake(_redline.frame.origin.x,
                                    _rightBanner.frame.origin.y + _rightBanner.frame.size.height,
                                    _redline.frame.size.width,
                                    _redline.frame.size.height);
        _content.frame = CGRectMake(_content.frame.origin.x,
                                    _redline.frame.origin.y + _redline.frame.size.height,
                                    _content.frame.size.width,
                                    _content.frame.size.height);
    }else if(self.dataTag == kTZTGD){
        _redTitle.font = [UIFont boldSystemFontOfSize: 20];
        issueStr = [[_dataHandle getData] objectForKey: @"banner"];
        dateStr = [[_dataHandle getData] objectForKey: @"secondtitle"];
        _leftBanner.center = CGPointMake(_redTitle.center.x, _leftBanner.center.y);
        _leftBanner.textAlignment = UITextAlignmentCenter;
        _rightBanner.textAlignment = UITextAlignmentCenter;
        _rightBanner.center = CGPointMake(_leftBanner.center.x,
                                          _leftBanner.center.y + _leftBanner.frame.size.height / 2 + _rightBanner.frame.size.height / 2);
        _redline.frame = CGRectMake(_redline.frame.origin.x,
                                    _rightBanner.frame.origin.y + _rightBanner.frame.size.height,
                                    _redline.frame.size.width,
                                    _redline.frame.size.height);
        _content.frame = CGRectMake(_content.frame.origin.x,
                                    _redline.frame.origin.y + _redline.frame.size.height,
                                    _content.frame.size.width,
                                    _content.frame.size.height);
    }else{
        issueRange = [bannerStr rangeOfString: @"年"];
        issueStr = [bannerStr substringToIndex: issueRange.location - 5];
        dateStr = [bannerStr substringFromIndex: issueRange.location - 4];
    }
    _leftBanner.text = issueStr;
    _rightBanner.text = dateStr;
    NSString * text = [[_dataHandle getData] objectForKey: @"content"];
    [self parseText: text];
    _content.content = finalArray;
    [_content setContent];
    _content.contentSize = CGSizeMake(320, _content.totalHeight + 50);
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(exitWithError) name: @"NetworkError" object: nil];
    
}

- (void) playAlert: (NSNotification *) noti{
    UIAlertView * a = [[UIAlertView alloc] initWithTitle: @"" message: @"" delegate: self cancelButtonTitle: @"@" otherButtonTitles: nil];
    [a show];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _redline = [[UIImageView alloc] init];
        _redline.image = [UIImage imageNamed: @"redline.png"];
        _leftBanner = [[UILabel alloc] init];
        _rightBanner = [[UILabel alloc] init];
        _content = [[WContentScrollView alloc] init];
        self.finalArray = [[NSMutableArray alloc] init];
        _detailUrl = [[NSString alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(playAlert:) name: @"NetworkBroken" object:nil];
    }
    return self;
}

- (id) init{
    self = [super init];
    if (self) {
        _redTitle = [[UILabel alloc] init];
        _redline = [[UIImageView alloc] init];
        _redline.image = [UIImage imageNamed: @"redline.png"];
        _leftBanner = [[UILabel alloc] init];
        _rightBanner = [[UILabel alloc] init];
        _content = [[WContentScrollView alloc] init];
        _detailUrl = [[NSString alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundView.image = [UIImage imageNamed: @"cut_paperbg.png"];
    [self.view addSubview: backgroundView];
    _waitView = [[WaitUIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [_waitView.indicator startAnimating];
    [self.view addSubview: _waitView];
    _redTitle.frame = CGRectMake(0, 5, 320, 40);
    _redTitle.textAlignment = UITextAlignmentCenter;
    _redTitle.textColor = [UIColor redColor];
    _redTitle.font = [UIFont boldSystemFontOfSize: 25];
    _redTitle.backgroundColor = [UIColor clearColor];
    _leftBanner.frame = CGRectMake(5, 5 + _redTitle.frame.size.height, 160, 30);
    _leftBanner.font = [UIFont fontWithName: @"Arial" size: 13];
    _leftBanner.backgroundColor = [UIColor clearColor];
    _leftBanner.textAlignment = UITextAlignmentLeft;
    _rightBanner.frame = CGRectMake(_leftBanner.frame.size.width, 5 + _redTitle.frame.size.height, 157, 30);
    _rightBanner.font = [UIFont fontWithName: @"Arial" size: 13];
    _rightBanner.backgroundColor = [UIColor clearColor];
    _rightBanner.textAlignment = UITextAlignmentRight;
    _redline.frame = CGRectMake(3,
                                _rightBanner.frame.size.height + _rightBanner.frame.origin.y,
                                314, 2);
    _content.frame = CGRectMake(0,
                                _redline.frame.size.height + _redline.frame.origin.y,
                                320, self.view.frame.size.height - _redline.frame.size.height - _redline.frame.origin.y);
    _content.backgroundColor = [UIColor clearColor];
    _content.showsVerticalScrollIndicator = YES;
    _content.showsHorizontalScrollIndicator = NO;
    _content.delegate = self;
    
    
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"titlebg_0.png"]];
    // Create a custom back button
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"navigationBarBackButton.png"] highlight:nil leftCapWidth:14.0];
    [customNavigationBar setText: @"返回" onBackButton: backButton];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self swithData];
}

- (void) swithData{
    switch (self.dataTag) {
        case kYJXX:{
            _dataHandle = [[WYJXXDetailDataHandle alloc] initWithUIDelegate: self
                                                                  firstNode: @"yjxxitem"
                                                                 secondNode:@""
                                                                    withUrl: self.detailUrl];
            break;
        }
        case kZQYB:{
            _dataHandle = [[WZQYBDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"midforecast" secondNode: @""];
            break;
        }
        case kQHYC:{
            _dataHandle = [[WQHYCDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"lastforecast" secondNode: @""];
            break;
        }
        case kSLHX:{
            _dataHandle = [[WSLHXDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"forestfire" secondNode: @""];
            break;
        }
        case kDZZH:{
            _dataHandle = [[WDZZHDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"geological" secondNode: @""];
            break;
        }
        case kQHPJD:{
            if(self.detailUrl){
                _dataHandle = [[WQHPJDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"weathercomment" secondNode: @"" withUrl: self.detailUrl];

            }
            break;
        }
        case kNYQXD:{
            if(self.detailUrl){
                _dataHandle = [[WNYQXDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"agriculturalcomment" secondNode: @"" withUrl: self.detailUrl];
                
            }
            break;
        }
        case kYACXD:{
            if(self.detailUrl)
                _dataHandle = [[WYACXDetailDataHandler alloc] initWithUIDelegate: self firstNode: @"yacxitem" secondNode:nil withUrl: self.detailUrl];;
            break;
        }
        case kTZTGD:{
            _dataHandle = [[WTZTGDetailDataHandle alloc] initWithUIDelegate: self firstNode: @"notification" secondNode:nil withUrl: self.detailUrl];
            break;
        }
        default:{
            break;
            NSLog(@"error in switchData of A");
            return;
        }
    }
    [DataFactory doDataWith: _dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
