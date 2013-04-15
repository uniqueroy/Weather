//
//  WYACXTableViewController.m
//  Weather
//
//  Created by Roy Hsiao on 4/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYACXTableViewController.h"
#import "CustomNavigationBar.h"
#import "WYACXCell.h"
#import "WYACXListDataHandler.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import "Utilities.h"
#import "WaitUIView.h"
#import "WTypeAViewController.h"
#import "Constants.h"

@interface WYACXTableViewController ()

@end

@implementation WYACXTableViewController

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
        WYACXListDataHandler * dataHandle = (WYACXListDataHandler *)_dataHandle;
        [dataHandle makeIsReadDict];
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass: [WYACXCell class] forCellReuseIdentifier: @"YACXItemCell"];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"Cell"];
    
    //Search bar
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    searchBar.delegate = self;
    searchBar.backgroundImage = [UIImage imageNamed: @"cut_paperbg.png"];
    self.tableView.tableHeaderView = searchBar;
    
    UIImageView * background = [[UIImageView alloc] initWithFrame: self.tableView.frame];
    background.image = [UIImage imageNamed: @"cut_paperbg.png"];
    [self.tableView setBackgroundView: background];
    
    _dataHandle = [[WYACXListDataHandler alloc] initWithUIDelegate: self firstNode: @"yacxlist" secondNode: nil];
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
    if([[[_dataHandle getData] objectForKey: @"items"] count] != 0)
        return [[[_dataHandle getData] objectForKey: @"items"] count] + 1;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"YACXItemCell";
    UITableViewCell * cell;
    
    //get data from datahandler
    if([[[_dataHandle getData] objectForKey: @"items"] count] != 0){
        if(indexPath.row == [[[_dataHandle getData] objectForKey: @"items"] count]){
            cell = [tableView dequeueReusableCellWithIdentifier: @"Cell"];
            cell.textLabel.text = @"加载更多";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.textLabel.font = [UIFont boldSystemFontOfSize: 20];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            NSDictionary * item = [[[_dataHandle getData] objectForKey: @"items"] objectAtIndex: indexPath.row];
            ((WYACXCell *)cell).title.text = [item objectForKey: @"title"];

            ((WYACXCell *)cell).publisher.text = [NSString stringWithFormat: @"【发布机构】：%@", [item objectForKey: @"publisher"]];
            ((WYACXCell *)cell).date.text = [NSString stringWithFormat: @"【发布时间】：%@", [item objectForKey: @"date"]];
            ((WYACXCell *)cell).index.text = [NSString stringWithFormat: @"【索引号】：%@", [item objectForKey: @"id"]];
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[_dataHandle getData] objectForKey: @"items"] count] != 0){
        if(indexPath.row == [[[_dataHandle getData] objectForKey: @"items"] count]){
            
        }else{
            NSDictionary * item = [[[_dataHandle getData] objectForKey: @"items"] objectAtIndex: indexPath.row];
            NSString * detailUrl = [item objectForKey: @"request_url"];
            WTypeAViewController * next = [[WTypeAViewController alloc] init];
            next.dataTag = kYACXD;
            next.detailUrl = detailUrl;
            [self.navigationController pushViewController: next animated: YES];
        }
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[[_dataHandle getData] objectForKey: @"items"] count] != 0){
        if([[[_dataHandle getData] objectForKey: @"items"] count] == indexPath.row)    return 44;
        else    return 123;
    }
    return 44;
}

#pragma mark - Search delegate

- (void) updateSearchString: (NSString *) theSearchString{
    
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton: YES animated: YES];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
    for(id cancelButton in searchBar.subviews){
        if([cancelButton isKindOfClass: [UIButton class]]){
            UIButton * cc = (UIButton *)cancelButton;
            UIImageView * cancelBackground = [[UIImageView alloc] initWithFrame: cc.frame];
            cancelBackground.image = [UIImage imageNamed: @"cut_paperbg.png"];
            [cc setTitle: @"取消" forState: UIControlStateNormal];
            [cc setBackgroundImage: [UIImage imageNamed: @"cut_paperbg.png"] forState: UIControlStateNormal];
        }
    }
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton: NO animated: YES];
    [searchBar resignFirstResponder];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    searchBar.text = @"";
    [self updateSearchString: searchBar.text];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    [self updateSearchString: searchBar.text];
    [searchBar resignFirstResponder];
}

- (void) willAppearIn: (UINavigationController *) navigationController{    
    [navigationController setNavigationBarHidden: NO animated: YES];
    CustomNavigationBar * customizedNavBar = (CustomNavigationBar *)self.navigationController.navigationBar;
    [customizedNavBar setBackgroundWith: [UIImage imageNamed: @"titlebg_0.png"]];
    UIButton * backButton = [customizedNavBar backButtonWith: [UIImage imageNamed: @"navigationBarBackButton.png"] highlight:nil leftCapWidth: 14.0];
    [customizedNavBar setText: @"返回" onBackButton: backButton];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: backButton];
}












@end
