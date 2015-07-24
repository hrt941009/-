//
//  OrderDetailController.m
//  Love
//
//  Created by use on 14-11-21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailFirstCell.h"
#import "OrderDetailSecondCell.h"
#import "OrderDetailThirdCell.h"
#import "PaymentViewController.h"
#import "ReciveViewController.h"

#import "OrderDetailModel.h"
#import "SendGoodsModel.h"

#import "UIScrollView+MJRefresh.h"
#import "UIImageView+WebCache.h"
//#import "SVProgressHUD.h"

#define firstCellHeight 135
#define secondCellHeight 85
#define thirdCellHeight 70
#define elseCellHeight 50


@interface OrderDetailController ()<UITableViewDataSource,UITableViewDelegate,getCancleButtonActionDelegate,UIAlertViewDelegate>
{
    UILabel *userLabel;
    UILabel *phoneNum;
    UILabel *adressLabel;
    UILabel *freightWay;
    UILabel *postWay;
    UILabel *invoiceLabel;
    UILabel *invoiceWay;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UINib *nib1;
@property(nonatomic,strong)UINib *nib2;

@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *notiArray;

@end

@implementation OrderDetailController

- (id)init{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"订单详情");
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orderDetailData:)
                                                 name:kOrderDetailNotificationName
                                               object:nil];
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, 227);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = YES;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    [self createView];
    
    [OrderDetailModel getOrderDetail:_orderDetailCode];
    
//    [SVProgressHUD show];
}

-(void)createView{
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 230, kScreenWidth, 1)];
    aView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:aView];
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 1)];
    bView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bView];
    
    userLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 100, 30)];
    userLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:userLabel];
    
    phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 170, 230, 150, 30)];
    phoneNum.backgroundColor = [UIColor clearColor];
    phoneNum.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:phoneNum];
    
    adressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, kScreenWidth - 20, 40)];
    adressLabel.backgroundColor = [UIColor clearColor];
    adressLabel.numberOfLines = 0;
    adressLabel.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:adressLabel];
    
    freightWay = [[UILabel alloc] initWithFrame:CGRectMake(10, 310, 100, 20)];
    freightWay.backgroundColor = [UIColor clearColor];
    freightWay.text = MyLocalizedString(@"运货方式");
    [self.view addSubview:freightWay];
    
    postWay = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 220, 310, 200, 20)];
    postWay.backgroundColor = [UIColor clearColor];
    postWay.text = MyLocalizedString(@"申通快递");
    postWay.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:postWay];
    
    invoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 340, 100, 20)];
//    invoiceLabel.text = @"发票信息";
    invoiceLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:invoiceLabel];
    
    invoiceWay = [[UILabel alloc] initWithFrame:CGRectMake(100, 340, 200, 20)];
    invoiceWay.backgroundColor = [UIColor clearColor];
//    invoiceWay.text = @"22222";
    invoiceWay.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:invoiceWay];
//    [SVProgressHUD dismiss];
    
}

- (void) orderDetailData:(NSNotification*)noti{
    _notiArray = [[NSMutableArray alloc] init];
    [_notiArray addObjectsFromArray:[noti object]];
    OrderDetailModel *model = (OrderDetailModel*)[_notiArray lastObject];
    [_dataArray addObjectsFromArray: model.order_detail];
    [self.tableView reloadData];
    userLabel.text = [model.adress_info objectForKey:@"consignee"];
    phoneNum.text = [model.adress_info objectForKey:@"mobile"];
    adressLabel.text = [model.adress_info objectForKey:@"adress"];
    
    
    if ([model.status isEqualToString:@"0"]) {
        UIButton *bnt = [self createButtonAndLabelText:MyLocalizedString(@"付款")];
        [self.view addSubview:bnt];
    }
    if ([model.status isEqualToString:@"1"]) {
        UIButton *bnt = [self createButtonAndLabelText:MyLocalizedString(@"提醒发货")];
        [self.view addSubview:bnt];
    }
    if ([model.status isEqualToString:@"2"]) {
        UIButton *bnt = [self createButtonAndLabelText:MyLocalizedString(@"确认收货")];
        [self.view addSubview:bnt];
    }
//    [SVProgressHUD dismiss];
}

