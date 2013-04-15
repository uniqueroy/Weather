//
//  WQHYCDetailDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 3/13/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WNetworkUtil.h"
#import "WDataHandleBase.h"


@class QHYCDetailData;

@interface WQHYCDetailDataHandle : WDataHandleBase

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode;

@end
