//
//  WDQYBTitleView.m
//  Weather
//
//  Created by Roy Hsiao on 3/19/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTitleView.h"

@implementation WDQYBTitleView

@synthesize titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.alpha = .5f;
        self.titleLabel = [[UILabel alloc] init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    //home button on title view
    UIImage * homeImg = [UIImage imageNamed: @"home.png"];
    CGRect homeBtnFrm = CGRectMake(rect.origin.x, rect.origin.y, 40, 40);
    UIButton * homeButton = [[UIButton alloc] initWithFrame: homeBtnFrm];
    [homeButton setImage: homeImg forState: UIControlStateNormal];
    [self addSubview: homeButton];
    //title label on title view
    CGFloat lblWidth = 300; CGFloat lblHeight = 40;
    CGRect titleLblFrm = CGRectMake((rect.size.width - lblWidth) / 2,
                                    (rect.size.height - lblHeight) / 2,
                                    lblWidth,
                                    lblHeight);
    self.titleLabel.frame = titleLblFrm;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize: 17];
    [self addSubview: self.titleLabel];
}


@end
