//
//  WWXYTPictureView.m
//  Weather
//
//  Created by Roy Hsiao on 4/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WWXYTPictureView.h"
#import "WNetworkUtil.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import "WDataHandleBase.h"
#import "WWXYTDataHandle.h"

NSInteger countOfWXYTImage = 0;
@implementation WWXYTPictureView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) updateUI{
    @synchronized(self){
        NSString * imgUrl = [[_dataHandle getData] objectForKey: @"image"];
        NSURL * url = [NSURL URLWithString: imgUrl];
        NSURLRequest * r = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:1];
        NSData * received = [NSURLConnection sendSynchronousRequest: r returningResponse: nil error: nil];
        self.image = [UIImage imageWithData: received];
        [self setNeedsDisplay];
        countOfWXYTImage += 1;
        [delegate drawScrollView: self];
    }
}

- (id) initWithType: (NSInteger) theType{
    self = [super init];
    if(self){
        _type = theType;
    }
    return self;
}

- (void) getImage{
    @synchronized(self){
        if(_type){
            _dataHandle = [[WWXYTDataHandle alloc] initWithUIDelegate: self firstNode: @"satellitepic" secondNode: nil withType: _type];
            [DataFactory doDataWith: _dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
        }
    }
}


@end
