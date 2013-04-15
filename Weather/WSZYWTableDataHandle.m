//
//  WSZYWTableDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 3/17/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WSZYWTableDataHandle.h"
#import "WDisplayData.h"
#import "WNetWorkUtil.h"
#import "JSONKit.h"

@implementation WSZYWTableDataHandle
@synthesize data;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                    type: (NSString *) type{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[SZYWTableData alloc] initWithType: type];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

@end
