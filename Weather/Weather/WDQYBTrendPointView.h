//
//  WDQYBTrendPointView.h
//  Weather
//
//  Created by Roy Hsiao on 3/20/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDQYBTrendPointView : UIView{
    UIImage * _weatherImg;
    UIImage * _ptImg;
}
@property (strong, nonatomic) UIImageView * weather;
@property (strong, nonatomic) UIImageView * pt;
@property (strong, nonatomic) UILabel * temp;

- (id)initWithFrame:(CGRect)frame weatherImage: (UIImage *)weatherImg ptImage: (UIImage *) ptImg temp: (NSString *) tempStr;

- (void) setViewWithPtCenter: (CGPoint) ptCenter;

@end
