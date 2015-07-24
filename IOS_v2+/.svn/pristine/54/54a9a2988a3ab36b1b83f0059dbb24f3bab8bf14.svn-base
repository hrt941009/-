//
//  ReciveViewController.m
//  Love
//
//  Created by use on 14-11-21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ReciveViewController.h"
#import "OrderTrackCell.h"
#import "LogisticsModel.h"

@interface ReciveViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UINib *nib;

@property(nonatomic,strong)NSString *payStatue;
@property(nonatomic,strong)NSString *assume;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic, strong) LogisticsModel *model;

@end

@implementation ReciveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLogisticeDataFromModel:) name:kLogisticeNoticefationName object:nil];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    self.title = MyLocalizedString(@"订单追踪");
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 30.f) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    
    [LogisticsModel getLogisticeDataCode:_orderNum];
    
}

- (void)getLogisticeDataFromModel:(NSNotification*)noti{
    _model = noti.object;
    [_dataArray addObjectsFromArray:_model.express_data];
    _payStatue = MyLocalizedString(@"支付宝或银行卡支付");
    _assume = _model.express_name;
    [self.tableView reloadData];
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
    static NSString *CellIdentifier = @"CellIdentifier";
    static NSString *noDataCellIdentifier = @"noDataCellIdentifier";

    if ([_dataArray count] > 0) {
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"OrderTrackCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:CellIdentifier];
        }
        OrderTrackCell *cell = (OrderTrackCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (indexPath.row != 0) {
            cell.iconImageView.image = [UIImage imageNamed:@"my_track_point"];
        }
        NSString *dateStr = [[_dataArray[indexPath.row] objectForKey:@"time"] substringWithRange:NSMakeRange(0, 16)];
        cell.locationCompany.text = [_dataArray[indexPath.row] objectForKey:@"context"];
        cell.informationFrom.text = _model.express_name;
        cell.waybill.text = _model.express_code;
        cell.date.text = dateStr;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:noDataCellIdentifier];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"数据为空");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

#pragma mark -- tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorRGBWithRed:252 green:110 blue:146 alpha:1.f];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 80, 20)];
    label1.text = MyLocalizedString(@"支付方式");
    label1.font = [UIFont systemFontOfSize:16.f];
    label1.textColor = [UIColor whiteColor];
    
    UILabel *payStatue = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 200, 20)];
    payStatue.text = _payStatue;
    payStatue.font = [UIFont systemFontOfSize:16.f];
    payStatue.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 80, 20)];
    label2.text = MyLocalizedString(@"承运人");
    label2.font = [UIFont systemFontOfSize:16.f];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *assume = [[UILabel alloc] initWithFrame:CGRectMake(70, 60, 200, 20)];
    assume.text = _assume;
    assume.font = [UIFont systemFontOfSize:16.f];
    assume.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 90, 80, 20)];
    label3.text = MyLocalizedString(@"订单号");
    label3.font = [UIFont systemFontOfSize:16.f];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *orderNumber = [[UILabel alloc] initWithFrame:CGRectMake(70, 90, 220, 20)];
    orderNumber.text = _code;
    orderNumber.font = [UIFont systemFontOfSize:16.f];
    orderNumber.textColor = [UIColor whiteColor];
    
    [headerView addSubview:label1];
    [headerView addSubview:payStatue];
    [headerView addSubview:label2];
    [headerView addSubview:assume];
    [headerView addSubview:label3];
    [headerView addSubview:orderNumber];
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLogisticeNoticefationName object:nil];
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
