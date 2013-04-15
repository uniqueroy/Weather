//
//  WJTQXCell.m
//  Weather
//
//  Created by Roy Hsiao on 4/9/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WJTQXCell.h"
#import "Utilities.h"

@implementation WJTQXCell

@synthesize name, content;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        name = [[UILabel alloc] init];
        name.textColor = [UIColor orangeColor];
        name.backgroundColor = [UIColor clearColor];
        content = [[UITextView alloc] init];
        content.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) drawRect:(CGRect)rect{
    CGRect nameFrm = CGRectMake(rect.origin.x + 4, rect.origin.y, rect.size.width, 30);
    name.frame = nameFrm;
    [self addSubview: name];
    
    CGRect contentFrm = CGRectMake(nameFrm.origin.x + 15, nameFrm.origin.y + nameFrm.size.height + 4,
                                   rect.size.width - nameFrm.origin.x - 15,
                                   [Utilities heightForString: content.text fontSize: 14 andWidth: rect.size.width - nameFrm.origin.x - 15]);
    content.frame = contentFrm;
    [self addSubview: content];
    
}

@end
