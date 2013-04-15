//
//  WViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WViewController.h"
#import "Cell.h"
#import "WQXFWViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WQXFWTypeCViewController.h"
#import "WYACXTableViewController.h"
#import "WTZTGTableViewController.h"
#import "WSZYWViewController.h"

@interface WViewController ()

@end

@implementation WViewController

@synthesize nameList = _nameList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * plistPath = [bundle pathForResource: @"MainpageItems" ofType: @"plist"];
    NSMutableArray * mainpageItems = [[NSMutableArray alloc] initWithContentsOfFile: plistPath];
    self.nameList = mainpageItems;
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"返回";
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell * cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"CELL" forIndexPath: indexPath];
    int index = indexPath.row;
    NSString * imagePath = [NSString stringWithFormat: @"%@.png", self.nameList[index]];
    NSString * hightlightedImagePath = [NSString stringWithFormat: @"%@Highlighted.png", self.nameList[index]];
    cell.imageView.image = [UIImage imageNamed: imagePath];
    cell.imageView.highlightedImage = [UIImage imageNamed: hightlightedImagePath];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard * board = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    UIViewController * next = nil;
    if(indexPath.row == 0){
        next = [board instantiateViewControllerWithIdentifier: @"QXFWView"];
        next.title = @"气象服务";
        [self.navigationController pushViewController: next animated: YES];
    }else if (indexPath.row == 2){
        next = [board instantiateViewControllerWithIdentifier: @"YJXXTableView"];
        next.title = @"预警信息";
        [self.navigationController pushViewController: next animated:YES];
    }else if (indexPath.row == 3){
        next = [[WYACXTableViewController alloc] init];
        next.title = @"预案查询";
        [self.navigationController pushViewController: next  animated:YES];
    }else if(indexPath.row == 5){
        next = [[WTZTGTableViewController alloc] init];
        next.title = @"市委, 市政府通知";
        [self.navigationController pushViewController: next  animated: YES];
    }else if (indexPath.row == 6){
        next = [[WSZYWViewController alloc] init];
        next.title = @"市政要闻";
        [self.navigationController pushViewController: next animated:YES];
    }
    
    //QXFW-TypeA
}

- (void) willAppearIn: (UINavigationController *) navigationController{
    [UIView beginAnimations: nil context: NULL];
    [navigationController setNavigationBarHidden: YES animated: YES];
    [UIView commitAnimations];
}

@end
