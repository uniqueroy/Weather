//
//  WPickerview.h
//  Weather
//
//  Created by Roy Hsiao on 4/9/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPickerButtonDelegate;

@interface WPickerview : UIView

@property (strong, nonatomic) NSMutableDictionary * items;
@property (strong, nonatomic) NSMutableArray * buttonsArray;
@property (strong, nonatomic) id<WPickerButtonDelegate> delegate;

@end

@protocol WPickerButtonDelegate <NSObject>
- (void) goSwitch;
@end