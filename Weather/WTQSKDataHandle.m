//
//  WTQSKDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 4/9/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTQSKDataHandle.h"
#import "WDisplayData.h"

@implementation WTQSKDataHandle

- (id) initWithUIDelegate:(id<WNetworkUtilDelegate>)theDelegate firstNode:(NSString *)theFirstNode secondNode:(NSString *)theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[TQSKDetailData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

@end
