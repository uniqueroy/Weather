//
//  WSZYWViewController.m
//  Weather
//
//  Created by Roy Hsiao on 4/15/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WSZYWViewController.h"
#import "CustomNavigationBar.h"
#import "WPictureScrollView.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import "WSZYWTableDataHandle.h"
#import "WaitUIView.h"
#import "WDisplayData.h"
#import "WTZTGQXZXCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Utilities.h"

@interface WSZYWViewController ()

@end

@implementation WSZYWViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tableView = [[UITableView alloc] init];
    }
    return self;
}

- (void) updateUI{
    if(_dataHandle.data.dataDictionary.count != 0){
        [_tableView reloadData];
        [_waitView removeFromSuperview];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * background =[[UIImageView alloc] initWithFrame: _tableView.frame];
    background.image = [UIImage imageNamed: @"cut_paperbg.png"];
    _tableView.backgroundView = background;
    [_tableView registerClass: [WTZTGQXZXCell class] forCellReuseIdentifier: @"TZTGCell"];
    [_tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"Cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0,
                                  80,
                                  self.view.frame.size.width,
                                  self.view.frame.size.height - 80);
    [self.view addSubview: _tableView];
    _waitView = [[WaitUIView alloc] initWithFrame: _tableView.frame];
    [_waitView.indicator startAnimating];
    [_tableView addSubview: _waitView];
    _dataHandle = [[WSZYWTableDataHandle alloc] initWithUIDelegate: self firstNode: @"newslist" secondNode: nil type:@"1"];
    [DataFactory doDataWith: _dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation Bar
- (void) willAppearIn: (UINavigationController *) navigationController{
    [navigationController setNavigationBarHidden: NO animated: NO];
    
    CustomNavigationBar * customizedNav = (CustomNavigationBar *) self.navigationController.navigationBar;
    [customizedNav setBackgroundWith: [UIImage imageNamed: @"titlebg_0.png"]];
    UIButton * backButton = [customizedNav backButtonWith: [UIImage imageNamed: @"navigationBarBackButton.png"] highlight: nil leftCapWidth: 14.0];
    [customizedNav setText: @"返回" onBackButton: backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: backButton];
}

#pragma mark - Tableview delegate and datasource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([[_dataHandle getData] count] != 0){
        return [[[_dataHandle getData] objectForKey: @"items"] count] + 1;
    }
    return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    if([[_dataHandle getData] count] != 0){
        if(indexPath.row == [[[_dataHandle getData] objectForKey: @"items"] count]){
            cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath: indexPath];
            cell.textLabel.text = @"加载更多";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }else{
            cell = [_tableView dequeueReusableCellWithIdentifier: @"TZTGCell" forIndexPath: indexPath];
            NSArray * items = [[_dataHandle getData] objectForKey: @"items"];
            NSDictionary * item = [items objectAtIndex: indexPath.row];
            NSString * content = [item objectForKey: @"title"];
            CGFloat h = [Utilities calculateLabelHeightWithContent: content
                                                                       withFont: [UIFont systemFontOfSize: 16]
                                                                 withLabelWidth: 260];
            ((WTZTGQXZXCell *)cell).height = h;
            ((WTZTGQXZXCell *)cell).titleLabel.text = [NSString stringWithFormat: @"%@", content];
            ((WTZTGQXZXCell *)cell).publisherLabel.text = [NSString stringWithFormat: @"%@", [item objectForKey: @"banner"]];
            ((WTZTGQXZXCell *)cell).dateLabel.text = [NSString stringWithFormat: @"%@", [item objectForKey: @"date"]];
            UIImage * img = [UIImage imageNamed: @"image_download_fail_icon.png"];
            if(![[item objectForKey: @"image"] isEqualToString: @""]){
            NSURL * url = [NSURL URLWithString: [item objectForKey: @"image"]];
            NSURLRequest * imgR = [[NSURLRequest alloc] initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
            NSData * received = [NSURLConnection sendSynchronousRequest: imgR returningResponse: nil error: nil];
            img = [[UIImage alloc] initWithData: received];
            }
            ((WTZTGQXZXCell *)cell).pictureView.image = img;
        }
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[_dataHandle getData] count] != 0){
        if(indexPath.row != [[[_dataHandle getData] objectForKey: @"items"] count])
            return 66;
    }
    return 44;
}

@end
