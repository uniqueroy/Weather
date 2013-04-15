//
//  WWXYTDataHandle.m
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WWXYTDataHandle.h"
#import "WDisplayData.h"
@implementation WWXYTDataHandle

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                withType: (NSInteger) theType
{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[WXYTDetailData alloc] initWithType: theType];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}
@end
