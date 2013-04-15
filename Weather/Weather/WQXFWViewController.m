//
//  WQXFWViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WQXFWViewController.h"
#import "WQXFWCell.h"
#import "WQXFWTypeBViewController.h"
#import "WDQYBTabBarController.h"
#import "WTypeAViewController.h"
#import "WTQSKViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomNavigationBar.h"
#import "WRadarViewController.h"
#import "WWXYTViewController.h"


@interface WQXFWViewController ()

@end

@implementation WQXFWViewController

@synthesize nameList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.scrollEnabled = NO;
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * listPath = [bundle pathForResource: @"QXFWItems" ofType: @"plist"];
    NSMutableArray * list = [[NSMutableArray alloc] initWithContentsOfFile: listPath];
    self.nameList = list;
    self.nameDict_CN = [[NSMutableDictionary alloc] initWithContentsOfFile: [bundle pathForResource: @"QXFWItemsCN" ofType: @"plist"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WQXFWCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"QXFWCELL" forIndexPath: indexPath];
    NSString * imageName = [NSString stringWithFormat: @"%@.png", [self.nameList objectAtIndex: indexPath.row]];
    cell.imageView.image = [UIImage imageNamed: imageName];
    cell.label.text = [NSString stringWithFormat: @"%@", [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]]];
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard * board = [UIStoryboard storyboardWithName: @"MainStoryboard" bundle: nil];
    UIViewController * next;
    switch (indexPath.row) {
        case duanqiyubao:{
            next = [board instantiateViewControllerWithIdentifier: @"DQYBTabBar"];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case zhongqiyubao:{
            next = [[WTypeAViewController alloc] init];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WTypeAViewController *)next setDataTag: kZQYB];
            ((WTypeAViewController *)next).redTitle.text = @"中 期 天 气 预 报";
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case qihouyuce:{
            next = [[WTypeAViewController alloc] init];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WTypeAViewController *)next setDataTag: kQHYC];
            ((WTypeAViewController *)next).redTitle.text = @"短 期 气 候 预 测";
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case senlinhuoxian:{
            next = [[WTypeAViewController alloc] init];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WTypeAViewController *)next setDataTag: kSLHX];
            ((WTypeAViewController *)next).redTitle.text = @"森 林 火 险 等 级 预 报";
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case dizhizaihai:{
            next = [[WTypeAViewController alloc] init];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WTypeAViewController *)next setDataTag: kDZZH];
            ((WTypeAViewController *)next).redTitle.text = @"地 质 灾 害 等 级 预 报";
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case qihoupingjia:{
            next = [board instantiateViewControllerWithIdentifier: @"QXFW-TypeB"];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WQXFWTypeBViewController *)next setDataTag: kQHPJ];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case nongyeqixiang:{
            next = [board instantiateViewControllerWithIdentifier: @"QXFW-TypeB"];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WQXFWTypeBViewController *)next setDataTag: kNYQX];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case shenghuoqixiang:{
            next = [board instantiateViewControllerWithIdentifier: @"QXFW-TypeB"];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WQXFWTypeBViewController *)next setDataTag: kSHQX];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case jiaotongqixiang:{
            next = [board instantiateViewControllerWithIdentifier: @"QXFW-TypeB"];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [(WQXFWTypeBViewController *)next setDataTag: kJTQX];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case tianqishikuang:{
            next = [[WTQSKViewController alloc] init];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case tianqileida:{
            next = [[WRadarViewController alloc] init];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }
        case weixingyuntu:{
            next = [[WWXYTViewController alloc] init];
            next.navigationItem.title = [self.nameDict_CN objectForKey: [self.nameList objectAtIndex: indexPath.row]];
            [self.navigationController pushViewController: next animated: YES];
            break;
        }

        default:
            break;
    }
}

- (void) willAppearIn: (UINavigationController *) navigationController{
//    [UIView beginAnimations: nil context: NULL];
    [navigationController setNavigationBarHidden: NO animated: YES];
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"main_bg_navbar.png"]];
    customNavigationBar.layer.borderWidth = 0;
    // Create a custom back button
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"navigationBarBackButton.png"] highlight:nil leftCapWidth:14.0];
    [customNavigationBar setText: @"返回" onBackButton: backButton];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [UIView commitAnimations];
}








@end
