//
//  WDZYBSumViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/17/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "WNetworkUtil.h"
#import "WDataHandleBase.h"

@class WaitUIView;

@protocol WNetworkUtilDelegate;

@interface WDQYBSumViewController : UIViewController<WNetworkUtilDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UILabel * tempLabel;
//First Days View Components
@property (strong, nonatomic) UILabel * firstDay;
@property (strong, nonatomic) UILabel * firstDayTemp;
@property (strong, nonatomic) UIImageView * firstDayImgView;
//Second Days View Components
@property (strong, nonatomic) UILabel * secondDay;
@property (strong, nonatomic) UILabel * secondDayTemp;
@property (strong, nonatomic) UIImageView * secondDayImgView;
//Third Days View Components
@property (strong, nonatomic) UILabel * thirdDay;
@property (strong, nonatomic) UILabel * thirdDayTemp;
@property (strong, nonatomic) UIImageView * thirdDayImgView;
//Forth Days View Components
@property (strong, nonatomic) UILabel * forthDay;
@property (strong, nonatomic) UILabel * forthDayTemp;
@property (strong, nonatomic) UIImageView * forthDayImgView;

//Today's weather
@property (strong, nonatomic) UILabel * todayWeather;
@property (strong, nonatomic) UILabel * todayTemp;
@property (strong, nonatomic) UILabel * todayWindy;
@property (strong, nonatomic) UILabel * todayDate;
@property (strong, nonatomic) UILabel * todayPublishTime;



@property (strong, nonatomic) WaitUIView * waitView;
@property (strong, nonatomic) WDataHandleBase * dataHandle1;
@property (strong, nonatomic) WDataHandleBase * dataHandle2;
@property (strong, nonatomic) NSMutableDictionary * todayDict;
@property (strong, nonatomic) NSMutableDictionary * trendDict;

@end
