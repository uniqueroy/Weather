//
//  WWXYTViewController.m
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WWXYTViewController.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import "WWXYTDataHandle.h"
#import "WaitUIView.h"
#import "WWXYTPictureView.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomNavigationBar.h"

@interface WWXYTViewController ()

@end

@implementation WWXYTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CustomNavigationBar * navBar = (CustomNavigationBar *)self.navigationController.navigationBar;
    [navBar setBackgroundWith: [UIImage imageNamed: @"tqsk_navbar.png"]];
    UIButton * backButton = [navBar backButtonWith: [UIImage imageNamed: @"navigationBarBackButton.png"] highlight: nil leftCapWidth: 14.0];
    [navBar setText: @"返回" onBackButton: backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: backButton];

    
    UIImageView * background = [[UIImageView alloc] initWithFrame: self.view.frame];
    background.image = [UIImage imageNamed: @"flashbg.png"];
    
    UIButton * colorful = [[UIButton alloc] init];
    UIButton * waterful = [[UIButton alloc] init];
    UIButton * redRay = [[UIButton alloc] init];
    [colorful setTitle: @"彩色云图" forState: UIControlStateNormal];
    [waterful setTitle: @"水汽云图" forState: UIControlStateNormal];
    [redRay setTitle: @"红外云图" forState: UIControlStateNormal];
    [colorful setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [colorful setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [colorful setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    const CGFloat buttonWidth = (self.view.frame.size.width - 20)/3;
    CGRect colorfulRect = CGRectMake(self.view.frame.origin.x + 10,
                                     self.view.frame.origin.y - 20,
                                     buttonWidth,
                                     30);
    CGRect waterfulRect = CGRectMake(colorfulRect.origin.x + buttonWidth,
                                     self.view.frame.origin.y - 20,
                                     buttonWidth,
                                     30);
    CGRect redRayRect = CGRectMake(waterfulRect.origin.x + buttonWidth,
                                     self.view.frame.origin.y - 20,
                                     buttonWidth,
                                     30);
    colorful.frame = colorfulRect;
    waterful.frame = waterfulRect;
    redRay.frame = redRayRect;
    
    UIView * grayLine = [[UIView alloc] init];
    grayLine.backgroundColor = [UIColor grayColor];
    CGRect gLineRect = CGRectMake(colorfulRect.origin.x, colorfulRect.origin.y + colorfulRect.size.height + 3, buttonWidth * 3, 2);
    grayLine.frame = gLineRect;
    
    _whiteBlock = [[UIView alloc] init];
    _whiteBlock.backgroundColor = [UIColor whiteColor];
    CGRect wbRect = CGRectMake(gLineRect.origin.x, gLineRect.origin.y - 3, buttonWidth, 5);
    _whiteBlock.frame = wbRect;
    
    //time display view -
    UIButton * timeButton = [[UIButton alloc] init];
    CGRect tButtonRect = CGRectMake(wbRect.origin.x, wbRect.origin.y + 3 + wbRect.size.height,
                                    200, 50);
    timeButton.frame = tButtonRect;
    [timeButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [timeButton setTitle: @"   12年8月20日17时30分" forState: UIControlStateNormal];
    
    UIImageView * play = [[UIImageView alloc] init];
    CGRect playRect = CGRectMake(tButtonRect.origin.x + tButtonRect.size.width + 30,
                                 tButtonRect.origin.y,
                                 68,
                                 50);
    UIImage * playImg = [UIImage imageNamed: @"animationbuttonbg.png"];
    play.frame = playRect;
    play.image = playImg;
    
    [self.view addSubview: background];
    [self.view addSubview: colorful];
    [self.view addSubview: waterful];
    [self.view addSubview: redRay];
    [self.view addSubview: grayLine];
    [self.view addSubview: _whiteBlock];
    [self.view addSubview: timeButton];
    [self.view addSubview: play];
    
    _waitView = [[WaitUIView alloc] initWithFrame: self.view.frame];
    [_waitView.indicator startAnimating];
    [self.view addSubview: _waitView];
    
    WWXYTPictureView * colorView;
    WWXYTPictureView * waterView;
    WWXYTPictureView * redRayView;
    CGFloat yCoord = self.view.frame.origin.y - 20 + 30 + 5 + 50 + 2;
    CGFloat xOffSet = self.view.frame.size.width;
    colorView = [[WWXYTPictureView alloc] initWithType: 1];
    waterView = [[WWXYTPictureView alloc] initWithType: 2];
    redRayView = [[WWXYTPictureView alloc] initWithType: 3];
    colorView.delegate = self;
    waterView.delegate = self;
    redRayView.delegate = self;
    [colorView getImage];
    [waterView getImage];
    [redRayView getImage];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(3 * xOffSet, self.view.frame.size.height - yCoord);
    CGRect scrollRect = CGRectMake(self.view.frame.origin.x,
                                   yCoord,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height - yCoord);
    _scrollView.frame = scrollRect;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview: _scrollView];
}
- (void) drawScrollView: (WWXYTPictureView *) theImageView{
    CGFloat yCoord = self.view.frame.origin.y - 20 + 30 + 5 + 50;
    CGFloat xOffSet = self.view.frame.size.width;
    CGRect viewRect = CGRectMake(xOffSet * (countOfWXYTImage - 1),
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height - yCoord - 20 - 2);
    theImageView.frame = viewRect;
    [_scrollView addSubview: theImageView];
    [_scrollView setNeedsDisplay];
    [_waitView.indicator stopAnimating];
    [_waitView removeFromSuperview];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / 300;
    _pageControl.currentPage = page;
    
    [UIView beginAnimations: @"" context: nil];
    [UIView setAnimationDuration: .5f];
    _whiteBlock.frame = CGRectMake(10 + _whiteBlock.frame.size.width * page,
                                   _whiteBlock.frame.origin.y,
                                   _whiteBlock.frame.size.width,
                                   _whiteBlock.frame.size.height);
    [UIView commitAnimations];
    
    
}
-(void) viewDidDisappear:(BOOL)animated{
    countOfWXYTImage = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
