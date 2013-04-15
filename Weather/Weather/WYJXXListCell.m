//
//  WYJXXListCell.m
//  Weather
//
//  Created by Roy Hsiao on 3/8/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYJXXListCell.h"

@implementation WYJXXListCell
@synthesize readIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}


- (void) drawRect:(CGRect)rect{
    [super drawRect: rect];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x + 5,
                                      self.textLabel.frame.origin.y - 4,
                                      self.textLabel.frame.size.width,
                                      self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x,
                                      self.detailTextLabel.frame.origin.y + 6,
                                      self.detailTextLabel.frame.size.width,
                                      self.detailTextLabel.frame.size.height);
    self.textLabel.font = [UIFont boldSystemFontOfSize: 20];
    self.detailTextLabel.font = [UIFont fontWithName: @"Arial" size: 13];
    self.detailTextLabel.textColor = [UIColor blackColor];
    if(!self.readIcon){
        self.readIcon = [[UIImageView alloc] init];
        self.readIcon.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - 52 - 10,
                                         self.frame.origin.y + self.textLabel.frame.size.height / 2 - 3,
                                         52,
                                         44);
    }
}

- (void) drawReadIcon: (NSString *) isRead{
    self.readIcon.image = [UIImage imageNamed: isRead];
    [self addSubview: self.readIcon];
    [self.textLabel setNeedsDisplay];
    [self.detailTextLabel setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
