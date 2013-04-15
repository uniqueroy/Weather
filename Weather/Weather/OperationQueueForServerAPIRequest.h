//
//  OperationQueueForServerAPIRequest.h
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationQueueForServerAPIRequest : NSOperationQueue

+ (OperationQueueForServerAPIRequest *) sharedQueue;

@end
