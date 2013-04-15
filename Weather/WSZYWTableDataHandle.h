//
//  WSZYWTableDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 3/17/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"
#import "WNetworkUtil.h"


@class SZYWTableData;

@interface WSZYWTableDataHandle : WDataHandleBase

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                    type: (NSString *)type;

@end
