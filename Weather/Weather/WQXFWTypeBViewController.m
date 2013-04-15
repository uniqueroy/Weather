//
//  WQXFWTypeBViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/11/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WQXFWTypeBViewController.h"
#import "WQHPJListDataHandle.h"
#import "WQHPJDetailDataHandle.h"
#import "WNYQXListDataHandle.h"
#import "WSHQXTableDataHandle.h"
#import "WJTQXTableDataHandle.h"
#import "WQXFWTypeAViewController.h"
#import "WaitUIView.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"
#import "WDisplayData.h"
#import "WDataHandleBase.h"
#import "WTypeAViewController.h"
#import "WSHQXCell.h"
#import "WJTQXCell.h"
#import "Utilities.h"
#import "CustomNavigationBar.h"

@interface WQXFWTypeBViewController ()
-(void) switchData;
@end

@implementation WQXFWTypeBViewController
@synthesize dataHandle, dataTag, dict, waitView;

- (void) updateUI{
    self.dict = self.dataHandle.getData;
    NSDictionary * immutable = [[NSMutableDictionary alloc] initWithDictionary: [self.dict objectForKey: @"items"]];
    for(int i = 0; i < [immutable count]; i ++){
        NSMutableDictionary * temp = [NSMutableDictionary dictionaryWithDictionary: [immutable objectForKey: [NSString stringWithFormat: @"item%d", i]]];
        [self.dataHandle.data.itemsRead setObject: temp forKey: [NSString stringWithFormat: @"item%d", i]];
    }
    for(NSMutableDictionary * d in [self.dataHandle.data.itemsRead allValues])
        [d setObject: [NSNumber numberWithBool: NO] forKey: @"isRead"];
    [self.tableView reloadData];
    [waitView removeFromSuperview];
}

