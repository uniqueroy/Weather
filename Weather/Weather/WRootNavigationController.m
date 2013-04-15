//
//  WRootNavigationController.m
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WRootNavigationController.h"
#import "CustomNavigationBar.h"

@interface WRootNavigationController ()

@end

@implementation WRootNavigationController

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
    self.delegate = self;
	// Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if([viewController respondsToSelector: @selector(willAppearIn:)])
        [viewController performSelector: @selector(willAppearIn:) withObject: navigationController];
}

@end
