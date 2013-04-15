//
//  WPictureScrollView.m
//  Weather
//
//  Created by Roy Hsiao on 4/15/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WPictureScrollView.h"

@implementation WPictureScrollView
@synthesize items;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        items = [[NSMutableDictionary alloc] initWithCapacity: 0];
        self.pagingEnabled = YES;
        
        _pageControl = [[UIPageControl alloc] initWithFrame: CGRectMake(0,
                                                                        self.frame.size.height - 20,
                                                                        80, 20)];
        _title = [[UILabel alloc] initWithFrame: CGRectMake(0, self.frame.size.height - 20,
                                                           self.frame.size.width - 80, 20)];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect: rect];
    if(self.items.count != 0){
        _pictureRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
        CGRect titleRect = CGRectMake(0, rect.size.height - 20,
                                      rect.size.width - 80, 20);
        UILabel * title = [[UILabel alloc] initWithFrame: titleRect];
        self.contentSize = CGSizeMake(rect.size.width * self.items.count, rect.size.height);
        for(NSDictionary * d in [items allValues]){
            NSURL * url = [NSURL URLWithString: [d objectForKey: @"image"]];
            NSURLRequest * imgReq = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
            NSData * data= [NSURLConnection sendSynchronousRequest: imgReq returningResponse:nil error:nil];
            UIImage * img = [UIImage imageWithData: data];
            UIImageView * imgView = [[UIImageView alloc] initWithImage: img];
            imgView.frame = _pictureRect;
            [self addSubview: imgView];
            _pictureRect = CGRectMake(_pictureRect.origin.x + rect.size.width,
                                      _pictureRect.origin.y,
                                      rect.size.width,
                                      rect.size.height);
            title.text = [d objectForKey: @"title"];
            title.textColor = [UIColor whiteColor];
            title.backgroundColor = [UIColor clearColor];
            [self addSubview: title];
            CGRect f = CGRectMake(title.frame.origin.x + rect.size.width,
                                  title.frame.origin.y,
                                  title.frame.size.width,
                                  title.frame.size.height);
            title.frame = CGRectMake(title.frame.origin.x + rect.size.width,
                                      title.frame.origin.y,
                                      title.frame.size.width,
                                      title.frame.size.height);
             }
    }
}

@end
