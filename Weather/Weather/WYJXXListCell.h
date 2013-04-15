//
//  WYJXXListCell.h
//  Weather
//
//  Created by Roy Hsiao on 3/8/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYJXXListCell : UITableViewCell
@property (strong, nonatomic) UIImageView * readIcon;

@property (copy, nonatomic) NSString * nextUrl;

- (void) drawReadIcon: (NSString *) isRead;

@end
