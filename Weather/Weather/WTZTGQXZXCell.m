//
//  WTZTGQXZXCell.m
//  Weather
//
//  Created by Roy Hsiao on 4/15/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTZTGQXZXCell.h"
#import "Utilities.h"

@implementation WTZTGQXZXCell

@synthesize titleLabel, publisherLabel, dateLabel, pictureView, height;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLabel = [[UILabel alloc] init];
        publisherLabel = [[UILabel alloc] init];
        dateLabel = [[UILabel alloc] init];
        publisherLabel.textAlignment = UITextAlignmentLeft;
        dateLabel.textAlignment = UITextAlignmentRight;
        dateLabel.textColor = [UIColor grayColor];
        publisherLabel.textColor = [UIColor grayColor];
        dateLabel.font = [UIFont systemFontOfSize: 14];
        publisherLabel.font = [UIFont systemFontOfSize: 14];
        pictureView = [[UIImageView alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        publisherLabel.backgroundColor = [UIColor clearColor];
        dateLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        self.titleLabel.numberOfLines = 0;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) drawRect:(CGRect)rect{
    titleLabel.frame = CGRectMake(5, 0, self.frame.size.width - 60, 40);
    publisherLabel.frame = CGRectMake(10, titleLabel.frame.size.height + 2,
                                                                80, 20);
    dateLabel.frame = CGRectMake(10 +publisherLabel.frame.size.width,
                                                           publisherLabel.frame.origin.y,
                                                           self.frame.size.width - 60 - publisherLabel.frame.size.width - 10,
                                                           20);
    pictureView.frame = CGRectMake(titleLabel.frame.size.width + 5, 0, 60, 60);
    [self addSubview: self.titleLabel];
        [self addSubview: self.publisherLabel];
        [self addSubview: self.dateLabel];
        [self addSubview: self.pictureView];

}

@end
