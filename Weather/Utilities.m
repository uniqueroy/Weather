//
//  Utilities.m
//  Weather
//
//  Created by Roy Hsiao on 4/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "Utilities.h"
#import "JSONKit.h"
#import "OperationQueueForServerAPIRequest.h"
#import "WaitUIView.h"
#import <QuartzCore/QuartzCore.h>

@implementation Utilities

+(NSString*)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    
    return chineseCal_str;  
}

+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width - 32, CGFLOAT_MAX) lineBreakMode: UILineBreakModeWordWrap];
    return sizeToFit.height + 32;
}

+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha/255.0;
    CGFloat components[4] = {r,g,b,a};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color = (__bridge CGColorRef)(__bridge id)CGColorCreate(colorSpace, components);
    CGColorSpaceRelease(colorSpace);
    
    return color;
}

+ (NSMutableDictionary *) networkUtilParseUrl: (NSString *) urlStr
                                withFirstNode: (NSString *) firstNode
                              withSecondeNode: (NSString *) secondNode
                                 withDelegate: (id<WNetworkUtilDelegate>) theDelegate{
    if(![urlStr hasPrefix: @"http://"])
        urlStr = [NSString stringWithString: [@"http://" stringByAppendingString: urlStr]];
    NSURL * url = [[NSURL alloc] initWithString: urlStr];
    NSMutableDictionary * dict;
    if(!url){
        NSLog(@"Getting URL failed in 'main()' method of 'WNetworkUtil' file - %@", urlStr);
        [((UIViewController *)theDelegate) performSelectorOnMainThread: @selector(exitWithError) withObject: nil waitUntilDone: NO];
        return nil;
    }
    NSURLRequest * req = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSData * r = [NSURLConnection sendSynchronousRequest: req returningResponse: nil error: nil];
    NSString * resultStr = [[NSString alloc] initWithData: r encoding: NSUTF8StringEncoding];
    dict = [[[self alloc] init] parseResultStringWithFirstNode: firstNode andSecondNode: secondNode withResultStr: resultStr withDelegate: theDelegate];
    return dict;
}

- (NSMutableDictionary *) parseResultStringWithFirstNode: (NSString *) theFirstNode
                          andSecondNode: (NSString *) theSecondNode
                          withResultStr: (NSString *) resultStr
                           withDelegate: (id<WNetworkUtilDelegate>) theDelegate{
    NSDictionary * temp = [resultStr objectFromJSONStringWithParseOptions: JKParseOptionLooseUnicode];
    if(!temp){
        NSLog(@"Getting JSON dictionary failed in 'parseResultStringWithFirstNode' method of 'WNetworkUtil' file - %@", resultStr);
        [((UIViewController *)theDelegate) performSelectorOnMainThread: @selector(exitWithError) withObject: nil waitUntilDone: NO];
        return nil;
    }
    NSMutableDictionary * dict;
    if(theFirstNode != NULL)
        dict = [NSMutableDictionary dictionaryWithDictionary: [temp objectForKey: theFirstNode]];
    else
        dict = [NSMutableDictionary dictionaryWithDictionary: temp];
    if(theSecondNode != NULL){
        NSArray * tempAry = [dict objectForKey: theSecondNode];
        [dict removeObjectForKey: @"items"];
        [dict setObject: [[NSMutableDictionary alloc] init] forKey: @"items"];
        for(int i = 0; i < [tempAry count]; i++){
            NSMutableDictionary * temp = [dict objectForKey: @"items"];
            [temp setObject: [tempAry objectAtIndex: i] forKey: [NSString stringWithFormat: @"item%d", i]];
        }
    }
    return dict;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width, image.size.height));
    [image drawInRect: CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage * scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;     
}

+ (CGFloat) calculateLabelHeightWithContent: (NSString *) content withFont: (UIFont *) font withLabelWidth: (CGFloat) labelWidth{
    CGSize sizeName = [content sizeWithFont: font
                          constrainedToSize: CGSizeMake(labelWidth, 100)
                              lineBreakMode: UILineBreakModeWordWrap];
    return sizeName.height;
}

@end
