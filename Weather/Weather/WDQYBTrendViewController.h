//
//  WDQYBTrendViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "WNetworkUtil.h"
#import "WDataHandleBase.h"

@class WaitUIView, WDQYBTrendLabelView, WDQYBTrendView;

@protocol WNetworkUtilDelegate;

@interface WDQYBTrendViewController : UIViewController<WNetworkUtilDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UISegmentedControl * segment;
@property (strong, nonatomic) WDQYBTrendLabelView * dayView;
@property (strong, nonatomic) WDQYBTrendLabelView * dayWeatherView;
@property (strong, nonatomic) WDQYBTrendLabelView * dateView;
@property (strong, nonatomic) WDQYBTrendLabelView * nightWeatherView;
@property (strong, nonatomic) WDQYBTrendView * dayTrendView;
@property (strong, nonatomic) WDQYBTrendView * nightTrendView;

@property (strong, nonatomic) WaitUIView * waitView;
@property (strong, nonatomic) WDataHandleBase * dataHandle;
@property (strong, nonatomic) NSMutableDictionary * dict;
@property (strong, nonatomic) NSMutableDictionary * dayTempsDict;
@property (strong, nonatomic) NSMutableDictionary * nightTempsDict;

@end
