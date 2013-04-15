//
//  WYJXXTableViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WYJXXTableViewController.h"

#import "WYJXXListDataHandle.h"
#import "WYJXXListCell.h"
#import "WTypeAViewController.h"
#import "WaitUIView.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import "Constants.h"

#import "CustomNavigationBar.h"

@interface WYJXXTableViewController ()

@end

@implementation WYJXXTableViewController
@synthesize waitView, dict, dataHandle;
- (void) updateUI{
    self.dict = self.dataHandle.getData;
    [self.tableView reloadData];
    [waitView removeFromSuperview];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * background= [[UIImageView alloc] init];
    background.frame = self.tableView.frame;
    background.image = [UIImage imageNamed: @"cut_paperbg.png"];
    [self.tableView setBackgroundView: background];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"Cell"];
    [self.tableView registerClass: [WYJXXListCell class] forCellReuseIdentifier: @"YJXXListCell"];
    _loadMore = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"Cell"];
    waitView = [[WaitUIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [waitView.indicator startAnimating];
    [self.tableView addSubview: waitView];
    
    
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"titlebg_0.png"]];
    // Create a custom back button
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"navigationBarBackButton.png"] highlight:nil leftCapWidth:14.0];
    [customNavigationBar setText: @"返回" onBackButton: backButton];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //Setup a thread to load data
    dataHandle = [[WYJXXListDataHandle alloc] initWithUIDelegate: self firstNode: @"yjxxlist" secondNode: @"items"];
    [DataFactory doDataWith: dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger r = [[self.dict objectForKey: @"items"] count];
    return r + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"YJXXListCell";
    WYJXXListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath: indexPath];
    if(!cell)
        cell = [[WYJXXListCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
    NSInteger count = [[self.dict objectForKey: @"items"] count];
    if(indexPath.row == count && count != 0){
        _loadMore.textLabel.text = @"加载更多";
        _loadMore.textLabel.textAlignment = UITextAlignmentCenter;
        _loadMore.textLabel.font = [UIFont boldSystemFontOfSize: 20];
        return _loadMore;
    }
    NSDictionary * items = [self.dict objectForKey: @"items"];
    NSDictionary * item = [items objectForKey: [[NSString alloc] initWithFormat: @"item%d", indexPath.row]];
    //Request for left icon
    NSString * imgName = [NSString stringWithFormat: @"dw%@.png", [item objectForKey: @"id"]];
    cell.imageView.image = [UIImage imageNamed: imgName];
    [cell drawReadIcon: @"unread.png"];
//    cell.readIcon.image = [UIImage imageNamed: @"unread.png"];
    
    cell.textLabel.text = [item objectForKey: @"title"];
    NSMutableString * publishInfo = [NSMutableString stringWithFormat: @"%@", [item objectForKey: @"publisher"]];
    [publishInfo appendString: @"    "];
    [publishInfo appendString: [NSString stringWithFormat: @"%@", [item objectForKey: @"date"]]];
    cell.detailTextLabel.text = publishInfo;
    cell.nextUrl = [NSString stringWithFormat: @"%@", [item objectForKey: @"request_url"]];
    return cell;
}

#pragma mark - Table view delegate

- (void) loadMore{
    NSMutableArray *more;
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
}

-(void) appendTableWith:(NSMutableArray *)data{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = [[self.dict objectForKey: @"items"] count];
    if(indexPath.row == count && count != 0){
        _loadMore.textLabel.text = @"Loading more...";
        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    WTypeAViewController * pushNext = [[WTypeAViewController alloc] init];
    NSString *theCellUrlStr = [[NSString alloc] initWithString: [(WYJXXListCell *)[tableView cellForRowAtIndexPath: indexPath] nextUrl]];
    pushNext.detailUrl = theCellUrlStr;
    pushNext.dataTag = kYJXX;
    [self.navigationController pushViewController: pushNext animated: YES];


}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger count = [[self.dict objectForKey: @"items"] count];
    if(count == indexPath.row)
        return 44;
    return 60;
}

- (void) willAppearIn: (UINavigationController *) navigationController{
    [UIView beginAnimations: nil context: NULL];
    [navigationController setNavigationBarHidden: NO animated: YES];
    [UIView commitAnimations];
}

@end
