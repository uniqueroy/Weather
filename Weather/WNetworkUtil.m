//
//  WNetworkUtil.m
//  Weather
//
//  Created by Roy Hsiao on 3/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WNetworkUtil.h"
#import "JSONKit.h"
#import "WYJXXTableViewController.h"
#import "Utilities.h"


@implementation WNetworkUtil

@synthesize urlStr, jsonDataDict, delegate, firstNode, secondNode, datasource;

- (id) initWithUrl: (NSString *) theUrl{
    self = [super init];
    if(self){
        self.urlStr = [[NSString alloc] initWithString: theUrl];
    }
    return self;
}

- (void) main{
    self.jsonDataDict = [[NSMutableDictionary alloc] initWithDictionary: [Utilities networkUtilParseUrl: self.urlStr withFirstNode: self.firstNode withSecondeNode: self.secondNode withDelegate: delegate]];
    [self.datasource didFinishDictionaryIn: self];
    [(UIViewController *)delegate performSelectorOnMainThread: @selector(updateUI) withObject: nil waitUntilDone: NO];
}



@end
