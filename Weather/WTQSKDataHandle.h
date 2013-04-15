//
//  WTQSKDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 4/9/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"

@interface WTQSKDataHandle : WDataHandleBase

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode;

@end
