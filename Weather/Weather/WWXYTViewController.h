//
//  WWXYTViewController.h
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WNetworkUtilDelegate, WWXYTPictureViewDelegate;
@class WDataHandleBase;
@class WaitUIView;

@interface WWXYTViewController : UIViewController<WWXYTPictureViewDelegate, WNetworkUtilDelegate, UIScrollViewDelegate>{
    WDataHandleBase * _dataHandleColor;
    WDataHandleBase * _dataHandleWater;
    WDataHandleBase * _dataHandleRedRay;
    WaitUIView * _waitView;
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
    UIView * _whiteBlock;
}

@end
