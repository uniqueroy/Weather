//
//  WSLHXDetailDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 3/13/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WSLHXDetailDataHandle.h"
#import "WDisplayData.h"
#import "WNetWorkUtil.h"
#import "JSONKit.h"

@implementation WSLHXDetailDataHandle
@synthesize data;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[SLHXDetailData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

@end
