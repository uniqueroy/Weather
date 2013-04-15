//
//  WDQYBTodayDetailDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 3/25/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTodayDetailDataHandle.h"
#import "WDisplayData.h"
#import "WNetWorkUtil.h"
#import "JSONKit.h"

@implementation WDQYBTodayDetailDataHandle
@synthesize data;

- (id) initWithUIDelegate:(id<WNetworkUtilDelegate>)theDelegate firstNode:(NSString *)theFirstNode secondNode:(NSString *)theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[DQYBTodayDetailData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

@end
