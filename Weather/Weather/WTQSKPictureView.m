//
//  WTQSKPictureView.m
//  Weather
//
//  Created by Roy Hsiao on 4/12/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTQSKPictureView.h"
#import "OperationQueueForServerAPIRequest.h"
#import "JSONKit.h"
#import <QuartzCore/QuartzCore.h>

NSInteger count = 0;

@implementation WTQSKPictureView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        count ++;
    }
    return self;
}

- (UIView *) drawPointWithxCenter: (NSString *) theX yCenter: (NSString *) theY{
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor orangeColor];
    CGFloat side = 4;
    CGFloat x = [theX floatValue];
    CGFloat y = [theY floatValue];
    CGPoint point = CGPointMake(x - side / 2, y - side / 2);
    CGRect vR = CGRectMake(point.x, point.y, side, side);
    v.frame = vR;
    return v;
}

- (void) drawLine: (NSArray *) pts{
    
}

- (void) drawColumnWithxCenter: (NSString *) theX yCenter: (NSString *) theY{
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor orangeColor];
    CGFloat width = 10;
    CGFloat x = [theX floatValue];
    CGFloat y = [theY floatValue];
    CGPoint point = CGPointMake(x - width / 2, y);
    CGFloat height = self.frame.size.height - y - 10;
    CGFloat space = (self.frame.size.height - 10) / 120;
    CGRect vR = CGRectMake(self.frame.origin.x + point.x,
                           self.frame.origin.y + y * space,
                           width, height);
    v.frame = vR;
    [self addSubview: v];
}

- (void) drawCoordinatesHorizontalLine: (CGFloat) theY context: (CGContextRef) context{
	CGContextSetRGBStrokeColor(context, 255.0, 255.0, 255.0, 1.0);
	CGContextSetLineWidth(context, .5);
	CGContextMoveToPoint(context, self.frame.origin.x + 30, theY);
	CGContextAddLineToPoint(context, self.frame.origin.x + self.frame.size.width - 30, theY);
	CGContextStrokePath(context);
}
- (void) drawCoordinatesVerticalLine: (CGContextRef) context{
	CGContextSetRGBStrokeColor(context, 255.0, 255.0, 255.0, 1.0);
	CGContextSetLineWidth(context, .5);
	CGContextMoveToPoint(context, self.frame.origin.x + 30 , self.frame.origin.y + 17);
	CGContextAddLineToPoint(context, self.frame.origin.x + 30, self.frame.size.height - 24);
	CGContextStrokePath(context);
}

- (void) drawRect:(CGRect)rect{
    @synchronized(self){
        [super drawRect: rect];
        NSArray * x = [_xy objectForKey: @"pivotx"];
        NSArray * y = [_xy objectForKey: @"values"];
        int temp = [[y objectAtIndex: 0] intValue];
        for(NSString * num in y)
            if([num intValue] > temp)   temp = num;
        NSMutableDictionary * finale = [[NSMutableDictionary alloc] initWithCapacity: 0];
        for(int i = 0; i < x.count; i++)
            [finale setObject: [y objectAtIndex: i] forKey: [x objectAtIndex: i]];
        int yPerCell = (rect.size.height - 40) / 8;
        int xPerCell = (rect.size.width - 20) / 8;
        int maxY = (temp / 8 + 1) * 8;
        int yPerValue = maxY / 8;
        CGRect yRect;
        //draw coordination x, y
        for(int j = 0; j < 9; j ++){
            yRect = CGRectMake(rect.origin.x,
                                      rect.size.height - 20 - rect.origin.y - yPerCell * j - 10,
                                      20, 10);
            UILabel * yLabel = [[UILabel alloc] init];
            yLabel.text = [NSString stringWithFormat: @"%d", j * yPerValue];
            yLabel.frame = yRect;
            yLabel.textAlignment = UITextAlignmentCenter;
            yLabel.textColor = [UIColor whiteColor];
            yLabel.backgroundColor = [UIColor clearColor];
            yLabel.font = [UIFont fontWithName: @"Arial" size: 10];
            [self addSubview: yLabel];
            [self drawCoordinatesHorizontalLine: yRect.origin.y + 5 context: UIGraphicsGetCurrentContext()];
        }
        for(int i = 0; i < 8; i++){
            CGRect xRect = CGRectMake(20 + rect.origin.x + xPerCell * i,
                                      rect.origin.y + rect.size.height - 20,
                                      20, 10);
            UILabel * xLabel = [[UILabel alloc] init];
            xLabel.frame = xRect;
            xLabel.text = [NSString stringWithFormat: @"%d", i + 1];
            xLabel.textAlignment = UITextAlignmentCenter;
            xLabel.textColor = [UIColor whiteColor];
            xLabel.backgroundColor = [UIColor clearColor];
            xLabel.font = [UIFont fontWithName: @"Arial" size: 10];
            [self addSubview: xLabel];
            [self drawColumnWithxCenter: [NSString stringWithFormat: @"%f", xLabel.center.x]
                               yCenter: [y objectAtIndex: i]];
        }
        [self drawCoordinatesVerticalLine: UIGraphicsGetCurrentContext()];
    }
}

- (id)initWithFrame:(CGRect)frame withImgUrl:(NSString *) theDataUrl{
    @synchronized(self){
        self = [super initWithFrame: frame];
        if(self){
            NSURL * dataUrl = [NSURL URLWithString: @"http://202.207.177.53:60/data/winddirect?station=B6556"];
            NSURLRequest * r = [NSURLRequest requestWithURL: dataUrl cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
            NSOperationQueue * q = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest: r
                                               queue: q
                                   completionHandler: ^(NSURLResponse * urlResponse, NSData * received, NSError * error){
                                       if(error){
                                           UIAlertView * a = [[UIAlertView alloc] initWithTitle: @"错误!" message: @"图片读取错误!" delegate: self cancelButtonTitle: @"返回" otherButtonTitles: nil];
                                           [a show];
                                           return ;
                                       }
                                       NSString * result = [[NSString alloc] initWithData: received encoding: NSUTF8StringEncoding];
                                       NSDictionary * dict = [result objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
                                       _xy = [dict objectForKey: @"chart"];
                                       [delegate updateScrollView: self];
                                   }];
        }
        return self;
    }
}

@end
