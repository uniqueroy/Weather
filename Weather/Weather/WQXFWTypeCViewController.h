//
//  WQXFWTypeCViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "WNetworkUtil.h"
#import "WDataHandleBase.h"

@class WaitUIView;

@protocol WNetworkUtilDelegate;

@interface WQXFWTypeCViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, WNetworkUtilDelegate>

@property (assign, nonatomic) enum dataTag dataTag;
@property (strong, nonatomic) NSMutableDictionary * dict;
@property (strong, nonatomic) WaitUIView * waitView;
@property (strong, nonatomic) WDataHandleBase * dataHandle;

@property (strong, nonatomic) UISegmentedControl * segment;
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@end
