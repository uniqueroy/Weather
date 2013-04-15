//
//  WDQYBTrendViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/18/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBTrendViewController.h"
#import "WDQYBTrendView.h"
#import "WDQYBTitleView.h"
#import "WDQYBTrendLabelView.h"
#import "WDQYBTrendPointView.h"

#import "WDQYBTrendDataHandle.h"
#import "WaitUIView.h"
#import "DataFactory.h"
#import "OperationQueueForServerAPIRequest.h"

@interface WDQYBTrendViewController ()
@end

@implementation WDQYBTrendViewController

@synthesize segment, waitView, dataHandle, dict, dayTempsDict, nightTempsDict;
@synthesize dateView, dayView, nightWeatherView, dayWeatherView, dayTrendView, nightTrendView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) updateUI{
    self.dict = self.dataHandle.getData;
    [self setDataToViews];
    [self.view setNeedsDisplay];
    [waitView removeFromSuperview];
}
- (void) exitWithError{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle: @"ERROR" message: @"occurs an error" delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alert show];
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0)
        [self.navigationController popViewControllerAnimated: YES];
}

- (void) fetchTemps{
    self.dayTempsDict = [[NSMutableDictionary alloc] init];
    self.nightTempsDict = [[NSMutableDictionary alloc] init];
    NSString * dayTempStr;
    NSString * nightTempStr;
    NSString * tempRange;
    NSRange waveSignRange;
    for(int i = 1; i <=6; i ++){
        tempRange = [self.dict objectForKey: [NSString stringWithFormat: @"temp%d", i]];
        waveSignRange = [tempRange rangeOfString: @"~"];
        nightTempStr = [tempRange substringToIndex: waveSignRange.location - 1];
        dayTempStr = [tempRange substringFromIndex: waveSignRange.location + 1];
        dayTempStr = [dayTempStr stringByTrimmingCharactersInSet: [NSCharacterSet symbolCharacterSet]];
        [self.dayTempsDict setValue: dayTempStr forKey: [NSString stringWithFormat: @"item%d", i - 1]];
        [self.nightTempsDict setValue: nightTempStr forKey: [NSString stringWithFormat: @"item%d", i - 1]];
    }
}

- (NSMutableArray *) weatherImages{
    UIImage * img;
    int i;
    NSMutableArray * first = [[NSMutableArray alloc] initWithCapacity: 6];
    NSMutableArray * second = [[NSMutableArray alloc] initWithCapacity: 6];
    NSMutableArray * returnAry = [[NSMutableArray alloc] initWithCapacity: 12];
    for(i = 1; i <= 6; i++){
        NSString * keyName = [NSString stringWithFormat: @"img%d", i];
        img = [UIImage imageNamed: [NSString stringWithFormat: @"w%@.png", [self.dict objectForKey: keyName]]];
        if(!img)    img = [UIImage imageNamed: @"ww13.png"];
        [first addObject: img];
    }
    [returnAry addObject: first];
    for(; i <= 12; i++){
        NSString * keyName = [NSString stringWithFormat: @"img%d", i];
        img = [UIImage imageNamed: [NSString stringWithFormat: @"w%@.png", [self.dict objectForKey: keyName]]];
        if(!img)    img = [UIImage imageNamed: @"ww13.png"];
        [second addObject: img];
    }
    [returnAry addObject: second];
    return returnAry;
}

