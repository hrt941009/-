//
//  SettingViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutBaaiAppViewController.h"
#import "LoginViewController.h"
#import "MyNoticeViewController.h"
#import "ContactUSViewController.h"
#import "HelpViewController.h"

#import "UserManager.h"
#import "LoginModel.h"
#import "SVProgressHUD.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SettingViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"设置");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArray = @[@"意见反馈", @"给我们评分", @"使用帮助",@"关于8爱"];//, @"使用帮助", @"关于八爱"];
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//    switch (indexPath.section) {
//        case 0:
//            cell.textLabel.text = _dataArray[indexPath.row];
//            
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.selectionStyle = UITableViewCellSelectionStyleGray;
//            break;
//        case 1:
//            cell.textLabel.text = @"退出登录";
//            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//            cell.textLabel.textColor = [UIColor whiteColor];
//            cell.contentView.backgroundColor = [UIColor GooglePlus];
//            
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            break;
//        default:
//            break;
//    }
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView  = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    UIAlertView *alertView = nil;
    switch (section) {
        case 0:
//            if (indexPath.row == 0) {
//                MyNoticeViewController *myNoticeVC = [[MyNoticeViewController alloc] init];
//                myNoticeVC.title = _dataArray[0];
//                [self.navigationController pushViewController:myNoticeVC animated:YES];
//            }
            if (indexPath.row == 0) {
                ContactUSViewController *contactUSVC = [[ContactUSViewController alloc] initWithNibName:@"ContactUSViewController" bundle:nil];
                contactUSVC.title = _dataArray[0];
                [self.navigationController pushViewController:contactUSVC animated:YES];
            }
            if (indexPath.row == 1) {
                //初始化控制器
                [SVProgressHUD show];
                
                SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
                //设置代理请求为当前控制器本身
                storeProductViewContorller.delegate = self;
                //加载一个新的视图展示
                [storeProductViewContorller loadProductWithParameters:
                 //appId唯一的
                 @{SKStoreProductParameterITunesItemIdentifier:iTunesItemIdentifier} completionBlock:^(BOOL result, NSError *error) {
                     //block回调
                     if(error){
                         NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
                     }else{
                         //模态弹出appstore
                         [self presentViewController:storeProductViewContorller animated:YES completion:^{
                             [SVProgressHUD dismiss];
                         }];
                     }
                 }];
            }
            if (indexPath.row == 2) {
                HelpViewController *helpVC = [[HelpViewController alloc] init];
                helpVC.title = _dataArray[2];
                [self.navigationController pushViewController:helpVC animated:YES];
            }
            if (indexPath.row == 3) {
                //关于八爱
                AboutBaaiAppViewController *aboutBaaiAppVC = [[AboutBaaiAppViewController alloc] init];
                [self.navigationController pushViewController:aboutBaaiAppVC animated:YES];
            }
            break;
        case 1:
            alertView = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"是否退出？"
                                                  delegate:self
                                         cancelButtonTitle:MyLocalizedString(@"Cancel")
                                         otherButtonTitles:MyLocalizedString(@"OK"), nil];
            [alertView show];
            break;
            
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
         NSString *key = [UserManager readSig];
        if ([key length] > 0) {
            [LoginModel logoutMyApp];
            [UserManager restKeychain];
            self.tabBarController.selectedIndex = 0;
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCenterLogoutNotification" object:nil userInfo:nil];
    }
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
