//
//  WDQYBTrendView.m
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTrendView.h"
#import <QuartzCore/QuartzCore.h>
#import "WDQYBTrendPointView.h"

@implementation WDQYBTrendView
@synthesize todayPt, tmrPt, firstPt, secondPt, thirdPt, forthPt;
@synthesize tempItems, maxTemp, minTemp;
@synthesize todayImg, tmrImg, firstImg, secondImg, thirdImg, forthImg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items: (NSDictionary *) theItemsDict
{
    self = [super initWithFrame:frame];
    if (self) {
        self.todayPt = [[WDQYBTrendPointView alloc] initWithFrame: CGRectZero weatherImage: nil ptImage: nil temp: nil];
        self.tmrPt = [[WDQYBTrendPointView alloc] initWithFrame: CGRectZero weatherImage: nil ptImage: nil temp: nil];
        self.firstPt = [[WDQYBTrendPointView alloc] initWithFrame: CGRectZero weatherImage: nil ptImage: nil temp: nil];
        self.secondPt = [[WDQYBTrendPointView alloc] initWithFrame: CGRectZero weatherImage: nil ptImage: nil temp: nil];
        self.thirdPt = [[WDQYBTrendPointView alloc] initWithFrame: CGRectZero weatherImage: nil ptImage: nil temp: nil];
        self.forthPt = [[WDQYBTrendPointView alloc] initWithFrame: CGRectZero weatherImage: nil ptImage: nil temp: nil];
        if(theItemsDict)
        {
            self.tempItems = [NSDictionary dictionaryWithDictionary: theItemsDict];
            
            //TBD with the keywords
            self.minTemp = self.maxTemp = [(NSNumber *)[self.tempItems objectForKey: @"item0"] floatValue];
            for(int i = 0; i < [self.tempItems count]; i++){
                CGFloat tmp = [[self.tempItems objectForKey: [NSString stringWithFormat: @"item%d", i]] floatValue];
                if(tmp <= self.minTemp)
                    self.minTemp = tmp;
                if(tmp >= self.maxTemp)
                    self.maxTemp = tmp;
            }
            self.pointsForOneDegree = frame.size.height / (self.maxTemp - self.minTemp);
        }
        
    }
    return self;
}

- (void) setWeatherImage: (NSArray *) imgAry{
    self.todayPt.weather.image = [imgAry objectAtIndex: 0];
    self.tmrPt.weather.image = [imgAry objectAtIndex: 1];
    self.firstPt.weather.image = [imgAry objectAtIndex: 2];
    self.secondPt.weather.image = [imgAry objectAtIndex: 3];
    self.thirdPt.weather.image = [imgAry objectAtIndex: 4];
    self.forthPt.weather.image = [imgAry objectAtIndex: 5];
}

- (void) setWindImage{
    self.todayPt.weather.image = nil;
    self.tmrPt.weather.image = nil;
    self.firstPt.weather.image = nil;
    self.secondPt.weather.image = nil;
    self.thirdPt.weather.image = nil;
    self.forthPt.weather.image = nil;
}

- (void) setItemsDict: (NSDictionary *) theItemsDict{
    self.tempItems = [NSDictionary dictionaryWithDictionary: theItemsDict];
    
    //TBD with the keywords
    self.minTemp = self.maxTemp = [(NSNumber *)[self.tempItems objectForKey: @"item0"] floatValue];
    for(int i = 0; i < [self.tempItems count]; i++){
        CGFloat tmp = [[self.tempItems objectForKey: [NSString stringWithFormat: @"item%d", i]] floatValue];
        if(tmp <= self.minTemp)
            self.minTemp = tmp;
        if(tmp >= self.maxTemp)
            self.maxTemp = tmp;
    }
    self.pointsForOneDegree = self.frame.size.height / (self.maxTemp - self.minTemp);
    [self refreshUI];
}

