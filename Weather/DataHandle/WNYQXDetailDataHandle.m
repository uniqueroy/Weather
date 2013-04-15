//
//  WNYQXDetailDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 3/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WNYQXDetailDataHandle.h"
#import "WDisplayData.h"
#import "WNetWorkUtil.h"
#import "JSONKit.h"

@implementation WNYQXDetailDataHandle
@synthesize data;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                 withUrl: (NSString *) theUrl{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[NYQXDetailData alloc] initWithUrl: theUrl];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}
@end
