//
//  WSHQXTableDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 3/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WSHQXTableDataHandle.h"
#import "WDisplayData.h"
#import "WNetWorkUtil.h"
#import "JSONKit.h"

@implementation WSHQXTableDataHandle
@synthesize data;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[SHQXTableData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}
@end
