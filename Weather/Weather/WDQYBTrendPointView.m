//
//  WDQYBTrendPointView.m
//  Weather
//
//  Created by Roy Hsiao on 3/20/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTrendPointView.h"

@implementation WDQYBTrendPointView

@synthesize weather, pt, temp;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame weatherImage: (UIImage *)weatherImg ptImage: (UIImage *) ptImg temp: (NSString *) tempStr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.weather = [[UIImageView alloc] initWithImage: weatherImg];
        self.pt = [[UIImageView alloc] initWithImage: ptImg];
        self.pt.backgroundColor = [UIColor clearColor];
        self.temp = [[UILabel alloc] init];
        self.temp.backgroundColor = [UIColor redColor];
        self.temp.text = [NSString stringWithFormat: @"%@", tempStr];
        self.temp.font = [UIFont fontWithName: @"Arial" size: 12];
        self.temp.textColor = [UIColor whiteColor];
        self.temp.backgroundColor = [UIColor clearColor];
        self.temp.textAlignment = UITextAlignmentCenter;
    }
    return self;
}

- (void) setViewWithPtCenter: (CGPoint) ptCenter{
    CGFloat ySetoff = fabsf(ptCenter.y - self.pt.center.y);
    CGPoint newCenter = CGPointMake(self.center.x, self.center.y - ySetoff);
    self.center = newCenter;
}

- (void)drawRect:(CGRect)rect
{
    CGRect weatherRect = CGRectMake(rect.origin.x, rect.origin.y, 40, 40);
    self.weather.frame = weatherRect;
    CGRect tempRect = weatherRect;
    tempRect.size = CGSizeMake(40, 10);
    tempRect.origin.y = weatherRect.origin.y + weatherRect.size.height;
    self.temp.frame = tempRect;
    CGRect ptRect = tempRect;
    ptRect.size = CGSizeMake(20, 20);
    ptRect.origin.y = tempRect.origin.y + tempRect.size.height;
    ptRect.origin.x = tempRect.origin.x + 10;// 10 is the value that temp's x subtracts pt's x then devides by 2
    self.pt.frame = ptRect;
    [self addSubview: self.weather];
    [self addSubview: self.pt];
    [self addSubview: self.temp];   
    [self bringSubviewToFront: temp];
}

@end
