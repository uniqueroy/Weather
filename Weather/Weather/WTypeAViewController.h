//
//  WTypeAViewController.h
//  Weather
//
//  Created by Roy Hsiao on 4/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDataHandleBase.h"

@class WContentScrollView;
@class WDataHandleBase;
@class WaitUIView;

@interface WTypeAViewController : UIViewController<WNetworkUtilDelegate, UIScrollViewDelegate>{
    UILabel * _redTitle;
    UIImageView * _redline;
    WContentScrollView * _content;
    UILabel * _leftBanner;
    UILabel * _rightBanner;
    WDataHandleBase * _dataHandle;
    WaitUIView * _waitView;
    NSString * _detailUrl;
}

@property (copy, nonatomic) NSString * detailUrl;
@property (strong, nonatomic) UILabel * redTitle;
@property (assign, nonatomic) enum dataTag dataTag;
@property (strong, nonatomic) NSMutableArray * finalArray;

//- (id) initWithContentDictionary: (NSMutableDictionary *) theDict;

@end
