//
//  Constants.h
//  Weather
//
//  Created by Roy Hsiao on 3/7/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>

enum dataTag{
    kNONE = -1,
    kYJXX = 0,
    kZQYB,
    kQHYC,
    kSHQX,
    kSLHX,
    kDZZH,
    kQHPJ,
    kQHPJD,
    kNYQX,
    kNYQXD,
    kJTQX,
    kSZYW_DUP,
    kSZYW_DUPD,
    kYACXD,
    kTZTGD
};

//public static String Server_url = "http://202.207.177.53:60/";
#define kSERVER_URL @"http://202.207.177.53:60/"
//public static String Server_ADDRESS = "202.207.177.53:60";
#define kSERVER_ADDR "202.207.177.53:60"
//public static final String Auth_URL = Server_url + "login";
#define kAUTH_URL SERVER_URL"login"
// 五天天气情况
//public static String Five_Day_Weather = "http://m.weather.com.cn/data/101100401.html";
#define kFIVE_DAY_WEATHER "http://m.weather.com.cn/data/101100401.html"
// 实时天气情况
//public static String Current_Weather = "http://www.weather.com.cn/data/sk/101100401.html";
#define kCURRENT_WEATHER "http://www.weather.com.cn/data/sk/101100401.html"
// 中期天气预报  参数 city=jinzhong
//public static final String Mid_Forecast = Server_url + "data/midforecast";
#define kMID_FORECAST kSERVER_URL"data/midforecast"
// 气候预测  参数 city=jinzhong
//public static final String Climate_Forecast = Server_url + "data/lastforecast";
#define kCLIMATE_FORECAST kSERVER_URL"data/lastforecast"
// 气候评价列表  参数 city=jinzhong&start=0&offset=10 第0条起后10条  在返回的json数据里 对应的单项 请求的地址
//public static final String Climate_Comment_List = Server_url + "data/weathercommentlist";
#define kCLIAMTE_COMMENT_LIST kSERVER_URL"data/weathercommentlist"
//这个地址在用stub的时候用的，
//public static final String Climate_Comment = Server_url + "weathercomment.html";
#define kCLIMATE_COMMENT kSERVER_URL"weathercomment.html"
// 生活气象  参数 city=jinzhong
//public static final String Life_Index = Server_url + "data/lifeindex";
#define kLIFE_INDEX kSERVER_URL"data/lifeindex"
// 农业气象列表  参数 city=jinzhong&start=0&offset=10 第0条起后10条
//public static final String Agriculture_Climate_List = Server_url + "data/agriculturalcommentlist";
#define kAGRICULTURE_CLIMATE_LIST kSERVER_URL"data/agriculturalcommentlist"
// 气候评价  参数 city=jinzhong
//public static final String Agriculture_Climate = Server_url + "data/agriculturalcomment.html";
#define kAGRICULTURE_CLIMATE kSERVER_URL"data/agriculturalcomment.html"
//森林火险  参数 city=jinzhong
//public static final String Forest_Fire = Server_url + "data/forestfire";
#define kFOREST_FIRE kSERVER_URL"data/forestfire"
//地质灾害  参数 city=jinzhong
//public static final String Geological = Server_url + "data/geological";
#define kGEOLOGICAL kSERVER_URL"data/geological"
//交通气象  参数 city=jinzhong
//public static final String Traffic = Server_url + "data/trafficlist";
#define kTRAFFIC kSERVER_URL"data/trafficlist"
//天气实况的地城市列表
//public static final String Cities = Server_url + "data/cities";
#define kCITIES kSERVER_URL"data/cities"
//更新消息  参数authkey=15510636589 authkey 用IMSI号码
//public static final String UpdateMessage = Server_url + "im/updatemessage";
#define kUPDATEMESSAGE kSERVER_URL"im/updatemessage"
// public static final String SendMessage = "http://192.168.0.202:8080/webcontent/rcvmsg";
//发送消息   POST方式  参数  me： 发送者的IMSI号码 。 toid： 接收者的IMSI号，多个中间用逗号分开, content：文字内容  mime-type：传送文件的类型  audio/mpeg  image/jpeg video/x-msvideo application/zip
//public static final String SendMessage = Server_url + "im/sendmessage";
#define kSENDMESSAGE kSERVER_URL"im/sendmessage"
// public static final String SendFile = "http://192.168.0.202:8080/webcontent/rcvmsg";

