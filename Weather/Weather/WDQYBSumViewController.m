//
//  WDZYBSumViewController.m
//  Weather
//
//  Created by Roy Hsiao on 3/17/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDQYBSumViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WDQYBTitleView.h"

#import "WaitUIView.h"
#import "DataFactory.h"
#import "WDQYBTodayDetailDataHandle.h"
#import "WDQYBTrendDataHandle.h"
#import "WDisplayData.h"
#import "OperationQueueForServerAPIRequest.h"
#import "Utilities.h"

@interface WDQYBSumViewController ()

@end

@implementation WDQYBSumViewController
@synthesize tempLabel, firstDay, firstDayImgView, firstDayTemp, secondDay, secondDayImgView, secondDayTemp, thirdDay, thirdDayImgView, thirdDayTemp, forthDay, forthDayImgView, forthDayTemp, todayDate, todayTemp, todayWeather, todayWindy, todayPublishTime;
@synthesize waitView, dataHandle1, dataHandle2, todayDict, trendDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) updateUI{
    if([[self.dataHandle1 getData] count] != 0)
        self.todayDict = [self.dataHandle1 getData];
    if([[self.dataHandle2 getData] count] != 0)
        self.trendDict = [self.dataHandle2 getData];;
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

- (void) setDataToViews{
    self.todayWeather.text = [self.trendDict objectForKey: @"img_title1"];
    self.todayPublishTime.text = [NSString stringWithFormat: @"今天%@发布", [self.todayDict objectForKey: @"time"]];
    self.todayTemp.text = [self.trendDict objectForKey: @"temp1"];
    self.tempLabel.text = [NSString stringWithFormat: @"%@℃", [self.todayDict objectForKey: @"temp"]];
    self.todayWindy.text = [self.todayDict objectForKey: @"WD"];
    self.todayWindy.text = [self.todayWindy.text stringByAppendingString: [self.todayDict objectForKey: @"WS"]];
    NSDate * now = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MM/dd"];
    self.todayDate.text = [dateFormatter stringFromDate: now];
    NSString * nongLi = [NSString stringWithString: [Utilities getChineseCalendarWithDate: now]];
    self.todayDate.text = [self.todayDate.text stringByAppendingString: [NSString stringWithFormat: @"  %@", nongLi]];
    
    NSDateComponents * comps;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    comps = [calendar components: NSWeekdayCalendarUnit fromDate: now];
    
    NSInteger first = [comps weekday] + 6 - 7 + 1;
    if(first > 7)
        first -= 7;
    self.firstDay.text = [NSString stringWithFormat: @"星期%d", first];
    self.firstDayTemp.text = [self.trendDict objectForKey: @"temp2"];
    self.firstDayImgView.image = [UIImage imageNamed: [NSString stringWithFormat: @"w%@.png", [self.trendDict objectForKey: @"img2"]]];
    
    
    NSInteger second = [comps weekday] + 6 - 7 + 2;
    if(second > 7)
        second -= 7;
    self.secondDay.text = [NSString stringWithFormat: @"星期%d", second];
    self.secondDayTemp.text = [self.trendDict objectForKey: @"temp3"];
    self.secondDayImgView.image = [UIImage imageNamed: [NSString stringWithFormat: @"w%@.png", [self.trendDict objectForKey: @"img3"]]];
    
    
    NSInteger third = [comps weekday] + 6 - 7 + 3;
    if(third > 7)
        third -= 7;
    self.thirdDay.text = [NSString stringWithFormat: @"星期%d", third];
    self.thirdDayTemp.text = [self.trendDict objectForKey: @"temp4"];
    self.thirdDayImgView.image = [UIImage imageNamed: [NSString stringWithFormat: @"w%@.png", [self.trendDict objectForKey: @"img4"]]];
    
    
    NSInteger forth = [comps weekday] + 6 - 7 + 4;
    if(forth > 7)
        forth -= 7;
    self.forthDay.text = [NSString stringWithFormat: @"星期%d", forth];
    self.forthDayTemp.text = [self.trendDict objectForKey: @"temp5"];
    self.forthDayImgView.image = [UIImage imageNamed: [NSString stringWithFormat: @"w%@.png", [self.trendDict objectForKey: @"img4"]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    waitView = [[WaitUIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [waitView.indicator startAnimating];
    
    self.firstDay = [[UILabel alloc] init];
    self.firstDayTemp = [[UILabel alloc] init];
    self.firstDayImgView = [[UIImageView alloc] init];
    
    self.secondDay = [[UILabel alloc] init];
    self.secondDayTemp = [[UILabel alloc] init];
    self.secondDayImgView = [[UIImageView alloc] init];
    
    self.thirdDay = [[UILabel alloc] init];
    self.thirdDayTemp = [[UILabel alloc] init];
    self.thirdDayImgView = [[UIImageView alloc] init];
    
    self.forthDay = [[UILabel alloc] init];
    self.forthDayTemp = [[UILabel alloc] init];
    self.forthDayImgView = [[UIImageView alloc] init];
    
    UIImage * backgroundImage = [UIImage imageNamed: @"bg0_fine_day.png"];
    UIImageView * backgroundView = [[UIImageView alloc] initWithImage: backgroundImage];
    backgroundView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    self.view = backgroundView;
//    [self.view addSubview: backgroundView];
    
    
    
    CGRect titleViewRect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 40);
    WDQYBTitleView * titleView = [[WDQYBTitleView alloc] initWithFrame: titleViewRect];
    titleView.titleLabel.text = @"晋中";
    [self.view addSubview: titleView];
    
    //Temperature  label
    CGFloat tempLblWidth = 200;
    CGFloat tempLblHeight = 80;
    CGRect tempLabelFrm = CGRectMake(self.view.frame.size.width / 2 - 20,
                                     self.view.frame.origin.y + titleViewRect.size.height,
                                     tempLblWidth,
                                     tempLblHeight);
    self.tempLabel = [[UILabel alloc] initWithFrame: tempLabelFrm];
    self.tempLabel.textColor = [UIColor whiteColor];
//    self.tempLabel.text = @"18℃";
    self.tempLabel.textAlignment = UITextAlignmentCenter;
    self.tempLabel.font = [UIFont boldSystemFontOfSize: 66];
    self.tempLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: self.tempLabel];
    
    //5 days weather views
    CGFloat DayViewWidth = 120;
    CGFloat DayViewHeight = 40;
    CGRect firstDayViewFrm = CGRectMake(self.view.frame.size.width - DayViewWidth,
                                        self.tempLabel.frame.origin.y + self.tempLabel.frame.size.height + 10,
                                        DayViewWidth,
                                        DayViewHeight);
    [self makeDayView: firstDayViewFrm withDay: self.firstDay withDayTemp: self.firstDayTemp withTheImage: self.firstDayImgView];
    CGRect secondDayViewFrm = CGRectMake(self.view.frame.size.width - DayViewWidth,
                                        firstDayViewFrm.origin.y + DayViewHeight + 10,
                                        DayViewWidth,
                                        DayViewHeight);
    [self makeDayView: secondDayViewFrm withDay: self.secondDay withDayTemp: self.secondDayTemp withTheImage: self.secondDayImgView];
    CGRect thirdDayViewFrm = CGRectMake(self.view.frame.size.width - DayViewWidth,
                                        secondDayViewFrm.origin.y + DayViewHeight + 10,
                                        DayViewWidth,
                                        DayViewHeight);
    [self makeDayView: thirdDayViewFrm withDay: self.thirdDay withDayTemp: self.thirdDayTemp withTheImage: self.thirdDayImgView];
    CGRect forthDayViewFrm = CGRectMake(self.view.frame.size.width - DayViewWidth,
                                        thirdDayViewFrm.origin.y + DayViewHeight + 10,
                                        DayViewWidth,
                                        DayViewHeight);
    [self makeDayView: forthDayViewFrm withDay: self.forthDay withDayTemp: self.forthDayTemp withTheImage: self.forthDayImgView];
    
    NSOperationQueue * q = [OperationQueueForServerAPIRequest sharedQueue];
    self.dataHandle1 = [[WDQYBTodayDetailDataHandle alloc] initWithUIDelegate:self firstNode: @"weatherinfo" secondNode: @""];
    self.dataHandle2 = [[WDQYBTrendDataHandle alloc] initWithUIDelegate: self firstNode: @"weatherinfo" secondNode: @""];
    [DataFactory doDataWith: self.dataHandle1 inQueue: q];
    [DataFactory doDataWith: self.dataHandle2 inQueue: q];
    
    //Today's attributes
    CGFloat todayWeatherWidth;
    CGFloat todayWeatherHeight = todayWeatherWidth = 50;
    CGRect todayWeatherFrm = CGRectMake(self.view.bounds.origin.x,
                                        self.view.bounds.origin.y + 200,
                                        todayWeatherWidth + 150, todayWeatherHeight);
    self.todayWeather = [[UILabel alloc] initWithFrame: todayWeatherFrm];
//    self.todayWeather.text = @"晴";
    self.todayWeather.textAlignment = UITextAlignmentLeft;
    self.todayWeather.font = [UIFont boldSystemFontOfSize: 50];
    self.todayWeather.textColor = [UIColor whiteColor];
    self.todayWeather.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.todayWeather];
    
    self.todayTemp = [[UILabel alloc] initWithFrame: CGRectMake(self.todayWeather.frame.origin.x,
                                                               self.todayWeather.frame.origin.y + self.todayWeather.frame.size.height,
                                                               100, 20)];
//    self.todayTemp.text = @"18℃ ~ 29℃";
    self.todayTemp.textAlignment = UITextAlignmentLeft;
    self.todayTemp.font = [UIFont boldSystemFontOfSize: 14];
    self.todayTemp.textColor = [UIColor whiteColor];
    self.todayTemp.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.todayTemp];
    
    self.todayWindy = [[UILabel alloc] initWithFrame: CGRectMake(self.todayTemp.frame.origin.x,
                                                                self.todayTemp.frame.origin.y + self.todayTemp.frame.size.height,
                                                                100, 20)];
//    self.todayWindy.text = @"东风1级";
    self.todayWindy.textAlignment = UITextAlignmentLeft;
    self.todayWindy.font = [UIFont boldSystemFontOfSize: 14];
    self.todayWindy.textColor = [UIColor whiteColor];
    self.todayWindy.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.todayWindy];
    
    self.todayDate = [[UILabel alloc] initWithFrame: CGRectMake(self.todayWindy.frame.origin.x,
                                                                 self.todayWindy.frame.origin.y + self.todayWindy.frame.size.height + 10,
                                                                 160, 20)];
//    self.todayDate.text = @"08/10 壬辰年六月二十三";
    self.todayDate.textAlignment = UITextAlignmentLeft;
    self.todayDate.font = [UIFont boldSystemFontOfSize: 14];
    self.todayDate.textColor = [UIColor whiteColor];
    self.todayDate.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.todayDate];
    
    
    self.todayPublishTime = [[UILabel alloc] initWithFrame: CGRectMake(self.todayDate.frame.origin.x,
                                                                self.todayDate.frame.origin.y + self.todayDate.frame.size.height + 10,
                                                                160, 20)];
    self.todayPublishTime.text = @"NULL";
    self.todayPublishTime.textAlignment = UITextAlignmentLeft;
    self.todayPublishTime.font = [UIFont boldSystemFontOfSize: 14];
    self.todayPublishTime.textColor = [UIColor whiteColor];
    self.todayPublishTime.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.todayPublishTime];
    [self.view addSubview: waitView];
    
}

