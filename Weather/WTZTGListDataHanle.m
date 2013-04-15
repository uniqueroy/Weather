//
//  WTZTGListDataHanle.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTZTGListDataHanle.h"
#import "WDisplayData.h"


@implementation WTZTGListDataHanle
- (id) initWithUIDelegate:(id<WNetworkUtilDelegate>)theDelegate firstNode:(NSString *)theFirstNode secondNode:(NSString *)theSecondNode{
    self = [super initWithUIDelegate: theDelegate firstNode: theFirstNode secondNode: theSecondNode];
    if(self){
        self.data = [[TZTGListData alloc] init];
        self.subclassUrl = self.data.serverUrl;
    }
    return self;
}

- (void) makeIsReadDict{
    TZTGListData * tztgData = (TZTGListData *)self.data;
//    [yacxData makeIsReadDict];
    tztgData.isReadDict = self.data.itemsRead;
}

- (void) setIsReadForItem: (NSString *) theItem withValue: (NSNumber *) isRead{
    [((TZTGListData *)self.data).isReadDict setValue: isRead forKey: theItem];
}

- (BOOL) itemIsRead: (NSString *) theItem{
    return [[((TZTGListData *)self.data).isReadDict objectForKey: theItem] boolValue];
}

@end