//发送消息   POST方式  参数  me： 发送者的IMSI号码 。 toid： 接收者的IMSI号，多个中间用逗号分开,  mime-type：传送文件的类型  audio/mpeg  image/jpeg video/x-msvideo application/zip

//public static final String SendFile = Server_url + "im/sendfile";
#define kSENDFILE kSERVER_URL"im/sendfile"
//收到消息后确认收到 返回接收到的消息的ID用    
//public static final String ReadMessage = Server_url + "im/readedmessage";
#define kREADMESSAGE kSERVER_URL"im/readedmessage"
// 预警信息列表  参数 city=jinzhong&start=0&offset=10 第0条起后10条  在返回的json数据里 对应的单项 请求的地址
//public static final String YJXXLIST = Server_url + "data/yjxxlist";
#define kYJXXLIST kSERVER_URL"data/yjxxlist"
//public static final String YJXXItem = "http://web_server_url/data/yjxxitem";
#define kYJXXITEM "http://web_server_url/data/yjxxitem"
// 预案查询列表  参数 city=jinzhong&start=0&offset=10 第0条起后10条  在返回的json数据里 对应的单项 请求的地址
//public static final String YACXList = Server_url + "data/yacxlist";
#define kYACXLIST kSERVER_URL"data/yacxlist"
//public static final String YACXItem = "http://web_server_url/data/yacxitem";
#define kYACXITEM "http://web_server_url/data/yacxitem"
// 通知通告列表  参数 city=jinzhong&start=0&offset=10 第0条起后10条  在返回的json数据里 对应的单项 请求的地址
//public static final String TZTGList = Server_url + "notificationlist";
#define kTZTGLIST kSERVER_URL"notificationlist"
//public static final String TZTGItem = Server_url + "notificationitem";
#define kTZTGITEM kSERVER_URL"notificationitem"
// 市政要闻列表  参数 city=jinzhong&start=0&offset=10 第0条起后10条  在返回的json数据里 对应的单项 请求的地址
//public static final String NewsList = Server_url + "newslist";
#define kNEWLIST kSERVER_URL"newslist"
// 卫星云图 city:城市 。d_time：时间  yyyy-MM-dd HH:mm
//public static final String Satellite = Server_url + "data/satellitepic";
#define kSATELLITE kSERVER_URL"data/satellitepic"
// 天气雷达city:城市 。d_time：时间 yyyy-MM-dd HH:mm
//public static final String Radar = Server_url + "data/radar";
#define kRADAR kSERVER_URL"data/radar"
//public static final String NewsItem = Server_url + "data/satellitepic";
#define kNEWSITEM kSERVER_URL"data/satellitepic"
//public static final String Voices = Server_url + "data/message/location/voice";
#define kVOICES kSERVER_URL"data/message/location/voice"
//public static final String FILES = Server_url + "data/message/location/file";
#define kFILES kSERVER_URL"data/message/location/file"
//public static final String VIDEO = Server_url + "data/message/location/video";
#define kVIDEO kSERVER_URL"data/message/location/video"
//public static final String IMAGE = Server_url + "data/message/location/image";
#define kIMAGE kSERVER_URL"data/message/location/image"
// 气象咨询列表  参数 city=jinzhong&start=0&offset=10 第0条起后10条  在返回的json数据里 对应的单项 请求的地址
//public static final String QXZX = Server_url + "climatenewslist";
#define kQXZX kSERVER_URL"climatenewslist"
//public static final String SZYW = Server_url + "newslist";
#define kSZYW kSERVER_URL"newslist"
//public static final String DefaultGroup = Server_url + "defaultgroup";
#define kDEFAULTGROUP kSERVER_URL"defaultgroup"
//public static final String Login = Server_url + "login";
#define kLOGIN kSERVER_URL"login"

@interface Constants : NSObject

@end