- (void) changeDisplay{
    if(self.segment.selectedSegmentIndex == 0){
        NSMutableArray * array = [self weatherImages];
        [self.dayTrendView setWeatherImage: [array objectAtIndex: 0]];
        [self.nightTrendView setWeatherImage: [array objectAtIndex: 1]];
        [self.dayTrendView removeFromSuperview];
        [self.view addSubview: self.dayTrendView];
        [self.nightTrendView removeFromSuperview];
        [self.view addSubview: self.nightTrendView];
        
        
        NSMutableDictionary * testDict = [[NSMutableDictionary alloc] init];
        if([self.dict count] != 0){
            for(int i = 0; i < 6; i ++){
                NSString * str = [self.dict objectForKey: [NSString stringWithFormat: @"img_title%d", i + 1]];
                [testDict setValue: str forKey:[NSString stringWithFormat: @"item%d", i]];
            }
        }
        [self.dayWeatherView setText: testDict];
        [self.dayWeatherView removeFromSuperview];
        [self.view addSubview: self.dayWeatherView];
        if([self.dict count] != 0){
            for(int i = 0; i < 6; i ++){
                NSString * str = [self.dict objectForKey: [NSString stringWithFormat: @"img_title%d", i + 7]];
                [testDict setValue: str forKey:[NSString stringWithFormat: @"item%d", i]];
            }
        }
        [self.nightWeatherView setText: testDict];
        [self.nightWeatherView removeFromSuperview];
        [self.view addSubview: self.nightWeatherView];
        
    }else{
        [self.dayTrendView setWindImage];
        [self.nightTrendView setWindImage];
        [self.dayTrendView removeFromSuperview];
        [self.view addSubview: self.dayTrendView];
        [self.nightTrendView removeFromSuperview];
        [self.view addSubview: self.nightTrendView];
        NSMutableDictionary * items = [[NSMutableDictionary alloc] init];
        for(int i = 0; i < 6; i++)
            [items setValue: @"微风" forKey: [NSString stringWithFormat: @"item%d", i]];
        [self.dayWeatherView setText: items];
        [self.nightWeatherView setText: items];
    }
}

