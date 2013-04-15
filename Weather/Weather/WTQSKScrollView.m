//
//  WTQSKScrollView.m
//  Weather
//
//  Created by Roy Hsiao on 4/12/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTQSKScrollView.h"
#import "WTQSKPictureView.h"

@implementation WTQSKScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(frame.size.width * 6, frame.size.height);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect: rect];
    WTQSKPictureView * first = [[WTQSKPictureView alloc] initWithFrame: CGRectZero withImgUrl: @"111"];
    first.delegate = self;
}

- (void) updateScrollView:(WTQSKPictureView *)imgView{
    CGRect imgRect = CGRectMake(0 + count * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    imgView.frame = imgRect;
    [imgView drawRect: imgRect];
    [self addSubview: imgView];
//    [self setNeedsDisplay];
}

@end