#pragma mark -- tableViewDataSouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return [_dataArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    
    if (section == 0) {
        if (!_nib1) {
            _nib1 = [UINib nibWithNibName:@"OrderDetailFirstCell" bundle:nil];
            [tableView registerNib:_nib1 forCellReuseIdentifier:CellIdentifier1];
        }
        OrderDetailFirstCell *cell = (OrderDetailFirstCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (_notiArray) {
            OrderDetailModel *model = (OrderDetailModel*)_notiArray[0];
            cell.cancleOrder.hidden = YES;
            if ([model.status isEqual:@"0"]) {
                cell.orderStatus.text = MyLocalizedString(@"待付款");
                cell.cancleOrder.hidden = NO;
            }
            if ([model.status isEqual:@"1"]) {
                cell.orderStatus.text = MyLocalizedString(@"待发货");
            }
            if ([model.status isEqual:@"2"]) {
                cell.orderStatus.text = MyLocalizedString(@"待收货");
            }
            if ([model.status isEqual:@"3"]) {
                cell.orderStatus.text = MyLocalizedString(@"已发货");
            }
            if ([model.status isEqual:@"31"]) {
                cell.orderStatus.text = MyLocalizedString(@"已评论");
            }
            if ([model.status isEqual:@"4"]) {
                cell.orderStatus.text = MyLocalizedString(@"已取消");
            }
            if ([model.status isEqual:@"5"]) {
                cell.orderStatus.text = MyLocalizedString(@"退款申请中");
            }
            if ([model.status isEqual:@"50"]) {
                cell.orderStatus.text = MyLocalizedString(@"确认退款");
            }
            if ([model.status isEqual:@"51"]) {
                cell.orderStatus.text = MyLocalizedString(@"待退货");
            }
            if ([model.status isEqual:@"52"]) {
                cell.orderStatus.text = @"已退货";
            }
            if ([model.status isEqual:@"53"]) {
                cell.orderStatus.text = @"卖家收货";
            }
//订单状态( -1-所有订单，0-未支付，1-待发货，2-已发货，3-已收货，4-已取消，31-已评论)，5-退款申请中，51-待退货，52-已退货，53-卖家收货，50-确认退款)
            cell.orderNumber.text = model.orderDetailId;
            cell.orderMoney.text = [NSString stringWithFormat:@"%@元",model.total_price];
            cell.rebateMoney.text = [NSString stringWithFormat:@"%d币",[model.rebate intValue]];
            cell.orderSumMoney.text = [NSString stringWithFormat:@"%@元",model.total_price];
            cell.postage.text = [NSString stringWithFormat:@"%@元",model.post_price];
        }
        cell.delegate = self;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (section == 1) {
        if (!_nib2) {
            _nib2 = [UINib nibWithNibName:@"OrderDetailSecondCell" bundle:nil];
            [tableView registerNib:_nib2 forCellReuseIdentifier:CellIdentifier2];
        }
        OrderDetailSecondCell *cell = (OrderDetailSecondCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        NSString *imgUrl = [_dataArray[indexPath.row] objectForKey:@"product_thumb"];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:kDefalutFlagImageDownload]];
        cell.introduce.text = [_dataArray[indexPath.row] objectForKey:@"product_name"];
        cell.introduce.numberOfLines = 0;
        cell.number.text = [_dataArray[indexPath.row] objectForKey:@"num"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }

    return nil;
}
#pragma mark -- tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return firstCellHeight;
    }else if (indexPath.section == 1){
        return secondCellHeight;
    }
    return 0;
}


//创建底部Button的方法
- (UIButton*)createButtonAndLabelText:(NSString*)labelText{
    UIButton *confirm = [[UIButton alloc] init];
    confirm.frame = CGRectMake(25, kScreenHeight-100, kScreenWidth-50, 28);
    confirm.backgroundColor = [UIColor colorRGBWithRed:230 green:63 blue:105 alpha:1];
    [confirm setTitle:labelText forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirm.titleLabel.font = [UIFont systemFontOfSize:15.f];
    confirm.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    confirm.layer.masksToBounds = YES;
    confirm.layer.cornerRadius = 3.f;
    [confirm addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return confirm;
}

//“确认收货”点击触发事件

-(void)confirmButtonClicked:(UIButton*)sender{
    OrderDetailModel *model = (OrderDetailModel*)_notiArray[0];
    if ([model.status isEqual:@"0"]) {
        PaymentViewController *payVC = [[PaymentViewController alloc] init];
        payVC.orderNum = self.orderDetailCode;
        [self.navigationController pushViewController:payVC animated:YES];
    }
    if ([model.status isEqual:@"1"]) {
        NSLog(@"提醒发货");
        __unsafe_unretained typeof(self) mySelf = self;
        [SendGoodsModel sendGoodsForCode:model.code block:^(int code, NSString *msg) {
            if (code == 1) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"已提醒卖家发货") delegate:mySelf cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }
    if ([model.status isEqual:@"2"]) {
        NSLog(@"确认收货");
        __unsafe_unretained typeof(self) mySelf = self;
        [SendGoodsModel reciveForStatusandCode:model.code block:^(int code) {
            if (code == 1) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"收货完成") delegate:mySelf cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"收货失败" )delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];

    }
    
}

#pragma mark -- getCancleButtonClick
- (void)getCancleButtonAction:(UIButton*)button{
//    [self.navigationController popViewControllerAnimated:YES];
    
    [SendGoodsModel orderCancleForCode:_orderDetailCode andStatus:@"4" block:^(int code) {
        if (code == 1) {
            if ([_delegate respondsToSelector:@selector(orderCancleButtonClick)]) {
                [_delegate orderCancleButtonClick];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"取消订单出错") delegate:self cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
    
    
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kOrderDetailNotificationName object:nil];
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
