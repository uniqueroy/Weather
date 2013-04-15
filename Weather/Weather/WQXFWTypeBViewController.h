//
//  WQXFWTypeBViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "WNetworkUtil.h"
#import "WDataHandleBase.h"

@class WaitUIView;

@protocol WNetworkUtilDelegate;

@interface WQXFWTypeBViewController : UITableViewController<WNetworkUtilDelegate>{
    WDataHandleBase * _detailPageDataHandle;
    NSIndexPath * _index;
}

@property (assign, nonatomic) enum dataTag dataTag;
@property (strong, nonatomic) NSMutableDictionary * dict;
@property (strong, nonatomic) WaitUIView * waitView;
@property (strong, nonatomic) WDataHandleBase * dataHandle;

@end
