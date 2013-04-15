//
//  WRadarDataHandle.h
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDataHandleBase.h"

@interface WRadarDataHandle : WDataHandleBase

-(id) initWithUIDelegate: (id<WNetworkUtilDelegate>) theDelegate
firstNode: (NSString *) theFirstNode
secondNode: (NSString *) theSecondNode;

@end
