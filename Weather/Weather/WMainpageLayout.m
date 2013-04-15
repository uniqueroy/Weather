//
//  WMainpageLayout.m
//  Weather
//
//  Created by Roy Hsiao on 3/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WMainpageLayout.h"

@implementation WMainpageLayout

# define ITEMSIZE_WIDTH 70
# define ITEMSIZE_HEIGHT 130


-(id) init{
    self = [super init];
    if(self){
        self.itemSize = CGSizeMake(ITEMSIZE_WIDTH, ITEMSIZE_HEIGHT);
    }
    return self;
}

@end
