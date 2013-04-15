//
//  WYACXCell.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYACXCell.h"

@implementation WYACXCell

@synthesize title, publisher, date, index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        title = [[UILabel alloc] init];
        publisher = [[UILabel alloc] init];
        date = [[UILabel alloc] init];
        index = [[UILabel alloc] init];
    }
    return self;
}

- (void) drawRect:(CGRect)rect{
    [super drawRect: rect];
    CGFloat space = 0.0;
    CGRect titleRect = CGRectMake(0, 0, self.frame.size.width, 30);
    CGRect publisherRect = CGRectMake(0, titleRect.origin.y + space + titleRect.size.height, self.frame.size.width, 30);
    CGRect dateRect = CGRectMake(0, publisherRect.origin.y + space + publisherRect.size.height, self.frame.size.width, 30);
    CGRect indexRect = CGRectMake(0, dateRect.origin.y + space + dateRect.size.height, self.frame.size.width, 30);
    title.font = [UIFont fontWithName: @"Arial" size: 20];
    title.textAlignment = UITextAlignmentCenter;
    publisher.font = [UIFont fontWithName: @"Arial" size: 15];
//    publisher.text = [NSMutableString stringWithFormat: @"【发布机构】："];
    date.font = [UIFont fontWithName: @"Arial" size: 15];
//    date.text = [NSMutableString stringWithFormat: @"【发布时间】："];
    index.font = [UIFont fontWithName: @"Arial" size: 15];
//    index.text = [NSMutableString stringWithFormat: @"【索引号】："];
    title.frame = titleRect;
    publisher.frame = publisherRect;
    date.frame = dateRect;
    index.frame = indexRect;
    title.backgroundColor = [UIColor clearColor];
    publisher.backgroundColor = [UIColor clearColor];
    date.backgroundColor = [UIColor clearColor];
    index.backgroundColor = [UIColor clearColor];
    [self addSubview: title];
    [self addSubview: publisher];
    [self addSubview: date];
    [self addSubview: index];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
