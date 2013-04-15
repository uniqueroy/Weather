//
//  WRadarDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WRadarDataHandle.h"
#import "WDisplayData.h"

@implementation WRadarDataHandle

- (id) initWithUIDelegate:(id<WNetworkUtilDelegate>)theDelegate firstNode:(NSString *)theFirstNode secondNode:(NSString *)theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[RadarDetailData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

@end
