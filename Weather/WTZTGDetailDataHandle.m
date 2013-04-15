//
//  WTZTGDetailDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTZTGDetailDataHandle.h"
#import "WDisplayData.h"
@implementation WTZTGDetailDataHandle
-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                 withUrl: (NSString *) theUrl{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[TZTGDetailedData alloc] initWithUrl: theUrl];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}
@end
