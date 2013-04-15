//
//  WYJXXDetailViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/8/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYJXXDetailViewController.h"
#import "WYJXXDetailDataHandle.h"
#import <QuartzCore/QuartzCore.h>

@interface WYJXXDetailViewController ()

@end

@implementation WYJXXDetailViewController

@synthesize passValDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    WYJXXDetailDataHandle * dataHandle = [[WYJXXDetailDataHandle alloc] initWithUrl: [self.passValDict objectForKey: @"request_url"]];
//    dict = [[NSMutableDictionary alloc] initWithDictionary: [dataHandle wYJXXDetailDataHandle] copyItems:YES];
    self.title = [dict objectForKey: @"title"];
    self.bannerLabel.text = [dict objectForKey: @"banner"];
    self.content.text = [dict objectForKey: @"content"];
    self.image.image = [UIImage imageNamed: @"dw1.png"];
    if([self.navigationController.navigationBar respondsToSelector: @selector(setBackgroundImage:forBarMetrics:)])
        [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"titlebg_0.png"] forBarMetrics: UIBarMetricsDefault];
//    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.layer.contents = (id)[UIImage imageNamed: @"titlebg_0.png"].CGImage;
    [self.navigationController.navigationBar.layer setMasksToBounds: YES];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
