//
//  WJTQXCell.m
//  Weather
//
//  Created by Roy Hsiao on 4/8/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WSHQXCell.h"
#import "Utilities.h"

@implementation WSHQXCell

@synthesize rate, content, name, leftImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        leftImage = [[UIImageView alloc] init];
        name = [[UILabel alloc] init];
        name.backgroundColor = [UIColor clearColor];
        rate = [[UILabel alloc] init];
        rate.backgroundColor = [UIColor clearColor];
        content = [[UITextView alloc] init];
        content.backgroundColor = [UIColor clearColor];
        content.userInteractionEnabled = NO;
    }
    return self;
}

- (void) drawRect:(CGRect)rect{
    [super drawRect: rect];
    
    CGRect imgFrm = CGRectMake(rect.origin.x + 6, rect.origin.y, 44, 44);
    self.leftImage.frame = imgFrm;
    self.leftImage.center = CGPointMake((rect.origin.x + 6 + 44) / 2, rect.size.height / 2);
    [self addSubview: leftImage];
    
    CGRect textRect = CGRectMake(self.leftImage.frame.origin.x + self.leftImage.frame.size.width + 5,
                                 rect.origin.y,
                                 150, 20);
    self.name.frame = textRect;
    [self addSubview: name];
    rate.frame = CGRectMake(self.name.frame.origin.x + self.name.frame.size.width, self.name.frame.origin.y,
                            rect.size.width - self.name.frame.size.width, self.name.frame.size.height);
    rate.font = self.name.font;
    [self addSubview: rate];
    content.frame= CGRectMake(self.leftImage.frame.origin.x + self.leftImage.frame.size.width + 5,
                              self.name.frame.origin.y + self.name.frame.size.height,
                              rect.size.width - self.leftImage.frame.size.width,
                              [Utilities heightForString: content.text fontSize: 14 andWidth: rect.size.width - self.leftImage.frame.size.width - 5]);
    [self addSubview: content];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
