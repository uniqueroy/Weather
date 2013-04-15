//
//  WYJXXTableViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNetworkUtil.h"

@class WaitUIView;

@class WYJXXListDataHandle;

@protocol WNetworkUtilDelegate;

@interface WYJXXTableViewController : UITableViewController<WNetworkUtilDelegate>{
    UITableViewCell * _loadMore;
}
@property (strong, nonatomic) NSMutableDictionary * dict;
@property (strong, nonatomic) WaitUIView * waitView;
@property (strong, nonatomic) WYJXXListDataHandle * dataHandle;

@end
