//
//  WQXFWViewController.h
//  Weather
//
//  Created by Roy Hsiao on 3/6/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

enum navSwither{
    duanqiyubao = 0,
    zhongqiyubao,
    qihouyuce,
    qihoupingjia,
    shenghuoqixiang,
    nongyeqixiang,
    senlinhuoxian,
    dizhizaihai,
    jiaotongqixiang,
    tianqishikuang,
    weixingyuntu,
    tianqileida
};

@interface WQXFWViewController : UICollectionViewController{
}



@property (strong, nonatomic) NSMutableDictionary * nameDict_CN;
@property (strong, nonatomic) NSMutableArray * nameList;
@end