- (void) setDataToViews{
    [self fetchTemps];
    NSMutableArray * array = [self weatherImages];
    [self.dayTrendView setWeatherImage: [array objectAtIndex: 0]];
    [self.nightTrendView setWeatherImage: [array objectAtIndex: 1]];
    [self.dayTrendView setItemsDict: self.dayTempsDict];
    [self.nightTrendView setItemsDict: self.nightTempsDict];
    NSMutableDictionary * testDict = [[NSMutableDictionary alloc] init];
    if([self.dict count] != 0){
        for(int i = 0; i < 6; i ++){
            NSString * str = [self.dict objectForKey: [NSString stringWithFormat: @"img_title%d", i + 1]];
            [testDict setValue: str forKey:[NSString stringWithFormat: @"item%d", i]];
        }
    }
    [self.dayWeatherView setText: testDict];
    [self.dayWeatherView removeFromSuperview];
    [self.view addSubview: self.dayWeatherView];
    if([self.dict count] != 0){
        for(int i = 0; i < 6; i ++){
            NSString * str = [self.dict objectForKey: [NSString stringWithFormat: @"img_title%d", i + 7]];
            [testDict setValue: str forKey:[NSString stringWithFormat: @"item%d", i]];
        }
    }
    [self.nightWeatherView setText: testDict];
    [self.nightWeatherView removeFromSuperview];
    [self.view addSubview: self.nightWeatherView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dict = [[NSMutableDictionary alloc] init];
    
    UIImage * backgroundImage = [UIImage imageNamed: @"flashbg.png"];
    UIImageView * backgroundView = [[UIImageView alloc] initWithImage: backgroundImage];
    backgroundView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview: backgroundView];
    waitView = [[WaitUIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [waitView.indicator startAnimating];
    [self.view addSubview: waitView];
//    self.view = backgroundView;
    
    CGRect titleViewRect = CGRectMake(0, 0, self.view.frame.size.width, 40);
    WDQYBTitleView * titleView = [[WDQYBTitleView alloc] initWithFrame: titleViewRect];
    titleView.titleLabel.text = @"晋中温度趋势图";
    [self.view addSubview: titleView];
    
    self.segment = [[UISegmentedControl alloc] initWithItems: [NSArray arrayWithObjects: @"温度", @"风力", nil]];
    self.segment.frame = CGRectMake(0, 0, 200, 30);
    CGPoint segCenter = self.view.center;
    segCenter.y = self.view.bounds.origin.y + titleViewRect.size.height + self.segment.frame.size.height / 2 + 5;
    self.segment.center = segCenter;
    self.segment.segmentedControlStyle = 2;
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget: self action: @selector(changeDisplay) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview: self.segment];
    
    NSMutableDictionary * testDict = [[NSMutableDictionary alloc] initWithCapacity: 6];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * now = [NSDate date];
    NSDateComponents * comps = [calendar components: NSWeekdayCalendarUnit fromDate: now];
    NSInteger today = [comps weekday] + 6 - 7;
    
    [testDict setObject: @"今天" forKey: @"item0"];
    [testDict setObject: @"明天" forKey: @"item1"];
    for(int i = 2; i < 6; i ++){
        NSInteger theDay = today + i;
        if(theDay > 7) theDay -= 7;
        [testDict setObject: [NSString stringWithFormat: @"星期%d", theDay] forKey: [NSString stringWithFormat: @"item%d", i]];
    }
    
    CGRect dayRect = CGRectMake(0,
                                40 + 30 + 5, //heights of titleView and segment
                                self.view.frame.size.width, 25);
    self.dayView = [[WDQYBTrendLabelView alloc] initWithFrame: dayRect withDictionary: testDict];
    [self.view addSubview: self.dayView];
    
    for(int i = 0; i < 6; i ++)
        [testDict setValue: @"dayW" forKey: [NSString stringWithFormat: @"item%d", i]];
    CGRect dayWeatherRect = dayRect;
    dayWeatherRect.origin.y += 25;
    self.dayWeatherView = [[WDQYBTrendLabelView alloc] initWithFrame: dayWeatherRect withDictionary: testDict];
    [self.view addSubview: self.dayWeatherView];
    NSTimeInterval oneDay = 24 * 60 * 60;
    NSString * dateToDisplay;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"MM/dd"];
    for(int i = 0; i < 6; i ++){
        dateToDisplay = [NSString stringWithFormat: @"%@", [formatter stringFromDate:[now addTimeInterval: oneDay * i]]];
        [testDict setValue: dateToDisplay forKey: [NSString stringWithFormat: @"item%d", i]];
    }
    CGRect dateRect = CGRectMake(0, 460 - 48 - 20,
                                 self.view.frame.size.width, 25);
    self.dateView = [[WDQYBTrendLabelView alloc] initWithFrame: dateRect withDictionary: testDict];
    [self.view addSubview: self.dateView];
    
    for(int i = 0; i < 6; i ++)
        [testDict setValue: @"nightW" forKey: [NSString stringWithFormat: @"item%d", i]];
    CGRect nightWeatherRect = dateRect;
    nightWeatherRect.origin.y -= 25;
    self.nightWeatherView = [[WDQYBTrendLabelView alloc] initWithFrame: nightWeatherRect withDictionary: testDict];
    [self.view addSubview: self.nightWeatherView];
    
    
    // 60 is the half of WDQYBTrendPointView's height
    CGFloat yFromWhereToStart = titleView.frame.size.height + 5 + segment.frame.size.height + 80 + 60;
    CGFloat yInMid = 480 - 20 - 48 - yFromWhereToStart - 49;
//    CGFloat t = self.view.frame.origin.y + titleView.frame.size.height + 5 + segment.frame.size.height + 40;
    CGRect rrect = CGRectMake(0, yFromWhereToStart - 40,
                              self.view.frame.size.width, yInMid / 2 - 10);
    self.dayTrendView = [[WDQYBTrendView alloc] initWithFrame: rrect items: self.dayTempsDict];
    self.dayTrendView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.dayTrendView];
    
    
    
    CGRect rrrect = CGRectMake(0, yFromWhereToStart + yInMid / 2,
                               self.view.frame.size.width, yInMid / 2 - 20);
    self.nightTrendView = [[WDQYBTrendView alloc] initWithFrame: rrrect items: self.nightTempsDict];
    self.nightTrendView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.nightTrendView];
    
    
    
    self.dataHandle = [[WDQYBTrendDataHandle alloc] initWithUIDelegate:self firstNode: @"weatherinfo" secondNode: @""];
    [DataFactory doDataWith: self.dataHandle inQueue: [OperationQueueForServerAPIRequest sharedQueue]];


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
