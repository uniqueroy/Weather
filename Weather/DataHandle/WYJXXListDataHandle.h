//
//  WYJXXListDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 3/8/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WNetworkUtil.h"
#import "WDataHandleBase.h"


@class YJXXListData;

@interface WYJXXListDataHandle : WDataHandleBase


-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode;

@end
