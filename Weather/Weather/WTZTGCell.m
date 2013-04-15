//
//  WTZTGCell.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTZTGCell.h"

@implementation WTZTGCell

@synthesize title, publisher, date, isReadView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        title = [[UILabel alloc] init];
        date = [[UILabel alloc] init];
        publisher = [[UILabel alloc] init];
        isReadView = [[UIImageView alloc] initWithFrame: CGRectMake(5, 0, 44, 44)];
        title.font = [UIFont systemFontOfSize: 16];
        title.textAlignment = UITextAlignmentLeft;
        date.font = publisher.font = [UIFont systemFontOfSize: 12];
        publisher.textAlignment = UITextAlignmentLeft;
        date.textAlignment = UITextAlignmentRight;
        title.backgroundColor = [UIColor clearColor];
        date.backgroundColor = [UIColor clearColor];
        publisher.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) drawRect:(CGRect)rect{
    [super drawRect: rect];
    CGRect titleRect = CGRectMake(isReadView.frame.size.width + 10,
                                  0,
                                  self.frame.size.width - (0 + isReadView.frame.size.width + 5),
                                  30);
    CGRect publisherRect = CGRectMake(10,
                                 isReadView.frame.size.height,
                                 150,
                                 30);
    CGRect dateRect = CGRectMake(publisherRect.origin.x + publisherRect.size.width,
                                 publisherRect.origin.y,
                                 self.frame.size.width - publisherRect.size.width - 5,
                                 30);
    title.frame = titleRect;
    date.frame = dateRect;
    publisher.frame = publisherRect;
    [self addSubview: title];
    [self addSubview: publisher];
    [self addSubview: date];
    [self addSubview: isReadView];
}

@end