- (void) switchData{
    switch (self.dataTag) {
        case kQHPJ:{
            self.dataHandle = [[WQHPJListDataHandle alloc] initWithUIDelegate:self firstNode: @"weathercommentlist" secondNode: @"items"];
            break;
        }
        case kNYQX:{
            self.dataHandle = [[WNYQXListDataHandle alloc] initWithUIDelegate:self firstNode: @"agriculturalcommentlist" secondNode: @"items"];
            break;
        }
        case kSHQX:{
            self.dataHandle = [[WSHQXTableDataHandle alloc] initWithUIDelegate:self firstNode: @"lifeindex" secondNode: @"indexlist"];
            break;
        }
        case kJTQX:{
            self.dataHandle = [[WJTQXTableDataHandle alloc] initWithUIDelegate:self firstNode: @"trafficlist" secondNode: @"items"];
            break;
        }
        default:{
            break;
            NSLog(@"error in switchData of B");
            return;
        }
    }
    [DataFactory doDataWith: dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.dataTag = kNONE;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"Cell"];
    [self.tableView registerClass: [WSHQXCell class] forCellReuseIdentifier: @"shqxCell"];
    [self.tableView registerClass: [WJTQXCell class] forCellReuseIdentifier: @"jtqxCell"];
    
    waitView = [[WaitUIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [waitView.indicator startAnimating];
    [self.view addSubview: waitView];
    [self.tableView setBackgroundView: [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"cut_paperbg.png"]]];
    
    
    // Get our custom nav bar
    CustomNavigationBar* customNavigationBar = (CustomNavigationBar*)self.navigationController.navigationBar;
    
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"titlebg_0.png"]];
    // Create a custom back button
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"navigationBarBackButton.png"] highlight:nil leftCapWidth:14.0];
    [customNavigationBar setText: @"返回" onBackButton: backButton];
    backButton.titleLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:218.0/225.0 alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self switchData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger r = [[self.dict objectForKey: @"items"] count];
    return r;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString * jtqxCellIdentifier = @"jtqxCell";
    static NSString * shqxCellIdentifier = @"shqxCell";
    UITableViewCell * cell;
    if(self.dataTag == kQHPJ || self.dataTag == kNYQX){
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell)
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        NSDictionary * items = [self.dict objectForKey: @"items"];
        NSDictionary * item = [items objectForKey: [[NSString alloc] initWithFormat: @"item%d", indexPath.row]];
        cell.textLabel.text = [item objectForKey: @"title"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize: 16];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        if(self.dataHandle.data.itemsRead){
            NSDictionary * itemForCell = [self.dataHandle.data.itemsRead objectForKey: [NSString stringWithFormat: @"item%d", indexPath.row]];
            NSNumber * numIsRead = [itemForCell objectForKey: @"isRead"];
            if(numIsRead){
                BOOL isRead = [numIsRead boolValue];
                if(isRead)
                    cell.imageView.image = [UIImage imageNamed: @"read.png"];
                else
                    cell.imageView.image = [UIImage imageNamed: @"unread.png"];
            }
            else    cell.imageView.image = [UIImage imageNamed: @"unread.png"];
        }
        return cell;
    }else if(self.dataTag == kSHQX){
        cell = (WSHQXCell *)[tableView dequeueReusableCellWithIdentifier:shqxCellIdentifier forIndexPath:indexPath];
        if(cell == nil)
            cell = (WSHQXCell *)[[WSHQXCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: shqxCellIdentifier];
        NSDictionary * items = [self.dict objectForKey: @"items"];
        NSDictionary * item = [items objectForKey: [[NSString alloc] initWithFormat: @"item%d", indexPath.row]];
        
        ((WSHQXCell *)cell).name.text = [NSString stringWithFormat: @"%@: ", [item objectForKey: @"name"]];
        ((WSHQXCell *)cell).name.textAlignment = UITextAlignmentLeft;
        ((WSHQXCell *)cell).rate.text = [item objectForKey: @"index"];
        ((WSHQXCell *)cell).content.text = [item objectForKey: @"content"];
        UIImage * img = [UIImage imageNamed: [NSString stringWithFormat: @"l%@.gif", [item objectForKey: @"id"]]];
        ((WSHQXCell *)cell).leftImage.image = img;
        cell.userInteractionEnabled = NO;
    }else if(self.dataTag == kJTQX){
        cell = (WJTQXCell *)[tableView dequeueReusableCellWithIdentifier:jtqxCellIdentifier forIndexPath:indexPath];
        if(cell == nil)
            cell = (WJTQXCell *)[[WJTQXCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: jtqxCellIdentifier];
        NSDictionary * items = [self.dict objectForKey: @"items"];
        NSDictionary * item = [items objectForKey: [[NSString alloc] initWithFormat: @"item%d", indexPath.row]];
        
        ((WJTQXCell *)cell).name.text = [NSString stringWithFormat: @"%@: ", [item objectForKey: @"title"]];
        ((WJTQXCell *)cell).name.textAlignment = UITextAlignmentLeft;
        ((WJTQXCell *)cell).name.font = [UIFont fontWithName: @"Arial" size: 18];
        ((WJTQXCell *)cell).content.text = [item objectForKey: @"content"];
        cell.userInteractionEnabled = NO;
    }
    return cell;
}


- (void) detailPageUpdate{
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataTag == kSHQX)
        return;
    UIView * next;
    switch (self.dataTag) {
        case kQHPJ:{
            next = [[WTypeAViewController alloc] init];
            ((WTypeAViewController *)next).dataTag = kQHPJD;
            break;
        }
        case kNYQX:{
            next = [[WTypeAViewController alloc] init];
            ((WTypeAViewController *)next).dataTag = kNYQXD;
            break;
        }
        case kJTQX:{
//            next.dataTag = kJTQX;
            break;
        }
        case kSHQX:{
//            next.dataTag = kSHQX;
            break;
        }
        default:
            break;
    }
    ((WTypeAViewController *)next).detailUrl = [[self.dataHandle.data.itemsRead objectForKey: [NSString stringWithFormat: @"item%d", indexPath.row]] objectForKey: @"request_url"];
    [self.navigationController pushViewController: ((WTypeAViewController *)next) animated: YES];
    NSNumber * isRead = [NSNumber numberWithBool: YES];
    [[self.dataHandle.data.itemsRead objectForKey: [NSString stringWithFormat: @"item%d", indexPath.row]] setObject: isRead forKey: @"isRead"];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.dataTag == kQHPJ || self.dataTag == kNYQX){
        return 44;
    }else if(self.dataTag == kSHQX){
        NSDictionary * items = [self.dict objectForKey: @"items"];
        NSDictionary * item = [items objectForKey: [[NSString alloc] initWithFormat: @"item%d", indexPath.row]];
        
        NSString * contentStr = [item objectForKey: @"content"];
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        UIImage * imgToCal = [UIImage imageNamed: @"l1.gif"];
        CGFloat h = [Utilities heightForString: contentStr
                                      fontSize: 12
                                      andWidth: cell.frame.size.width - imgToCal.size.width];
        return h;
    }else if(self.dataTag == kJTQX){
        NSDictionary * items = [self.dict objectForKey: @"items"];
        NSDictionary * item = [items objectForKey: [[NSString alloc] initWithFormat: @"item%d", indexPath.row]];
        NSString * contentStr = [item objectForKey: @"content"];
        CGFloat h = [Utilities heightForString: contentStr
                                      fontSize: 12
                                      andWidth: 320 - 19];
        return h + 30;
    }
    return 44;
}

- (void) willAppearIn: (UINavigationController *) navigationController{
    [UIView beginAnimations: nil context: NULL];
    [navigationController setNavigationBarHidden: NO animated: YES];
    [UIView commitAnimations];
}

@end