- (void) makeDayView: (CGRect) rect
             withDay: (UILabel *) theDay
         withDayTemp: (UILabel *) theTemp
        withTheImage: (UIImageView *) theImg{
    UIView * firstDayView = [[UIView alloc] initWithFrame: rect];
    firstDayView.backgroundColor = [UIColor grayColor];
    
    
    CGRect firstDayFrm = CGRectMake(firstDayView.bounds.origin.x, firstDayView.bounds.origin.y, 80, 20);
    
//    theDay = [[UILabel alloc] initWithFrame: firstDayFrm];
    theDay.frame = firstDayFrm;
    theDay.backgroundColor = [UIColor clearColor];
    theDay.text = @"NULL";
    theDay.textAlignment = UITextAlignmentCenter;
    theDay.textColor = [UIColor whiteColor];
    theDay.font = [UIFont fontWithName: @"Times New Roman" size: 12];
    [firstDayView addSubview: theDay];
    
//    theTemp = [[UILabel alloc] initWithFrame: CGRectMake(firstDayView.bounds.origin.x,
//                                                                   firstDayView.bounds.origin.y + theDay.bounds.size.height,
//                                                                   80,
//                                                                   20)];
    theTemp.frame = CGRectMake(firstDayView.bounds.origin.x,
                               firstDayView.bounds.origin.y + theDay.bounds.size.height,
                               80,
                               20);
    theTemp.backgroundColor = [UIColor clearColor];
    theTemp.text = @"NULL";
    theTemp.textAlignment = UITextAlignmentCenter;
    theTemp.font = [UIFont fontWithName: @"Times New Roman" size: 12];
    theTemp.textColor = [UIColor whiteColor];
    [firstDayView addSubview: theTemp];
    
    UIImage * firstDayImg = nil;
//    theImg = [[UIImageView alloc] initWithImage: firstDayImg];
    theImg.image = firstDayImg;
    theImg.frame = CGRectMake(firstDayView.bounds.origin.x + theDay.frame.size.width,
                                            firstDayView.bounds.origin.y,
                                            40,
                                            40);
    [firstDayView addSubview: theImg];
    [self.view addSubview: firstDayView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
