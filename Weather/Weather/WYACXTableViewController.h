//
//  WYACXTableViewController.h
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WDataHandleBase;
@protocol WNetworkUtilDelegate;

@interface WYACXTableViewController : UITableViewController<UISearchBarDelegate, WNetworkUtilDelegate>{
    WDataHandleBase * _dataHandle;
}

@end
