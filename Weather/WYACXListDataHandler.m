//
//  WYACXListDataHandler.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYACXListDataHandler.h"
#import "WDisplayData.h"

@implementation WYACXListDataHandler

- (id) initWithUIDelegate:(id<WNetworkUtilDelegate>)theDelegate firstNode:(NSString *)theFirstNode secondNode:(NSString *)theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[YACXListData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

- (void) makeIsReadDict{
    YACXListData * yacxData = (YACXListData *)self.data;
    [yacxData makeIsReadDict];
}

- (void) setIsReadForItem: (NSString *) theItem withValue: (NSNumber *) isRead{
    [((YACXListData *)self.data).isReadDict setValue: isRead forKey: theItem];
}

@end