- (void) refreshUI{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect: rect];
    if(self.tempItems)
    {
        CGRect ptRect = CGRectMake(0, 0, 40, 120);
        
        UIImage * ptImg = [UIImage imageNamed: @"trend_wind_p_bottom.png"];
//        UIImage * weatherImg = [UIImage imageNamed: @"ww13.png"];
        
        CGFloat toMinus = self.minTemp * self.pointsForOneDegree;
        
//        self.todayPt = [[WDQYBTrendPointView alloc] initWithFrame: ptRect weatherImage: weatherImg ptImage: ptImg temp:@""];
        self.todayPt.frame = ptRect;
//        self.todayPt.weather.image = self.todayImg;
        self.todayPt.pt.image = ptImg;
        todayPt.center = CGPointMake(25, rect.size.height - ([(NSNumber *)[self.tempItems objectForKey: @"item0"] floatValue] * self.pointsForOneDegree - toMinus));
        todayPt.temp.text = [NSString stringWithFormat: @"%@°", [self.tempItems objectForKey: @"item0"]];
        [self addSubview: todayPt];
        
//        self.tmrPt = [[WDQYBTrendPointView alloc] initWithFrame: ptRect weatherImage: weatherImg ptImage: ptImg temp:@""];
        self.tmrPt.frame = ptRect;
//        self.tmrPt.weather.image = self.tmrImg;
        self.tmrPt.pt.image = ptImg;
        tmrPt.center = CGPointMake(todayPt.center.x + 55, rect.size.height - ([(NSNumber *)[self.tempItems objectForKey: @"item1"] floatValue] * self.pointsForOneDegree - toMinus));
        tmrPt.temp.text = [NSString stringWithFormat: @"%@°", [self.tempItems objectForKey: @"item1"]];
        [self addSubview: tmrPt];
        
//        self.firstPt = [[WDQYBTrendPointView alloc] initWithFrame: ptRect weatherImage: weatherImg ptImage: ptImg temp:@""];
        self.firstPt.frame = ptRect;
//        self.firstPt.weather.image = self.firstImg;
        self.firstPt.pt.image = ptImg;
        firstPt.center = CGPointMake(tmrPt.center.x + 55, rect.size.height - ([(NSNumber *)[self.tempItems objectForKey: @"item2"] floatValue] * self.pointsForOneDegree - toMinus));
        firstPt.temp.text = [NSString stringWithFormat: @"%@°", [self.tempItems objectForKey: @"item2"]];
        [self addSubview: firstPt];
        
//        self.secondPt = [[WDQYBTrendPointView alloc] initWithFrame: ptRect weatherImage: weatherImg ptImage: ptImg temp:@""];
        self.secondPt.frame = ptRect;
//        self.secondPt.weather.image = self.secondImg;
        self.secondPt.pt.image = ptImg;
        secondPt.center = CGPointMake(firstPt.center.x + 55, rect.size.height - ([(NSNumber *)[self.tempItems objectForKey: @"item3"] floatValue] * self.pointsForOneDegree - toMinus));
        secondPt.temp.text = [NSString stringWithFormat: @"%@°", [self.tempItems objectForKey: @"item3"]];
        [self addSubview: secondPt];
        
//        self.thirdPt = [[WDQYBTrendPointView alloc] initWithFrame: ptRect weatherImage: weatherImg ptImage: ptImg temp:@""];
        self.thirdPt.frame = ptRect;
//        self.thirdPt.weather.image = self.thirdImg;
        self.thirdPt.pt.image = ptImg;
        thirdPt.center = CGPointMake(secondPt.center.x + 55, rect.size.height - ([(NSNumber *)[self.tempItems objectForKey: @"item4"] floatValue] * self.pointsForOneDegree - toMinus));
        thirdPt.temp.text = [NSString stringWithFormat: @"%@°", [self.tempItems objectForKey: @"item4"]];
        [self addSubview: thirdPt];
        
//        self.forthPt = [[WDQYBTrendPointView alloc] initWithFrame: ptRect weatherImage: weatherImg ptImage: ptImg temp:@""];
        self.forthPt.frame = ptRect;
//        self.forthPt.weather.image = self.forthImg;
        self.forthPt.pt.image = ptImg;
        forthPt.center = CGPointMake(thirdPt.center.x + 55, rect.size.height - ([(NSNumber *)[self.tempItems objectForKey: @"item5"] floatValue] * self.pointsForOneDegree - toMinus));
        forthPt.temp.text = [NSString stringWithFormat: @"%@°", [self.tempItems objectForKey: @"item5"]];
        [self addSubview: forthPt];
        
        //draw line
        [self drawLine];
        
    }
    
}

- (void) drawLine{
    // Drawing lines with a white stroke color
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    
    // Draw a connected sequence of line segments
    CGPoint addLines[] =
    {
        todayPt.center,
        tmrPt.center,
        firstPt.center,
        secondPt.center,
        thirdPt.center,
        forthPt.center
    };
    // Bulk call to add lines to the current path.
    // Equivalent to MoveToPoint(points[0]); for(i=1; i<count; ++i) AddLineToPoint(points[i]);
    CGContextAddLines(context, addLines, sizeof(addLines)/sizeof(addLines[0]));
    CGContextStrokePath(context);
}











@end
