//
//  WYJXXDetailViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/8/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYJXXDetailViewController : UIViewController{
    NSMutableDictionary * dict;
}
@property (strong, nonatomic) NSMutableDictionary * passValDict;

@property (strong, nonatomic) IBOutlet UILabel * issuerLabel;
@property (strong, nonatomic) IBOutlet UILabel * bannerLabel;
@property (strong, nonatomic) IBOutlet UITextView * content;
@property (strong, nonatomic) IBOutlet UIImageView * image;

@end
