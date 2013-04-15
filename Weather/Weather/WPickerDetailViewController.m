//
//  WPickerDetailVier.m
//  Weather
//
//  Created by Roy Hsiao on 4/10/13.
//  Copyright (c) 2013 Roy Hsiao. All rights reserved.
//

#import "WPickerDetailViewController.h"
#import "CustomNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

@implementation WPickerDetailViewController

@synthesize rootCityName, subCityName, cities;

- (id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle: style];
    if (self) {
        rootCityName = [[NSString alloc] init];
        subCityName = [[NSString alloc] init];
        cities = [[NSMutableDictionary alloc] initWithCapacity: 0];
        _rootCities = [[NSMutableArray alloc] initWithCapacity: 0];
        _subCities = [[NSMutableDictionary alloc] initWithCapacity: 0];
        _currentSubCities = [[NSArray alloc] init];
    }
    return self;
}


- (void) viewDidLoad{
    [self parseCityDictionary];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"Cell"];
    self.tableView.scrollEnabled = NO;
    _pickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(self.view.frame.origin.x,
                                                                                 self.view.frame.origin.y + 460 - 300,
                                                                                 self.view.frame.size.width,
                                                                                 300)];
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;
    [self.view addSubview: _pickerView];
    
    CustomNavigationBar * customNavigationBar = (CustomNavigationBar *)self.navigationController.navigationBar;
    
    [customNavigationBar setBackgroundWith: [UIImage imageNamed: @"tqsk_navbar.png"]];
    
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"navigationBarBackButton.png"] highlight:nil leftCapWidth:14.0];
    [customNavigationBar setText: @"返回" onBackButton: backButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: backButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"确定" style: UIBarButtonItemStylePlain target: self action: @selector(passBackValue)];

    self.tableView.delegate = self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (void) passBackValue{
    NSMutableDictionary * returnDict = [[NSMutableDictionary alloc] initWithCapacity: 2];
    NSArray * indexes = [self.tableView indexPathsForVisibleRows];
    NSString * rootCity = [self.tableView cellForRowAtIndexPath: [indexes objectAtIndex: 0]].textLabel.text;
    [returnDict setObject: rootCity forKey: @"rootCity"];
    NSString * subCity = [self.tableView cellForRowAtIndexPath: [indexes objectAtIndex: 1]].textLabel.text;
    [returnDict setObject: subCity forKey: @"subCity"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"pickerPassValue" object: self userInfo: returnDict];
    [self.navigationController popViewControllerAnimated: YES];
}

- (void) parseCityDictionary{
    NSDictionary * a =[[self.cities allValues] objectAtIndex: 1];
    for(int i = 0; i < a.count; i++){
        NSDictionary * root = [a objectForKey: [NSString stringWithFormat: @"item%d", i]];
        NSString * rootStr = [root objectForKey: @"city"];
        [_rootCities addObject: rootStr];
        NSEnumerator * subEnumerator = [root keyEnumerator];
        id subItem;
        NSMutableArray * subsArray = [[NSMutableArray alloc] initWithCapacity: 0];
        while(subItem = subEnumerator.nextObject){
            if([subItem isEqualToString: @"items"]){
                NSArray * subs = [root objectForKey: subItem];
                for(NSDictionary * sub in subs)
                    [subsArray addObject: [sub objectForKey: @"city"]];
                [_subCities setObject: subsArray forKey: rootStr];
            }
        }
    }
    _currentSubCities = [_subCities objectForKey: [_rootCities objectAtIndex: 0]];
}

- (void) willAppearIn: (UINavigationController *) navigationController{
    [navigationController setNavigationBarHidden: NO animated: YES];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return  @"    ";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"Cell" forIndexPath: indexPath];
    if(indexPath.row == 0){
            cell.textLabel.text = rootCityName;
    }else if(indexPath.row == 1){
//            cell.textLabel.text = [_currentSubCities objectAtIndex: [_pickerView selectedRowInComponent: indexPath.row]];
            cell.textLabel.text = subCityName;
    }
    return cell;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0)
        return _rootCities.count;
    else if(component == 1){
        return _currentSubCities.count;
    }
    return 0;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0)
        return [_rootCities objectAtIndex: row];
    else if(component == 1){
        return [_currentSubCities objectAtIndex: row];
    }
    return @" ";
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        _currentSubCities = [_subCities objectForKey:[_rootCities objectAtIndex: row]];
        [pickerView reloadComponent: 1];
        rootCityName = [_rootCities objectAtIndex: row];
        subCityName = [_currentSubCities objectAtIndex: row];
        [self.tableView reloadData];
    }    else if(component == 1){
        subCityName = [_currentSubCities objectAtIndex: row];
        [self.tableView reloadData];
    }
}


@end
