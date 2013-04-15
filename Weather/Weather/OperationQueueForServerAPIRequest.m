//
//  OperationQueueForServerAPIRequest.m
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "OperationQueueForServerAPIRequest.h"

static OperationQueueForServerAPIRequest * queue = nil;

@implementation OperationQueueForServerAPIRequest

+ (OperationQueueForServerAPIRequest *) sharedQueue{
    if(!queue){
        queue = [[super allocWithZone: NULL] init];
        queue.maxConcurrentOperationCount = 1;
    }
    return queue;
}

+ (id) allocWithZone:(NSZone *)zone{
    return [self sharedQueue];
}

- (id) copyWithZone: (NSZone *)zone{
    return self;
}

- (id) init{
    if(queue)
        return queue;
    self = [super init];
    return self;
}

@end
