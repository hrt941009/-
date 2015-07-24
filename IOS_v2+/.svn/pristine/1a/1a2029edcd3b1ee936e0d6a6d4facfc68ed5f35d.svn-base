//
//  LeftSideDrawerViewController.m
//  Love
//
//  Created by lee wei on 14-8-20.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LeftSideDrawerViewController.h"
#import "LOVCircle.h"
#import "UIViewController+MMDrawerController.h"
#import "LoginViewController.h"
#import "UserManager.h"

@interface LeftSideDrawerViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isLogin;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSArray *dataArray1, *dataArray2;
@property (nonatomic, strong) NSArray *postDataArray1, *postDataArray2;

@end


NSString *const kLeftSideDrawerLoginNotificationName = @"kLeftSideDrawerLoginNotificationName";

@implementation LeftSideDrawerViewController

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
    
    _account = [UserManager readAccount];
    if ([_account length] > 0) {
        isLogin = YES;
    }else{
        isLogin = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:LoginSuccessNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccessed) name:@"kCenterLogoutNotification" object:nil];
    
    //----
    _dataArray1 = @[@"24小时最热", @"7天最热", @"30天最热"];
    _dataArray2 = @[@"母婴", @"化妆品"];
    _postDataArray1 = @[@"day", @"week", @"month"];
    _postDataArray1 = @[@"5", @"6"];
    //------
    CGFloat originY = 0;
    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
        originY = 20.f;
    }else{
        originY = 0;
    }
   
    
    self.view.backgroundColor = [UIColor colorRGBWithRed:40.f green:42.f blue:47.f alpha:1.f];
    
    CGRect tvRect = CGRectMake(0, originY, kMaximumLeftDrawerWidth, 34.f * 7 + 42.f);//screenHeight - 30.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    //_tableView.tableHeaderView = _searchBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notice

- (void)loginSuccessed
{
    isLogin = YES;
    _account = [UserManager readAccount];
    [_tableView reloadData];
}

- (void)logoutSuccessed
{
    isLogin = NO;
    [_tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return [_dataArray1 count];
    }
    if (section == 2) {
        return [_dataArray2 count];
    }
    return 0;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    SellerHeaderView *headerView = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.section == 0) {
        LOVCircle *iconView = [[LOVCircle alloc] initWithFrame:CGRectMake(5.f, 2.f, 36.f, 36.f)
                                                 imageWithPath:nil
                                              placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [cell.contentView addSubview:iconView];
        
        if (isLogin == NO) {
            for (id label in [cell.contentView subviews]) {
                if ([label isKindOfClass:[UILabel class]]) {
                    [(UILabel *)label removeFromSuperview];
                }
            }
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.f, 0, 100.f, 40.f)];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.font = [UIFont systemFontOfSize:14.f];
            nameLabel.adjustsFontSizeToFitWidth = YES;
            nameLabel.text = @"登录";
            [cell.contentView addSubview:nameLabel];
        }
        if (isLogin == YES) {
            for (id label in [cell.contentView subviews]) {
                if ([label isKindOfClass:[UILabel class]]) {
                    [(UILabel *)label removeFromSuperview];
                }
            }
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.f, 0, 100.f, 40.f)];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.font = [UIFont systemFontOfSize:14.f];
            nameLabel.adjustsFontSizeToFitWidth = YES;
            nameLabel.text = _account;
            [cell.contentView addSubview:nameLabel];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = _dataArray1[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 2) {
        cell.textLabel.text = _dataArray2[indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40.f;
    }
    if (indexPath.section == 1) {
        return 34.f;
    }
    if (indexPath.section == 2) {
        return 34.f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 34.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorRGBWithRed:28.f green:29.f blue:33.f alpha:1.f];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.f];
    if (section == 0) {
        label.text = nil;
    }
    if (section == 1) {
        label.text = @"常用排序";
    }
    if (section == 2) {
        label.text = @"分类浏览";
    }
    return label;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (isLogin == NO) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kLeftSideDrawerLoginNotificationName object:nil];
        }
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHomePageTimeNotificationName object:@"day"];
        }
        if (indexPath.row == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHomePageTimeNotificationName object:@"week"];
        }
        if (indexPath.row == 2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHomePageTimeNotificationName object:@"month"];
        }
    }
    if (indexPath.section == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHomePageCatagoryNotificationName object:_postDataArray2[indexPath.row]];
    }
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


@end
