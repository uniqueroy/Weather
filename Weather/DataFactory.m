//
//  DataFactory.m
//  Weather
//
//  Created by Roy Hsiao on 3/16/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "DataFactory.h"
#import "WDisplayData.h"
#import "WDataHandleBase.h"
#import "WDetailOperation.h"
@implementation DataFactory

+ (void) doDataWith: (id<WNetworkDataSource>) dataSource inQueue: (NSOperationQueue *) queue{
    WNetworkUtil * networkUtil = [[WNetworkUtil alloc] init];
    networkUtil.delegate = [(WDataHandleBase *)dataSource uiDelegate];
    networkUtil.datasource = dataSource;
    networkUtil.urlStr = [(WDataHandleBase *)dataSource subclassUrl];
    networkUtil.firstNode = [(WDataHandleBase *)dataSource firstNode];
    networkUtil.secondNode = [(WDataHandleBase *)dataSource secondeNode];
    [queue addOperation: networkUtil];
}

+ (void) doDetailDataWith: (id<WNetworkDataSource>) dataSource inQueue: (NSOperationQueue *) queue{
    WDetailOperation * detailOperation = [[WDetailOperation alloc] init];
    detailOperation.delegate = [(WDataHandleBase *)dataSource uiDelegate];
    detailOperation.datasource = dataSource;
    detailOperation.urlStr = [(WDataHandleBase *)dataSource subclassUrl];
    detailOperation.firstNode = [(WDataHandleBase *)dataSource firstNode];
    detailOperation.secondNode = [(WDataHandleBase *)dataSource secondeNode];
    [queue addOperation: detailOperation];
}

@end
