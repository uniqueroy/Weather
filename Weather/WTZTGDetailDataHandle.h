//
//  WTZTGDetailDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"

@interface WTZTGDetailDataHandle : WDataHandleBase
-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode
                 withUrl: (NSString *) theUrl;
@end
