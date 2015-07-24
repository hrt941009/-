//
//  OrderViewController.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "OrderCenterViewController.h"
#import "AllOrderViewController.h"
#import "AfterSaleViewController.h"
#import "AddressManagerController.h"

@interface OrderCenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation OrderCenterViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"买家中心");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArray = @[MyLocalizedString(@"所有订单"),
                   MyLocalizedString(@"待付款"),
                   MyLocalizedString(@"待发货"),
                   MyLocalizedString(@"待收货"),
                   MyLocalizedString(@"售后服务"),
                   MyLocalizedString(@"收货地址管理")];
    
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
    return [_dataArray count];
    
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
    return cell;

    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //所有订单
        AllOrderViewController *allOrderVC = [[AllOrderViewController alloc] init];
        allOrderVC.title = _dataArray[indexPath.row];
        allOrderVC.orderStatus = MyOrderStatusALl;
        [self.navigationController pushViewController:allOrderVC animated:YES];
    }
    if (indexPath.row == 1) {
        //待付款
        AllOrderViewController *allOrderVC = [[AllOrderViewController alloc] init];
        allOrderVC.title = _dataArray[indexPath.row];
        allOrderVC.orderStatus = MyOrderStatusPay;
        [self.navigationController pushViewController:allOrderVC animated:YES];
    }
    if (indexPath.row == 2) {
        //待发货
        AllOrderViewController *allOrderVC = [[AllOrderViewController alloc] init];
        allOrderVC.title = _dataArray[indexPath.row];
        allOrderVC.orderStatus = MyOrderStatusSendGoods;
        [self.navigationController pushViewController:allOrderVC animated:YES];
    }
    if (indexPath.row == 3) {
        //待收货
        AllOrderViewController *allOrderVC = [[AllOrderViewController alloc] init];
        allOrderVC.title = _dataArray[indexPath.row];
        allOrderVC.orderStatus = MyOrderStatusReceive;
        [self.navigationController pushViewController:allOrderVC animated:YES];
    }
    if (indexPath.row == 4) {
        //售后服务
        AfterSaleViewController *afterSaleVC = [[AfterSaleViewController alloc] init];
        afterSaleVC.title = _dataArray[indexPath.row];
        [self.navigationController pushViewController:afterSaleVC animated:YES];
    }
    if (indexPath.row == 5) {
        //收货地址管理
        AddressManagerController *addressVC = [[AddressManagerController alloc] init];
        addressVC.title = _dataArray[indexPath.row];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}


@end
