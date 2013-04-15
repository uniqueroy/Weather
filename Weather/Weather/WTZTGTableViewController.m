//
//  WTZTGTableViewController.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WTZTGTableViewController.h"
#import "CustomNavigationBar.h"
#import "WTZTGCell.h"
#import "DataFactory.h"
#import "WTZTGListDataHanle.h"
#import "OperationQueueForServerAPIRequest.h"
#import "WaitUIView.h"
#import "Utilities.h"
#import "WTypeAViewController.h"
#import "Constants.h"

@interface WTZTGTableViewController ()

@end

@implementation WTZTGTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) updateUI{
    if([[_dataHandle getData] count] != 0){
        WTZTGListDataHanle * dataHandle = (WTZTGListDataHanle *)_dataHandle;
        [dataHandle makeIsReadDict];
        [self.tableView reloadData];
        [_waitView.indicator stopAnimating];
        [_waitView removeFromSuperview];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass: [WTZTGCell class] forCellReuseIdentifier: @"WTZTGCell"];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"cell"];
    
    UIImageView * background = [[UIImageView alloc] initWithFrame: self.tableView.frame];
    background.image = [UIImage imageNamed: @"cut_paperbg.png"];
    self.tableView.backgroundView = background;
    
    _waitView = [[WaitUIView alloc] initWithFrame: self.tableView.frame];
    [_waitView.indicator startAnimating];
    [self.tableView addSubview: _waitView];
    
    _dataHandle = [[WTZTGListDataHanle alloc] initWithUIDelegate: self firstNode: @"notificationlist" secondNode: nil];
    [DataFactory doDataWith: _dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[_dataHandle getData] count] != 0)
        return [[[_dataHandle getData] objectForKey: @"items"] count] + 1;
    return 0;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WTZTGCell";
    UITableViewCell * cell;
    if([[_dataHandle getData] count] != 0){
        if(indexPath.row == [[[_dataHandle getData] objectForKey: @"items"] count]){
            cell = [tableView dequeueReusableCellWithIdentifier: @"cell" forIndexPath: indexPath];
            cell.textLabel.text = @"加载更多";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
            NSDictionary * item = [[[_dataHandle getData] objectForKey: @"items"] objectAtIndex: indexPath.row];
            ((WTZTGCell *)cell).title.text = [item objectForKey: @"title"];
            ((WTZTGCell *)cell).date.text = [item objectForKey: @"date"];
            ((WTZTGCell *)cell).publisher.text = [item objectForKey: @"publisher"];
            
            if([((WTZTGListDataHanle *)_dataHandle) itemIsRead: [NSString stringWithFormat: @"item%d", indexPath.row]]){
                UIImage * img = [UIImage imageNamed: @"read.png"];
                ((WTZTGCell *)cell).isReadView.image = img;
            }
            else{
                UIImage * img = [UIImage imageNamed: @"unread.png"];
                ((WTZTGCell *)cell).isReadView.image = img;

            }
        }
    }

    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[_dataHandle getData] count] != 0){
        if(indexPath.row != [[[_dataHandle getData] objectForKey: @"items"] count])
            return 44 + 30;
    }
    return 44;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WTypeAViewController * next = [[WTypeAViewController alloc] init];
    next.dataTag = kTZTGD;
    NSArray * items = [[_dataHandle getData] objectForKey: @"items"];
    next.detailUrl = [[items objectAtIndex: indexPath.row] objectForKey: @"contentUrl"];
    [((WTZTGListDataHanle *)_dataHandle) setIsReadForItem: [NSString stringWithFormat: @"item%d", indexPath.row] withValue: [NSNumber numberWithBool: YES]];
    [self.navigationController pushViewController: next animated: YES];
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

@end
