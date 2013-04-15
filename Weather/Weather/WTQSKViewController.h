//
//  WTQSKViewController.h
//  Weather
//
//  Created by Roy Hsiao on 4/9/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDataHandleBase.h"
@class WDataHandleBase;
@class WPickerview;
@protocol WPickerButtonDelegate;
@class WTQSKScrollView;
@interface WTQSKViewController : UIViewController<UIScrollViewDelegate, WNetworkUtilDelegate, UIPickerViewDelegate, WPickerButtonDelegate>{
    UIPageControl * _pageControl;
    UIView * _titleView;
    WTQSKScrollView * _scrollView;
    WDataHandleBase * _dataHandle;
    
    UIView * _movingBlock;
    NSInteger _formerPage;
    WPickerview * _picker;
    
}

@property (strong, nonatomic) WTQSKScrollView * scrollView;
@property (strong, nonatomic) UIPageControl * pageControl;
@property (strong, nonatomic) NSMutableDictionary * rootCities;
@property (strong, nonatomic) NSMutableDictionary * rootCity;
@property (strong, nonatomic) NSMutableDictionary * subCities;
@end
