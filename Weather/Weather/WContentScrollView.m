//
//  WContentScrollView.m
//  Weather
//
//  Created by Roy Hsiao on 4/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WContentScrollView.h"
#import "Utilities.h"

@implementation WContentScrollView

@synthesize content = _content, totalHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width - 32, CGFLOAT_MAX) lineBreakMode: UILineBreakModeWordWrap];
    return sizeToFit.height + 32;
}

- (void) setContent{
    if(_content){
        for(int i = 0; i < [_content count]; i ++){
            NSArray * item = [[_content objectAtIndex: i] componentsSeparatedByString: @"$"];
            if([(NSString *)[item objectAtIndex: 0] isEqual: @"text"]){
                UITextView * textView = [[UITextView alloc] init];
                textView.userInteractionEnabled = NO;
                textView.scrollEnabled = NO;
                textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                textView.backgroundColor = [UIColor clearColor];
                textView.text = [item objectAtIndex: 1];
                CGFloat h = [self heightForString: textView.text fontSize: 12.0 andWidth: 320];
//                CGFloat h = [Utilities heightForTextView: textView WithText: [item objectAtIndex: 1]];
                textView.frame = CGRectMake(0, 0, 320, h);
                [_items addObject: textView];
                totalHeight += textView.frame.size.height;
            }
            else if([(NSString *)[item objectAtIndex: 0] isEqual: @"picture"]){
                UIImageView * imgView = [[UIImageView alloc] init];
                imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                NSData * data = [NSData dataWithContentsOfURL: [NSURL URLWithString: [item objectAtIndex: 1]]];
                imgView.image = [[UIImage alloc] initWithData: data];
                imgView.frame = CGRectMake(0, 0, imgView.image.size.width, imgView.image.size.height);
                if(imgView.image.size.width / 200 > 1){
                    CGFloat t = 200 / imgView.image.size.width;
                    imgView.frame = CGRectMake(0, 0, imgView.image.size.width * t, imgView.image.size.height * t);
                }
                [_items addObject: imgView];
                totalHeight += imgView.frame.size.height;
            }
        }
    }
}

- (id) init{
    self = [super init];
    if(self){
        _textQTY = 0;
        _picQTY = 0;
        _content = [[NSMutableArray alloc] init];
        _items = [[NSMutableArray alloc] init];
        totalHeight = 0.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor redColor];
    CGFloat height = 0.00;
    for(UIView * v in _items){
        v.center = CGPointMake(160, v.frame.size.height / 2 + height);
        [self addSubview: v];
        height += v.frame.size.height + 3;
    }
}

@end
