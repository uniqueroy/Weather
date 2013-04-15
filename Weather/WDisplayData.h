//
//  WDisplayData.h
//  Weather
//
//  Created by Roy Hsiao on 3/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBase : NSObject
@property (strong, nonatomic) NSMutableDictionary * dataDictionary;
@property (copy, nonatomic) NSString * serverUrl;
@property (strong, nonatomic) NSMutableDictionary * itemsRead;
@property (nonatomic) BOOL isRead;
@end

@interface YJXXListData : DataBase
@property (strong, nonatomic) UIImage * leftIcon;
@property (copy, nonatomic) NSString * title;
@property (strong, nonatomic) NSMutableDictionary * itemsDict;
- (id) init;
@end


@interface YJXXDetailData : DataBase
@property (strong, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * banner;
@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * city;
-(id) initWithUrl: (NSString *) theUrl;
@end


@interface ZQYBDetailData : DataBase
@property (strong, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * banner;
@property (copy, nonatomic) NSString * title;
- (id) init;
@end


@interface QHYCDetailData : DataBase
@property (strong, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * banner;
@property (copy, nonatomic) NSString * title;
- (id) init;
@end

@interface SLHXDetailData : DataBase
@property (strong, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * banner;
@property (copy, nonatomic) NSString * title;
- (id) init;
@end

@interface DZZHDetailData : DataBase
@property (strong, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * banner;
@property (copy, nonatomic) NSString * title;
- (id) init;
@end


@interface QHPJListData : DataBase
@property (copy, nonatomic) NSString * cellTitle;
@property (strong, nonatomic) NSMutableDictionary * items;
- (id) init;
@end

@interface QHPJDetailData : DataBase
@property (strong, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * banner;
@property (copy, nonatomic) NSString * title;
- (id) initWithUrl: (NSString *) theUrl;
@end

@interface SHQXTableData : DataBase
@property (strong, nonatomic) NSMutableDictionary * itemsDict;
@property (copy, nonatomic) NSString * title;
- (id) init;
@end

@interface NYQXListData : DataBase
@property (copy, nonatomic) NSString * cellTitle;
@property (assign, nonatomic) BOOL isRead;
- (id) init;
@end

@interface NYQXDetailData : DataBase
@property (strong, nonatomic) UIImage * image;
@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * banner;
@property (copy, nonatomic) NSString * title;
- (id) initWithUrl: (NSString *) theUrl;
@end

@interface JTQXTableData : DataBase
@property (strong, nonatomic) NSMutableDictionary * itemsDict;
@property (copy, nonatomic) NSString * title;
- (id) init;
@end

@interface SZYWTableData : DataBase
- (id) initWithType: (NSString *)type;
@end

@interface TQSKDetailData : DataBase

@end

@interface RadarDetailData : DataBase

@end

@interface WXYTDetailData : DataBase

@property (nonatomic) NSInteger type;
- (id) initWithType: (NSInteger) theType;

@end

@interface DQYBTodayDetailData : DataBase
@property (copy, nonatomic) NSString * windDirection;
@property (copy, nonatomic) NSString * windForce;
@property (copy, nonatomic) NSString * publishedDate;
@end

@interface DQYBTrendData : DataBase
@property (strong, nonatomic) NSMutableDictionary * dict;
@end

@interface YACXListData : DataBase

@property (strong, nonatomic) NSMutableDictionary * isReadDict;
- (void) makeIsReadDict;

@end

@interface YACXDetailedData : DataBase
- (id) initWithUrl:(NSString *)theUrl;
@end

@interface TZTGListData : DataBase

@property (strong, nonatomic) NSMutableDictionary * isReadDict;
- (void) makeIsReadDict;

@end

@interface TZTGDetailedData : DataBase
- (id) initWithUrl:(NSString *)theUrl;
@end























