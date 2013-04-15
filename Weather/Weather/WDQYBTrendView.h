//
//  WDQYBTrendView.h
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDQYBTrendPointView;

@interface WDQYBTrendView : UIView

@property (strong, nonatomic) WDQYBTrendPointView * todayPt;
@property (strong, nonatomic) WDQYBTrendPointView * tmrPt;
@property (strong, nonatomic) WDQYBTrendPointView * firstPt;
@property (strong, nonatomic) WDQYBTrendPointView * secondPt;
@property (strong, nonatomic) WDQYBTrendPointView * thirdPt;
@property (strong, nonatomic) WDQYBTrendPointView * forthPt;

@property (strong, nonatomic) UIImage * todayImg;
@property (strong, nonatomic) UIImage * tmrImg;
@property (strong, nonatomic) UIImage * firstImg;
@property (strong, nonatomic) UIImage * secondImg;
@property (strong, nonatomic) UIImage * thirdImg;
@property (strong, nonatomic) UIImage * forthImg;

@property (strong, nonatomic) NSDictionary * tempItems;

@property (nonatomic) CGFloat minTemp;
@property (nonatomic) CGFloat maxTemp;
@property (nonatomic) CGFloat pointsForOneDegree;

- (id)initWithFrame:(CGRect)frame items: (NSDictionary *) theItemsDict;
- (void) setItemsDict: (NSDictionary *) theItemsDict;
- (void) refreshUI;
- (void) setWeatherImage: (NSArray *) imgAry;
- (void) setWindImage;

@end
