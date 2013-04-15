//
//  WDQYBTrendDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 4/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTrendDataHandle.h"
#import "WDisplayData.h"
#import "WNetWorkUtil.h"
#import "JSONKit.h"

@implementation WDQYBTrendDataHandle

- (id) initWithUIDelegate:(id<WNetworkUtilDelegate>)theDelegate firstNode:(NSString *)theFirstNode secondNode:(NSString *)theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[DQYBTrendData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

@end
