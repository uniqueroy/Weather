//
//  WQXFWTypeAViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WQXFWTypeAViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WaitUIView.h"
#import "DataFactory.h"
#import "WYJXXDetailDataHandle.h"
#import "WZQYBDetailDataHandle.h"
#import "WQHYCDetailDataHandle.h"
#import "WDZZHDetailDataHandle.h"
#import "WSLHXDetailDataHandle.h"
#import "WQHPJDetailDataHandle.h"
#import "WNYQXDetailDataHandle.h"
#import "WDisplayData.h"
#import "OperationQueueForServerAPIRequest.h"


@interface WQXFWTypeAViewController ()
- (void) swithData;
@end

@implementation WQXFWTypeAViewController
@synthesize background, bannerLabel, content, image, redLineImage, dataTag, cellUrlStr, waitView, dict;
@synthesize dataHandle;

- (void) updateUI{
    self.dict = self.dataHandle.getData;
    [self setDataToViews];
    [self.view setNeedsDisplay];
    [waitView removeFromSuperview];
}

- (void) swithData{
    switch (self.dataTag) {
        case kYJXX:{
            self.dataHandle = [[WYJXXDetailDataHandle alloc] initWithUIDelegate: self
                                                                      firstNode: @"yjxxitem"
                                                                     secondNode: @""
                                                                        withUrl:self.cellUrlStr];
            break;
        }
        case kZQYB:{
            self.dataHandle = [[WZQYBDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"midforecast" secondNode: @""];
            break;
        }
        case kQHYC:{
            self.dataHandle = [[WQHYCDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"lastforecast" secondNode: @""];
            break;
        }
        case kSLHX:{
            self.dataHandle = [[WSLHXDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"forestfire" secondNode: @""];
            break;
        }
        case kDZZH:{
            self.dataHandle = [[WDZZHDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"geological" secondNode: @""];
            break;
        }
        case kQHPJD:{
            self.dataHandle = [[WQHPJDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"weathercomment" secondNode: @"" withUrl: self.cellUrlStr];
            break;
        }
        case kNYQXD:{
            self.dataHandle = [[WNYQXDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"agriculturalcomment" secondNode: @"" withUrl: self.cellUrlStr];
            break;
        }
            
        default:{
            break;
            NSLog(@"error in switchData of A");
            return;
        }
    }
    [DataFactory doDataWith: dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
}

- (void) setDataToViews{
    self.bannerLabel.text = [self.dict objectForKey: @"banner"];
    self.content.text = [self.dict objectForKey: @"content"];
    
    
    NSString * leftIconUrlStr = [NSString stringWithFormat: @"%@%@", kSERVER_URL, [dict objectForKey: @"image"]];
    NSURL * url = [NSURL URLWithString: leftIconUrlStr];
    NSURLRequest * r = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:1];
    NSData * imageData = [NSURLConnection sendSynchronousRequest: r returningResponse: nil error: nil];
    self.image.image = [UIImage imageWithData: imageData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataTag = kNONE;
    }
    return self;
}

//dismiss the keyboard
- (IBAction) resignKeyboardInView: (UIView *) view{
    for(UIView * v in view.subviews){
        if([v.subviews count] > 0)
            [self resignKeyboardInView: v];
        if([v isKindOfClass: [UITextView class]] || [v isKindOfClass: [UITextField class]])
           [v resignFirstResponder];
    }
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.redLineImage.image = [UIImage imageNamed: @"redline.png"];
    UIImage * image_bk = [UIImage imageNamed: @"cut_paperbg.png"];
    CGSize viewSize = self.view.bounds.size;
    self.background.image = [self scaleToSize: image_bk size: viewSize];
    self.content.backgroundColor = [UIColor clearColor];
    self.content.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    waitView = [[WaitUIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [waitView.indicator startAnimating];
    [self.view addSubview: waitView];
    [self.view bringSubviewToFront: waitView];
    
    //another thread
    [self swithData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) willAppearIn: (UINavigationController *) navigationController{
    [UIView beginAnimations: nil context: NULL];
    [navigationController setNavigationBarHidden: NO animated: YES];
    [UIView commitAnimations];
}

@end
