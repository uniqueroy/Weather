//
//  WYACXListDataHandler.h
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"

@interface WYACXListDataHandler : WDataHandleBase

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
               firstNode: (NSString *) theFirstNode
              secondNode: (NSString *) theSecondNode;

- (void) makeIsReadDict;
- (void) setIsReadForItem: (NSString *) theItem withValue: (NSNumber *) isRead;
@end
