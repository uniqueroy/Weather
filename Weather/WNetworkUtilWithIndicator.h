//
//  WNetworkUtilWithIndicator.h
//  Weather
//
//  Created by Roy Hsiao on 3/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNetworkUtilWithIndicator : UIActivityIndicatorView{
    UIActivityIndicatorView* indicator;
    UILabel* label;
    BOOL visible,blocked;
    UIView* maskView;
    CGRect rectHud,rectSuper,rectOrigin;//外壳区域、父视图区域
    UIView* viewHud;//外壳
}
@property (assign) BOOL visible;
-(id)initWithFrame:(CGRect)frame superView:(UIView*)superView;
-(void)show:(BOOL)block;// block:是否阻塞父视图
-(void)hide;
-(void)setMessage:(NSString*)newMsg;
-(void)alignToCenter;
@end
