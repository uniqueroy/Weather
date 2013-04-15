//
//  WPictureScrollView.h
//  Weather
//
//  Created by Roy Hsiao on 4/15/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPictureScrollView : UIScrollView{
    UIPageControl * _pageControl;
    UILabel * _title;
    CGRect _pictureRect;
}
@property (strong, nonatomic) NSMutableDictionary * items;

@end
