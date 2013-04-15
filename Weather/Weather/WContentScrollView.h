//
//  WContentScrollView.h
//  Weather
//
//  Created by Roy Hsiao on 4/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WContentScrollView : UIScrollView{
    NSMutableArray * _content;
    NSMutableArray * _items;
    NSInteger _textQTY;
    NSInteger _picQTY;
}
@property (strong, nonatomic) NSMutableArray * content;
@property (nonatomic) CGFloat totalHeight;
- (void) setContent;
@end
