//
//  WPickerDetailVier.h
//  Weather
//
//  Created by Roy Hsiao on 4/10/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPickerDetailViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDataSource, UITableViewDelegate>{
    UIPickerView * _pickerView;
    NSMutableArray * _rootCities;
    NSMutableDictionary * _subCities;
    NSArray * _currentSubCities;
}

@property (copy, nonatomic) NSString * rootCityName;
@property (copy, nonatomic) NSString * subCityName;
@property (strong, nonatomic) NSMutableDictionary * cities;

@end
