//
//  WNetworkUtil.h
//  Weather
//
//  Created by Roy Hsiao on 3/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WNetworkUtilDelegate;
@protocol WNetworkDataSource;

@interface WNetworkUtil : NSOperation
@property (weak, nonatomic) id<WNetworkUtilDelegate> delegate;
@property (weak, nonatomic) id<WNetworkDataSource> datasource;
@property (copy, nonatomic) NSString * urlStr;
@property (copy, nonatomic) NSString * resultStr;
@property (strong, nonatomic) NSMutableDictionary * jsonDataDict;
@property (copy, nonatomic) NSString * firstNode;
@property (copy, nonatomic) NSString * secondNode;

- (id) initWithUrl: (NSString *) theUrl;

@end


@protocol WNetworkUtilDelegate <NSObject>

@optional
- (void) updateUI;
- (void) exitWithError;
- (void) detailPageUpdate;

@end

@protocol WNetworkDataSource <NSObject>
- (void) didFinishDictionaryIn: (NSOperation *) networkUtil;
@end