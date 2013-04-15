//
//  CustomNavigationBar.h
//  Weather
//
//  Created by Roy Hsiao on 4/10/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UINavigationBar
{
    UIImageView *navigationBarBackgroundImage;
    CGFloat backButtonCapWidth;
    IBOutlet UINavigationController* navigationController;
}

@property (nonatomic, strong) UIImageView *navigationBarBackgroundImage;
@property (nonatomic, strong) IBOutlet UINavigationController* navigationController;

-(void) setBackgroundWith:(UIImage*)backgroundImage;
-(void) clearBackground;
-(UIButton*) backButtonWith:(UIImage*)backButtonImage highlight:(UIImage*)backButtonHighlightImage leftCapWidth:(CGFloat)capWidth;
-(void) setText:(NSString*)text onBackButton:(UIButton*)backButton;
@end
