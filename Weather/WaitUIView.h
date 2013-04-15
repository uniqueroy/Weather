//
//  WaitUIView.h
//  Weather
//
//  Created by Roy Hsiao on 3/16/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitUIView : UIView


@property (strong, nonatomic) UIView * grayBackground;
@property (strong, nonatomic) UIActivityIndicatorView * indicator;
@property (strong, nonatomic) UILabel * waitLabel;

@end
