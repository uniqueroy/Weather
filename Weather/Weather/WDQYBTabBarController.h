//
//  WDQYBTabBarController.h
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDQYBTabBarController : UITabBarController

-(void) addFuncButtonWithImage:(UIImage*)buttonImage
                highlightImage:(UIImage*)highlightImage
                        forPos: (CGFloat) pos
               performSelector: (SEL) select;

@end
