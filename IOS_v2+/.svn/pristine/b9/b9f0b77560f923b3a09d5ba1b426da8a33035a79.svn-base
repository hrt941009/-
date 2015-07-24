//
//  ProtectAccountViewController.m
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "ProtectAccountViewController.h"

@interface ProtectAccountViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *deviceArray;

@end

@implementation ProtectAccountViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"账号保护");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *deviceStr = [NSString stringWithFormat:@"%@ | %@",
                           [[UIDevice currentDevice] name],
                           [[UIDevice currentDevice] model]];
    _deviceArray = @[deviceStr];
    
    //-----
    CGRect tvRect = CGRectMake(0, 0, self.view.frame.size.width, 154.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return @"常用设备";
//    }
//    return nil;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return [_deviceArray count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSInteger section = indexPath.section;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        if (section == 0) {
            if (indexPath.row == 1) {
                UISwitch *onOffSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width - 80.f, 2.f, 60.f, 36.f)];
                onOffSwitch.on = NO;
                [onOffSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:onOffSwitch];
            }
        }
    }
    
    if (section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"开启账户保护后，在不常用手机上登录，需要验证手机号";
            cell.textLabel.font = [UIFont systemFontOfSize:11.f];
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"账户保护";
        }
    }
    if (section == 1) {
        cell.textLabel.text = _deviceArray[indexPath.row];
    }

    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        return 30.f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView  = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, 100.f, 30.f)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"常用设备";
    label.textColor = [UIColor darkGrayColor];
    [sectionView addSubview:label];
    
    return sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - switch action
- (void)switchAction:(UISwitch *)sw
{
    NSLog(@"%d", sw.on);
}
@end
