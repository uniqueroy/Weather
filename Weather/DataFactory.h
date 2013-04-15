//
//  DataFactory.h
//  Weather
//
//  Created by Roy Hsiao on 3/16/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WNetworkUtil.h"
#import "WDetailOperation.h"

@protocol WNetworkDataSource;

@interface DataFactory : NSObject

+ (void) doDataWith: (id<WNetworkDataSource>) dataSource inQueue: (NSOperationQueue *) queue;

+ (void) doDetailDataWith: (id<WNetworkDataSource>) dataSource inQueue: (NSOperationQueue *) queue;


@end
