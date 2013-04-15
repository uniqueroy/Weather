//
//  WTQSKPictureView.h
//  Weather
//
//  Created by Roy Hsiao on 4/12/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSInteger count;

@protocol WTQSKPictureViewDelegate;

@interface WTQSKPictureView : UIView{
    NSString * _imgUrl;
    NSDictionary * _xy;
}

@property (strong, nonatomic) id<WTQSKPictureViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withImgUrl:(NSString *) theDataUrl;
@end



@protocol WTQSKPictureViewDelegate <NSObject>

- (void) updateScrollView:(WTQSKPictureView *) imgView;

@end