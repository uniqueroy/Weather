//
//  WDisplayData.m
//  Weather
//
//  Created by Roy Hsiao on 3/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WDisplayData.h"
#import "Constants.h"

@implementation DataBase
@synthesize serverUrl, itemsRead, isRead, dataDictionary;

- (id) init{
    self = [super init];
    if(self){
        self.itemsRead = [[NSMutableDictionary alloc] init];
        self.dataDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end

@implementation YJXXListData

@synthesize leftIcon, title, itemsDict;

-(id) init{
    self = [super init];
    if(self){
        self.serverUrl = [NSString stringWithFormat: @"%@?city=jinzhong", kYJXXLIST];
        self.leftIcon = [[UIImage alloc] initWithContentsOfFile: @"dw1.png"];
        self.title = @"NULL";
        self.itemsDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}
@end


@implementation YJXXDetailData

@synthesize image, banner, title, content, city;

-(id) initWithUrl: (NSString *) theUrl{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@", theUrl];
        self.image = nil;
        self.banner = @"NULL";
        self.title = @"NULL";
        self.content = @"NULL";
        self.city = @"NULL";
    }
    return self;
}
@end

@implementation ZQYBDetailData

@synthesize image, banner, title, content;

-(id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong", kMID_FORECAST];
        self.image = nil;
        self.banner = @"NULL";
        self.title = @"NULL";
        self.content = @"NULL";
    }
    return self;
}
@end

@implementation QHYCDetailData

@synthesize image, banner, title, content;

-(id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong", kCLIMATE_FORECAST];
        self.image = nil;
        self.banner = @"NULL";
        self.title = @"NULL";
        self.content = @"NULL";
    }
    return self;
}
@end

@implementation SLHXDetailData

@synthesize image, banner, title, content;

-(id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong", kFOREST_FIRE];
        self.image = nil;
        self.banner = @"NULL";
        self.title = @"NULL";
        self.content = @"NULL";
    }
    return self;
}
@end

@implementation DZZHDetailData

@synthesize image, banner, title, content;

-(id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong", kGEOLOGICAL];
        self.image = nil;
        self.banner = @"NULL";
        self.title = @"NULL";
        self.content = @"NULL";
    }
    return self;
}
@end

@implementation QHPJListData

@synthesize cellTitle;

- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong&start=0&offset=10", kCLIAMTE_COMMENT_LIST ];
        self.cellTitle = @"NULL";
    }
    return self;
}
@end

@implementation QHPJDetailData
@synthesize image, content, banner, title;

- (id) initWithUrl:(NSString *)theUrl{
    self = [super init];
    if(self){
        self.isRead = NO;
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@", theUrl];
        self.image = nil;
        self.content = @"NULL";
        self.banner = @"NULL";
        self.title = @"NULL";
    }
    return self;
}
@end

@implementation NYQXListData

- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong&start=0&offset=10", kAGRICULTURE_CLIMATE_LIST ];
        self.isRead = NO;
        self.cellTitle = @"NULL";
    }
    return self;
}
@end

@implementation NYQXDetailData
@synthesize image, content, banner, title;

- (id) initWithUrl:(NSString *)theUrl{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@", theUrl];
        self.image = nil;
        self.content = @"NULL";
        self.banner = @"NULL";
        self.title = @"NULL";
    }
    return self;
}
@end

@implementation SHQXTableData
@synthesize itemsDict, title;
- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong", kLIFE_INDEX];
        self.itemsDict = [[NSMutableDictionary alloc] init];
        self.title = @"NULL";
    }
    return self;
}
@end
@implementation JTQXTableData
@synthesize itemsDict, title;
- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong", kTRAFFIC];
        self.itemsDict = [[NSMutableDictionary alloc] init];
        self.title = @"NULL";
    }
    return self;
}
@end

@implementation SZYWTableData

- (id) initWithType: (NSString *)type{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?type=%@", kNEWLIST, type];    }
    return self;
}
@end

@implementation TQSKDetailData

- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@", kCITIES];
    }
    return self;
}

@end

@implementation RadarDetailData

- (id) init{
    self = [super init];
    if(self){
//        NSDate * now = [NSDate date];
//        NSDateFormatter * dateFormtter = [[NSDateFormatter alloc] init];
//        [dateFormtter setDateFormat: @"yyyy-MM-dd%20hh:mm"];
//        NSString * nowStr = [dateFormtter stringFromDate: now];
//        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong&d_time=%@", kRADAR, nowStr];
        NSString * appendStr = @"%2014:25";
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong&d_time=2013-04-11%@", kRADAR, appendStr];
    }
    return self;
}

@end

@implementation WXYTDetailData
@synthesize type;

- (id) initWithType: (NSInteger) theType{
    self = [super init];
    if(self){
        type = theType;
        NSString * appendStar = @"%20";
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong&d_time=2013-04-01%@12:00&type=%d",
                          kSATELLITE, appendStar, type];
    }
    return self;
}
@end

@implementation DQYBTodayDetailData
@synthesize windDirection, windForce, publishedDate;
- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%s", kCURRENT_WEATHER];
        self.windForce = @"NULL";
        self.windDirection = @"NULL";
        self.publishedDate = @"NULL";
    }
    return self;
}

@end


@implementation DQYBTrendData
@synthesize dict;
- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%s", kFIVE_DAY_WEATHER];
        self.dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end

@implementation YACXListData
@synthesize isReadDict;

- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong&start=0&offset=10", kYACXLIST];
        self.isReadDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) makeIsReadDict{
    for(NSString * item in [self.itemsRead allKeys])
        [self.isReadDict setObject: [NSNumber numberWithBool: NO] forKey: item];
}

@end

@implementation YACXDetailedData

- (id) initWithUrl:(NSString *)theUrl{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@", theUrl];
    }
    return self;
}
@end

@implementation TZTGListData
@synthesize isReadDict;

- (id) init{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@?city=jinzhong&start=0&offset=10", kTZTGLIST];
        self.isReadDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) makeIsReadDict{
    for(int i = 0; i < isReadDict.count; i++)
        [self.isReadDict setObject: [NSNumber numberWithBool: NO] forKey: [NSString stringWithFormat: @"%d", i]];
}

@end

@implementation TZTGDetailedData

- (id) initWithUrl:(NSString *)theUrl{
    self = [super init];
    if(self){
        self.serverUrl = [[NSString alloc] initWithFormat: @"%@", theUrl];
    }
    return self;
}
@end











