//
//  WDQYBTrendLabelView.h
//  Weather
//
//  Created by Roy Hsiao on 3/19/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLabelWidth 50
#define kLabelHeight 20

@interface CustomizedLabel : UILabel

@end

@interface WDQYBTrendLabelView : UIView

@property (strong, nonatomic) CustomizedLabel * first;
@property (strong, nonatomic) CustomizedLabel * second;
@property (strong, nonatomic) CustomizedLabel * third;
@property (strong, nonatomic) CustomizedLabel * forth;
@property (strong, nonatomic) CustomizedLabel * fifth;
@property (strong, nonatomic) CustomizedLabel * sixth;

@property (strong, nonatomic) NSMutableDictionary * valuesDict;

@property (nonatomic) int holderPlace;
@property (nonatomic) int border;
- (id) initWithFrame:(CGRect)frame withDictionary: (NSMutableDictionary *) dictionary;
- (void) setText: (NSMutableDictionary *) texts;
@end
