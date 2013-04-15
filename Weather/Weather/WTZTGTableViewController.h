//
//  WTZTGTableViewController.h
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNetworkUtil.h"
@class WDataHandleBase, WaitUIView;

@protocol WNetworkUtilDelegate;

@interface WTZTGTableViewController : UITableViewController<WNetworkUtilDelegate>{
    WDataHandleBase * _dataHandle;
    WaitUIView * _waitView;
}

@end
