//
//  WaitUIView.m
//  Weather
//
//  Created by Roy Hsiao on 3/16/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WaitUIView.h"
#import <QuartzCore/QuartzCore.h>



@implementation WaitUIView

@synthesize waitLabel, grayBackground, indicator;

- (id) init{
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        waitLabel = [[UILabel alloc] init];
        grayBackground = [[UIView alloc] init];
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect: rect];
    grayBackground.layer.cornerRadius = 10;
    grayBackground.layer.masksToBounds = YES;
    waitLabel.text = @"Please Wait ...";
    grayBackground.backgroundColor = [UIColor blackColor];
    grayBackground.alpha = .7f;
    CGFloat bgWidth = 150;
    CGFloat bgHeight = 150;
    CGFloat bgX = (self.frame.size.width - bgWidth) / 2;
    CGFloat bgY = (self.frame.size.height - bgHeight) / 2;
    CGRect grayBgFrame = CGRectMake(bgX, bgY - 44, bgWidth, bgHeight);
    grayBackground.frame = grayBgFrame;
    CGFloat iWidth = 50;
    CGFloat iHeight = 50;
    CGFloat iX = (grayBgFrame.size.width - iWidth) / 2;
    CGFloat iY = (grayBgFrame.size.height - iHeight) / 2;
    CGRect indicatorFrame = CGRectMake(iX, iY, iWidth, iHeight);
    indicator.frame = indicatorFrame;
    waitLabel.frame= CGRectMake(0, grayBgFrame.size.height - 30, bgWidth, 30);
    waitLabel.backgroundColor = [UIColor blackColor];
    waitLabel.textColor = [UIColor whiteColor];
    waitLabel.textAlignment = UITextAlignmentCenter;
    [grayBackground addSubview: indicator];
    [grayBackground addSubview: waitLabel];
    [self addSubview: grayBackground];
}

@end
