//
//  WSZYWViewController.h
//  Weather
//
//  Created by Roy Hsiao on 4/15/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WNetworkUtilDelegate;
@class WDataHandleBase, WaitUIView;

@interface WSZYWViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, WNetworkUtilDelegate>{
    UITableView * _tableView;
    WaitUIView * _waitView;
    WDataHandleBase * _dataHandle;
}

@end
