//
//  WDQYBTrendDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 4/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"
#import "WNetworkUtil.h"


@class DQYBTrendData;

@interface WDQYBTrendDataHandle : WDataHandleBase

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode;

@end
