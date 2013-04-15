//
//  WAppDelegate.h
//  Weather
//
//  Created by Roy Hsiao on 1/5/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;

@interface WAppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate>{
    Reachability * hostReach;
    UINavigationController * nav;
}
@property (strong, nonatomic) UIWindow *window;

@end
