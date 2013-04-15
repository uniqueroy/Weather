//
//  WDataHandleBase.h
//  Weather
//
//  Created by Roy Hsiao on 3/16/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WNetworkUtil.h"

@class DataBase;

@protocol WNetworkUtilDelegate;
@protocol WNetworkDataSource;

@interface WDataHandleBase : NSObject<WNetworkDataSource>

@property (strong, nonatomic) id<WNetworkUtilDelegate> uiDelegate;
@property (strong, nonatomic) DataBase * data;

@property (strong, nonatomic) NSString * firstNode;
@property (strong, nonatomic) NSString * secondeNode;
@property (strong, nonatomic) NSString * subclassUrl;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                 withUrl: (NSString *) theUrl;

- (NSMutableDictionary *) getData;
@end
