//
//  WRadarViewController.m
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WRadarViewController.h"
#import "WPickerview.h"
#import "WRadarDataHandle.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import "CustomNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

@interface WRadarViewController ()

@end

@implementation WRadarViewController

- (void) updateUI{
    if([[_dataHandle getData] count] != 0){
        NSString * urlStr = [[_dataHandle getData] objectForKey: @"image"];
        NSURL * url = [NSURL URLWithString: urlStr];
        NSURLRequest * req = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:0];
        NSData * received = [NSURLConnection sendSynchronousRequest: req returningResponse: nil error: nil];
        UIImage * radarImg = [[UIImage alloc] initWithData: received];
        UIImageView * radarView = [[UIImageView alloc] initWithImage: radarImg];
        CGFloat h = self.view.frame.size.height - (self.view.frame.origin.y - 20 + 44 + 30 + 40 + 30) + 20;
        radarView.frame = CGRectMake(self.view.frame.origin.x,
                                     self.view.frame.origin.y - 20 - 20 + 44 + 30 + 40 + 30,
                                     self.view.frame.size.width,
                                     h);
        radarView.layer.borderColor = [UIColor redColor].CGColor;
        radarView.layer.borderWidth = 1;
        [self.view addSubview: radarView];
    }
    [_indicator stopAnimating];
    [_indicator removeFromSuperview];
}

- (void) goSwitch{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _picker = [[WPickerview alloc] init];
        _picker.items = [NSDictionary dictionaryWithObjectsAndKeys: @"12年8月20日17时30分", @"item0", @"晋中", @"item1", nil];
        _titleLabel = [[UILabel alloc] init];
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
    _picker.frame = CGRectMake(self.view.frame.origin.x,
                               self.view.frame.origin.y - 20,
                               self.view.frame.size.width,
                               30);
    UIImageView * colorView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"colorpivot.png"]];
    colorView.frame = CGRectMake(self.view.frame.origin.x + 5,
                                 _picker.frame.origin.y + _picker.frame.size.height,
                                 self.view.frame.size.width - 10,
                                 40);
    _titleLabel.text = @"太原雷达站  2012-08-02  16:12:54BJT";
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.frame = CGRectMake(colorView.frame.origin.x - 5,
                                   colorView.frame.origin.y + colorView.frame.size.height,
                                   self.view.frame.size.width,
                                   30);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    
    _picker.layer.borderColor = [UIColor yellowColor].CGColor;
    _picker.layer.borderWidth = 1;
    colorView.layer.borderColor = [UIColor blueColor].CGColor;
    colorView.layer.borderWidth = 1;
    _titleLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _titleLabel.layer.borderWidth = 1;
    
    [self.view addSubview: _picker];
    [self.view addSubview: colorView];
    [self.view addSubview: _titleLabel];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0, 0, 100, 100);
    _indicator.center = self.view.center;
    [_indicator startAnimating];
    [self.view addSubview: _indicator];
    _dataHandle = [[WRadarDataHandle alloc] initWithUIDelegate: self firstNode: @"radar" secondNode: nil];
    [DataFactory doDataWith: _dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
