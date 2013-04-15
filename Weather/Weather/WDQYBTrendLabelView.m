//
//  WDQYBTrendLabelView.m
//  Weather
//
//  Created by Roy Hsiao on 3/19/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTrendLabelView.h"

@implementation CustomizedLabel

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        self.textAlignment = UITextAlignmentCenter;
        self.font = [UIFont fontWithName: @"Arial" size: 12];
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@implementation WDQYBTrendLabelView

@synthesize first, second, third, forth, fifth, sixth, valuesDict, holderPlace, border;

- (void) setText: (NSMutableDictionary *) texts{
    first.text = [texts objectForKey: @"item0"];
    second.text = [texts objectForKey: @"item1"];
    third.text = [texts objectForKey: @"item2"];
    forth.text = [texts objectForKey: @"item3"];
    fifth.text = [texts objectForKey: @"item4"];
    sixth.text = [texts objectForKey: @"item5"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame withDictionary: (NSMutableDictionary *) dictionary{
    self = [super initWithFrame: frame];
    if(self){
        self.valuesDict = [[NSMutableDictionary alloc] initWithDictionary: dictionary];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //temp is the sum of all holderplaces and borders (2 borders and 4 holderplaces)
    CGFloat temp = rect.size.width - kLabelWidth * 5;
    self.border = temp / 6; //using integer is because we ignore the '.' part number and give it to the holderplace
    self.holderPlace = (temp - self.border * 2) / 4;
    
    CGRect firstRect = CGRectMake(self.bounds.origin.x + self.border, self.bounds.origin.y, kLabelWidth, kLabelHeight);
    CGRect secondRect = CGRectMake(firstRect.origin.x + kLabelWidth + self.holderPlace, self.bounds.origin.y, kLabelWidth, kLabelHeight);
    CGRect thirdRect = CGRectMake(secondRect.origin.x + kLabelWidth + self.holderPlace, self.bounds.origin.y, kLabelWidth, kLabelHeight);
    CGRect forthRect = CGRectMake(thirdRect.origin.x + kLabelWidth + self.holderPlace, self.bounds.origin.y, kLabelWidth, kLabelHeight);
    CGRect fifthRect = CGRectMake(forthRect.origin.x + kLabelWidth + self.holderPlace, self.bounds.origin.y, kLabelWidth, kLabelHeight);
    CGRect sixthRect = CGRectMake(fifthRect.origin.x + kLabelWidth + self.holderPlace, self.bounds.origin.y, kLabelWidth, kLabelHeight);
    
    self.first = [[CustomizedLabel alloc] initWithFrame: firstRect];
    self.first.text = [self.valuesDict objectForKey: @"item0"];
    self.second = [[CustomizedLabel alloc] initWithFrame: secondRect];
    self.second.text = [self.valuesDict objectForKey: @"item1"];
    self.third = [[CustomizedLabel alloc] initWithFrame: thirdRect];
    self.third.text = [self.valuesDict objectForKey: @"item2"];
    self.forth = [[CustomizedLabel alloc] initWithFrame: forthRect];
    self.forth.text = [self.valuesDict objectForKey: @"item3"];
    self.fifth = [[CustomizedLabel alloc] initWithFrame: fifthRect];
    self.fifth.text = [self.valuesDict objectForKey: @"item4"];
    self.sixth = [[CustomizedLabel alloc] initWithFrame: sixthRect];
    self.sixth.text = [self.valuesDict objectForKey: @"item5"];
    [self addSubview: self.first];
    [self addSubview: self.second];
    [self addSubview: self.third];
    [self addSubview: self.forth];
    [self addSubview: self.fifth];
    [self addSubview: self.sixth];
    
}

@end
