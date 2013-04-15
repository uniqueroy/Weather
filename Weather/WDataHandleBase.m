//
//  WDataHandleBase.m
//  Weather
//
//  Created by Roy Hsiao on 3/16/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"
#import "WNetworkUtil.h"
#import "WDisplayData.h"

@implementation WDataHandleBase

@synthesize uiDelegate, secondeNode, firstNode, subclassUrl, data;

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode{
    self = [super init];
    if(self){
        self.uiDelegate = theDelegate;
        self.firstNode = theFirstNode;
        self.secondeNode = theSecondNode;
        self.subclassUrl = nil;
        self.data = [[DataBase alloc] init];
    }
    return self;
}

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                 withUrl: (NSString *) theUrl{
    self = [super init];
    if(self){
        self.uiDelegate = theDelegate;
        self.firstNode = theFirstNode;
        self.secondeNode = theSecondNode;
        self.subclassUrl = theUrl;
        self.data = [[DataBase alloc] init];
    }
    return self;
}

- (void) didFinishDictionaryIn: (WNetworkUtil *) networkUtil{
    self.data.dataDictionary = [[NSMutableDictionary alloc] initWithDictionary: networkUtil.jsonDataDict];
    NSArray * itemsArray = [self.data.dataDictionary objectForKey: @"items"];
    for(int i = 0; i < itemsArray.count; i ++)
        [self.data.itemsRead setObject: [NSNumber numberWithBool: NO] forKey: [NSString stringWithFormat: @"item%d", i]];
}

- (NSMutableDictionary *) getData{
    return self.data.dataDictionary;
}

@end
