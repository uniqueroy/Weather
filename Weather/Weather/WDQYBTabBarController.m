//
//  WDQYBTabBarController.m
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTabBarController.h"
#import "WDQYBSumViewController.h"
#import "WDQYBTrendViewController.h"
#import "WaitUIView.h"

@interface WDQYBTabBarController ()

@end

@implementation WDQYBTabBarController

-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image class: (Class) class;
{
    UIViewController * viewController;
    if(class)
        viewController = [[class alloc] init];
    else
        viewController = [[UIViewController alloc] init];
    
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    return viewController;
}

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
    UIImage * item1 = [UIImage imageNamed: @"currentweather.png"];
    UIImage * item2 = [UIImage imageNamed: @"trend.png"];
    UIImage * item3 = [UIImage imageNamed: @"update.png"];
    UIImage * item4 = [UIImage imageNamed: @"homebottom.png"];
    UIImage * item5 = [UIImage imageNamed: @"exit.png"];
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle: @"天气" image: item1 class: [WDQYBSumViewController class]],
                            [self viewControllerWithTabTitle: @"趋势" image: item2 class: [WDQYBTrendViewController class]],
                            [self viewControllerWithTabTitle: @"更新" image: nil class: nil],
                            [self viewControllerWithTabTitle: @"主页" image: nil class: nil],
                            [self viewControllerWithTabTitle: @"退出" image: nil class: nil],
                            nil];
    [self addFuncButtonWithImage: item3 highlightImage: item3 forPos: 1.0 performSelector: @selector(refresh)];
    [self addFuncButtonWithImage: item4 highlightImage: item4 forPos: 2.0 performSelector: @selector(navigateToHomePage)];
    [self addFuncButtonWithImage: item5 highlightImage: item5 forPos: 3.0 performSelector: @selector(exit)];
    self.selectedIndex = 0;
}

- (void) refresh{
    [self.selectedViewController viewDidLoad];
}

- (void) exit{
    [self.navigationController popViewControllerAnimated: YES];
}

- (void) navigateToHomePage{
    [self.navigationController popToRootViewControllerAnimated: YES];
}

-(void) addFuncButtonWithImage:(UIImage*)buttonImage
                highlightImage:(UIImage*)highlightImage
                        forPos: (CGFloat) pos
               performSelector: (SEL) select{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGPoint center = self.tabBar.center;
    center.x += self.tabBar.frame.size.width / 5 * (pos - 1);
    button.center = center;
    [button addTarget: self action: select forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) willAppearIn: (UINavigationController *) navigationController{
    [UIView beginAnimations: nil context: NULL];
    [navigationController setNavigationBarHidden: YES animated: YES];
    [UIView commitAnimations];
}
@end
