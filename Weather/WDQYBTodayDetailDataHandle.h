//
//  WDQYBTodayDetailDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 3/25/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"
#import "WNetworkUtil.h"


@class DQYBTodayDetailData;

@interface WDQYBTodayDetailDataHandle : WDataHandleBase

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode;

@end
