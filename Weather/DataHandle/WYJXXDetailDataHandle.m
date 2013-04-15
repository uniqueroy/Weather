//
//  WYJXXDetailDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 3/8/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYJXXDetailDataHandle.h"
#import "WDisplayData.h"
#import "WNetWorkUtil.h"
#import "JSONKit.h"

@implementation WYJXXDetailDataHandle

@synthesize data;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                 withUrl: (NSString *) theUrl{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[YJXXDetailData alloc] initWithUrl: theUrl];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

@end
