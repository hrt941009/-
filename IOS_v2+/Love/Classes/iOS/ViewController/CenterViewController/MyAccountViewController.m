//
//  MyAccountViewController.m
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyAccountViewController.h"
#import "BaaiAccountViewController.h"
#import "SettingMobileViewController.h"
#import "SettingEmailViewController.h"
#import "ProtectAccountViewController.h"

typedef NS_ENUM(NSInteger, MyAccountAlertViewTag)
{
    MyAccountAlertViewTagWithPassword = 1
};

@interface MyAccountViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *sectionArray1, *sectionArray2, *sectionArray3, *sectionArray4;
@property (nonatomic, strong) NSArray *sectionDataArray1, *sectionDataArray2, *sectionDataArray3, *sectionDataArray4;


@end

@implementation MyAccountViewController

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sectionArray1 = @[@"八爱号"];
    _sectionArray2 = @[@"手机号", @"邮箱地址"];
    _sectionArray3 = @[@"独立密码"];
    _sectionArray4 = @[@"账号保护"];
    
    _sectionDataArray1 = @[@"未设置"];
    _sectionDataArray2 = @[@"未设置", @"未设置"];
    _sectionDataArray4 = @[@"启用"];
    
    //-----
    CGRect tvRect = CGRectMake(0, 0, self.view.frame.size.width, 256.f);
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
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_sectionArray1 count];
    }
    if (section == 1) {
        return [_sectionArray2 count];
    }
    if (section == 2) {
        return [_sectionArray3 count];
    }
    if (section == 3) {
        return [_sectionArray4 count];
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
        
    }
    
    if (section == 0) {
        cell.textLabel.text = _sectionArray1[indexPath.row];
        cell.detailTextLabel.text = _sectionDataArray1[indexPath.row];
    }
    if (section == 1) {
        cell.textLabel.text = _sectionArray2[indexPath.row];
        cell.detailTextLabel.text = _sectionDataArray2[indexPath.row];
    }
    if (section == 2) {
        cell.textLabel.text = _sectionArray3[indexPath.row];
    }
    if (section == 3) {
        cell.textLabel.text = _sectionArray4[indexPath.row];
        cell.detailTextLabel.text = _sectionDataArray4[indexPath.row];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView  = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    return sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if (section == 0) {
        BaaiAccountViewController *baaiViewController = [[BaaiAccountViewController alloc] initWithNibName:@"BaaiAccountViewController" bundle:nil];
        [self.navigationController pushViewController:baaiViewController animated:YES];
    }
    if (section == 1) {
        if (indexPath.row == 0) {
            SettingMobileViewController *mobileViewController = [[SettingMobileViewController alloc] initWithNibName:@"SettingMobileViewController" bundle:nil];
            [self.navigationController pushViewController:mobileViewController animated:YES];
        }
        if (indexPath.row == 1) {
            SettingEmailViewController *emailViewController = [[SettingEmailViewController alloc] initWithNibName:@"SettingEmailViewController" bundle:nil];
            [self.navigationController pushViewController:emailViewController animated:YES];
        }
    }
    if (section == 2) {
       UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"设置独立密码"
                                               message:nil
                                              delegate:self
                                     cancelButtonTitle:MyLocalizedString(@"Cancel")
                                     otherButtonTitles:@"设置密码", nil];
        alertView.tag = MyAccountAlertViewTagWithPassword;
        alertView.delegate = self;
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alertView show];
    }
    if (section == 3) {
        ProtectAccountViewController *protectViewController = [[ProtectAccountViewController alloc] init];
        [self.navigationController pushViewController:protectViewController animated:YES];
    }
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == MyAccountAlertViewTagWithPassword) {
        if (buttonIndex == 1) {
            UITextField *pwTextField = [alertView textFieldAtIndex:0];
            NSLog(@"password = %@", pwTextField.text);
        }
    }
}

@end
