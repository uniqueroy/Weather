//
//  WPickerview.m
//  Weather
//
//  Created by Roy Hsiao on 4/9/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WPickerview.h"
#import <QuartzCore/QuartzCore.h>
#import "Utilities.h"
#import "WPickerDetailViewController.h"

@implementation WPickerview

@synthesize items, buttonsArray, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [[NSMutableDictionary alloc] initWithCapacity: 0];
        self.buttonsArray = [[NSMutableArray alloc] initWithCapacity: 0];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    UIImageView * background = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"scrollerbg.png"]];
    background.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    [self addSubview: background];
    CGPoint itemOrigin = CGPointMake(rect.origin.x + 30, rect.origin.y + 3);
    UIFont * font = [UIFont fontWithName: @"Arial" size: 14];
    font = [UIFont boldSystemFontOfSize: 14];
    NSMutableDictionary * viewsDict = [[NSMutableDictionary alloc] initWithCapacity: 0];
    NSMutableDictionary * viewsWidthDict = [[NSMutableDictionary alloc] initWithCapacity: 0];
    if(self.items.count != 0){
        for(int i = 0; i < self.items.count; i ++){
            NSString * content = [self.items objectForKey: [NSString stringWithFormat: @"item%d", i]];
            CGFloat itemWidth = [self fitWidthWithContent: content withFont: font inHeight: rect.size.height - itemOrigin.y* 2];
            itemWidth += 4;
            UIButton * button = [UIButton buttonWithType: UIButtonTypeCustom];
            [button setTitle: content forState: UIControlStateNormal];
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.cornerRadius = 5.0f;
            button.layer.borderWidth = .5f;
            button.titleLabel.font = font;
            button.titleLabel.textColor = [UIColor whiteColor];
            button.titleLabel.textAlignment = UITextAlignmentLeft;
            button.backgroundColor = [UIColor clearColor];
            [button addTarget: delegate action: @selector(goSwitch) forControlEvents: UIControlEventTouchUpInside];
            [viewsDict setObject: button forKey: [NSString stringWithFormat: @"item%d", i]];
            [viewsWidthDict setObject: [NSNumber numberWithFloat: itemWidth] forKey: [NSString stringWithFormat: @"item%d", i]];
            [self.buttonsArray addObject: button];
        }
        
        CGFloat space = (rect.size.width - itemOrigin.x * 2);
        for(NSNumber * width in [viewsWidthDict allValues])
            space -= [width floatValue];
        space = space / (viewsDict.count - 1);
        
        for(int i = 0; i < viewsDict.count; i ++){
            UIButton * button = [viewsDict objectForKey: [NSString stringWithFormat: @"item%d", i]];
            CGFloat w = [[viewsWidthDict objectForKey: [NSString stringWithFormat: @"item%d", i]] floatValue];
            CGRect frame = CGRectMake(itemOrigin.x,
                                      itemOrigin.y,
                                      w,
                                      rect.size.height - itemOrigin.y * 2);
            button.frame = frame;
            [self addSubview: button];
            itemOrigin.x += (space + w);
        }
    }
}

- (CGFloat) fitWidthWithContent: (NSString *) content withFont: (UIFont *) font inHeight: (CGFloat) height{
    CGSize size = CGSizeMake(1000, height);
    CGSize constrain = [content sizeWithFont: font constrainedToSize: size];
    return constrain.width;
}

@end
