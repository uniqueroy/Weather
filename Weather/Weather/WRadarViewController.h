//
//  WRadarViewController.h
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPickerview;
@protocol WPickerButtonDelegate;
@protocol WNetworkUtilDelegate;
@class WDataHandleBase;

@interface WRadarViewController : UIViewController<WPickerButtonDelegate, WNetworkUtilDelegate>{
    WPickerview * _picker;
    UILabel * _titleLabel;
    WDataHandleBase * _dataHandle;
    UIActivityIndicatorView * _indicator;
}

@end
