//
//  WQXFWTypeAViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "WNetworkUtil.h"
#import "WDataHandleBase.h"

@class WaitUIView;

@protocol WNetworkUtilDelegate;

@interface WQXFWTypeAViewController : UIViewController<WNetworkUtilDelegate>
@property (copy, nonatomic) NSString * cellUrlStr;
@property (assign, nonatomic) enum dataTag dataTag;
@property (strong, nonatomic) NSMutableDictionary * dict;
@property (strong, nonatomic) WaitUIView * waitView;
@property (strong, nonatomic) WDataHandleBase * dataHandle;


@property (strong, nonatomic) IBOutlet UILabel * bannerLabel;
@property (strong, nonatomic) IBOutlet UITextView * content;
@property (strong, nonatomic) IBOutlet UIImageView * image;
@property (strong, nonatomic) IBOutlet UIImageView * redLineImage;
@property (strong, nonatomic) IBOutlet UIImageView * background;

- (IBAction) resignKeyboardInView: (UIView *) view;

@end
