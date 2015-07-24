//
//  AddressManagerController.m
//  Love
//
//  Created by use on 14-11-22.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "AddressManagerController.h"
#import "ReciveAdressModel.h"
#import "UIScrollView+MJRefresh.h"
#import "ReciveAddressCell.h"
#import "NewReciveAdressController.h"
#import "ChangeAddressController.h"
#import "MJRefresh.h"
static NSString *const type = @"1";

@interface AddressManagerController ()<UITableViewDataSource ,UITableViewDelegate,UIAlertViewDelegate,ReloadDataDelegate,ReloadChangeAddressDataDelegate>
{
    NSString *defaultAddressId;
    NSString *selectAddressId;
    NSInteger cellForRow;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *dataDefaultArray;
@property (nonatomic ,strong) UIBarButtonItem *editBarButton;
@property (nonatomic ,strong) UINib *nib;

@end

@implementation AddressManagerController
//代理方法实现
- (void)reloadChangeAddressData{
    
    [self.tableView headerBeginRefreshing];
    
}

- (void)reloadTableViewData{
    
    [self.tableView headerBeginRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reciveAddressData:)
                                                 name:kReciveAddressNotificationName
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reciveSetDefaultAddress:)
                                                 name:kSettingDefaultAddressNotificationName
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reciveDeleteAddress:)
                                                 name:kDeleteAddressNotificationName
                                               object:nil];
    
    
    _dataArray = [[NSMutableArray alloc] init];
    _dataDefaultArray = [[NSMutableArray alloc] init];
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f - 40.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self createBottomButton];
    
    [self addHeaderRefersh];
    
}

- (void)createBottomButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-104, kScreenWidth, 40)];
    button.backgroundColor = [UIColor grayColor];
    [button setBackgroundColor:[UIColor colorRGBWithRed:220 green:60 blue:100 alpha:1]];
    [button setTitle:@"新建地址" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(createNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view bringSubviewToFront:button];
}

- (void)addHeaderRefersh{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [ReciveAdressModel getReciveAddressDataType:type];
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)reciveAddressData:(NSNotification*)noti{
    [_dataArray addObjectsFromArray:noti.object];
    for (int i = 0; i < [_dataArray count]; i++) {
        ReciveAdressModel *dataModel = (ReciveAdressModel*)_dataArray[i];
        if ([dataModel.status isEqual:@"1"]) {
            [_dataArray exchangeObjectAtIndex:i withObjectAtIndex:0];
        }
    }
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}

//- (void)reciveAddressDefaultData:(NSNotification*)noti{
//    [_dataDefaultArray addObjectsFromArray:noti.object];
//    if (_dataDefaultArray) {
//        ReciveAdressModel *model = (ReciveAdressModel*)_dataDefaultArray[0];
//        defaultAddressId = model.reciveaddrId;
//        for (int i = 0; i < [_dataArray count]; i++) {
//            ReciveAdressModel *dataModel = (ReciveAdressModel*)_dataArray[i];
//            if ([defaultAddressId isEqual:dataModel.reciveaddrId]) {
//                [_dataArray exchangeObjectAtIndex:i withObjectAtIndex:0];
//            }
//        }
//    }
//    [self.tableView reloadData];
//    [self.tableView headerEndRefreshing];
//}

//点击新建地址事件
- (void)createNewAddress:(UIButton *)button{
    NewReciveAdressController *newAdress = [[NewReciveAdressController alloc] init];
    newAdress.delegate = self;
    [self.navigationController pushViewController:newAdress animated:YES];
}

#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIdentifier = @"kReciveAddressIdentifier";
    static NSString *noDataCellIdentifier = @"noDataCellIdentifier";
    if ([_dataArray count] > 0) {
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"ReciveAddressCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:kCellIdentifier];
        }
        ReciveAddressCell *cell = (ReciveAddressCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        
        ReciveAdressModel *model = (ReciveAdressModel*)_dataArray[indexPath.row];
        cell.name.text = model.consignee;
        cell.address.text = model.address;
        cell.phoneNum.text = model.mobile;
        if (indexPath.row != 0) {
            [cell.isDefault removeFromSuperview];
            cell.address.frame = CGRectMake(10, 39, 300, 33);
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:noDataCellIdentifier];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"还没有添加地址");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

#pragma mark -- tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataArray count] > 0) {
        cellForRow = indexPath.row;
        ReciveAdressModel *model = (ReciveAdressModel*)_dataArray[indexPath.row];
        selectAddressId = model.reciveaddrId;
        if (_isCommidity) {
            if ([_delegate respondsToSelector:@selector(GetAddressData:)]) {
                [_delegate GetAddressData:model];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作列表" message:nil delegate:self cancelButtonTitle:MyLocalizedString(@"Cancel")   otherButtonTitles:@"设为默认",@"编辑",@"删除", nil];
            alertView.frame = CGRectMake(40, (kScreenHeight-240)/2, 240, 240);
    
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [ReciveAdressModel getDeleteAddressDataAddress_id:selectAddressId];
        }
    }else{
        if (buttonIndex == 1) {
            NSLog(@"设为默认");
            [ReciveAdressModel getSetDefaultAddressDataAddress_id:selectAddressId];
        }
        if (buttonIndex == 2) {
            NSLog(@"编辑");
            ReciveAdressModel *model = (ReciveAdressModel*)_dataArray[cellForRow];
            ChangeAddressController *changeVC = [[ChangeAddressController alloc] init];
            changeVC.delegate = self;
            changeVC.addressStr = [NSString stringWithFormat:@"%@ %@ %@",model.province_name,model.city_name,model.district_name];
            changeVC.addressId = model.reciveaddrId;
            changeVC.provinceId = model.province;
            changeVC.cityId = model.city;
            changeVC.districtId = model.district;
            changeVC.addrStr = model.addr;
            changeVC.getNameStr = model.consignee;
            changeVC.phoneNumStr = model.mobile;
            changeVC.zipcodeStr = model.zipcode;
            [self.navigationController pushViewController:changeVC animated:YES];
        
        }
        if (buttonIndex == 3) {
            NSLog(@"删除");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您确定删除该地址？" delegate:self cancelButtonTitle:MyLocalizedString(@"Cancel") otherButtonTitles:MyLocalizedString(@"OK"), nil];
            alertView.tag = 100;
            [alertView show];
        }
    }
}

- (void)reciveSetDefaultAddress:(NSNotification*)noti{
    NSString *code = noti.object;
    if ([code isEqual:@"1"]) {

        [self.tableView headerBeginRefreshing];
    }
    if ([code isEqual:@"0"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设置默认地址" message:@"设置失败，请重试!" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

- (void)reciveDeleteAddress:(NSNotification*)noti{
    NSString *code = noti.object;
    if ([code isEqual:@"1"]) {
        [self.tableView headerBeginRefreshing];
    }
    if ([code isEqual:@"0"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除地址" message:@"删除失败，请重试!" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReciveAddressNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSettingDefaultAddressNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDeleteAddressNotificationName object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
