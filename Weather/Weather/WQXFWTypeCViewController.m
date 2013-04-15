//
//  WQXFWTypeCViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/14/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WQXFWTypeCViewController.h"

#import "WSZYWTableDataHandle.h"
#import "WQXFWTypeAViewController.h"
#import "WaitUIView.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"

@interface WQXFWTypeCViewController ()
-(void) switchData;
@end

@implementation WQXFWTypeCViewController

@synthesize dataHandle, dataTag, dict, waitView;

@synthesize segment, tableView;

- (void) updateUI{
    self.dict = self.dataHandle.getData;
    [self.tableView reloadData];
    [waitView removeFromSuperview];
    NSLog(@"Done");
}

- (void) switchData{
//    NSOperationQueue * q = [[NSOperationQueue alloc] init];
    switch (self.dataTag) {
        case kSZYW_DUP:{
            self.dataHandle = [[WSZYWTableDataHandle alloc] initWithUIDelegate:self firstNode: @"newslist" secondNode: @"items" type: @"1"];
            break;
        }
        default:{
            break;
            NSLog(@"error in switchData of C");
            return;
        }
    }
    [DataFactory doDataWith: dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) init{
    self = [super init];
    if(self){
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"TypeCCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //Add segmented bar
    self.segment = [[UISegmentedControl alloc] initWithItems: [[NSArray alloc] initWithObjects: @"本市时政", @"县区动态", @"部门动态", nil]];
    self.segment.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segment;
    
    //Spinning
    waitView = [[WaitUIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [waitView.indicator startAnimating];
    [self.view addSubview: waitView];
    
    [self switchData];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dict objectForKey: @"items"] count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"TypeCCell" forIndexPath: indexPath];
    NSDictionary * tempDic = [self.dict objectForKey: @"items"];
    NSString * itemNum = [NSString stringWithFormat: @"item%d", indexPath.row];
    cell.textLabel.text = [[tempDic objectForKey: itemNum] objectForKey: @"title"];
    cell.detailTextLabel.text = [[tempDic objectForKey: itemNum] objectForKey: @"date"];
    [cell.detailTextLabel setHidden: NO];
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 列寬
    CGFloat contentWidth = self.tableView.frame.size.width;
    // 用何種字體進行顯示
    UIFont * font;
    if(indexPath.row == 0)
        font = [UIFont systemFontOfSize:14];
    else
        font = [UIFont systemFontOfSize:44];
    // 該行要顯示的內容
    NSDictionary * tempDic = [self.dict objectForKey: @"items"];
    NSString * itemNum = [NSString stringWithFormat: @"item%d", indexPath.row];
    NSString *content = [[tempDic objectForKey: itemNum] objectForKey: @"title"];
    // 計算出顯示完內容需要的最小尺寸
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
    // 這裏返回需要的高度
    return size.height+20;
}

- (void) willAppearIn: (UINavigationController *) navigationController{
    [UIView beginAnimations: nil context: NULL];
    [navigationController setNavigationBarHidden: NO animated: YES];
    [UIView commitAnimations];
}

@end
