//
//  WYACXDetailDataHandler.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYACXDetailDataHandler.h"
#import "WDisplayData.h"

@implementation WYACXDetailDataHandler
-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                 withUrl: (NSString *) theUrl{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[YACXDetailedData alloc] initWithUrl: theUrl];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}
@end
