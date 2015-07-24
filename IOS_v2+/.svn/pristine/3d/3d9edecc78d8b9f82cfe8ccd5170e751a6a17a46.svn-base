//
//  PaymentViewController.m
//  Love
//
//  Created by use on 14-11-21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "PaymentViewController.h"
#import "OrderDetailModel.h"
#import "PayViewController.h"
//#import "SVProgressHUD.h"
#import "WXPayModel.h"
#import "LOVWXPayClient.h"

@interface PaymentViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) OrderDetailModel *model;
@property (nonatomic, strong) UIButton *button;

@end

@implementation PaymentViewController

- (void)WXPaySuccessClick:(NSNotification *)noti{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = MyLocalizedString(@"立即支付");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orderDetailDataNotice:)
                                                 name:kOrderDetailNotificationName
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(WXPaySuccessClick:) name:@"WXPaySuccessNotification"
                                               object:nil];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(20, kScreenHeight - 55 - 64, kScreenWidth-40, 35);
        [_button setTitle:MyLocalizedString(@"支付") forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor colorRGBWithRed:210 green:50 blue:90 alpha:1];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 4.f;
        [_button addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
    
    
    [OrderDetailModel getOrderDetail:_orderNum];
//    [SVProgressHUD show];
}

- (void)orderDetailDataNotice:(NSNotification*)noti{
    _model = [noti.object lastObject];
    _address = [_model.adress_info objectForKey:@"adress"];
    _phoneNum = [_model.adress_info objectForKey:@"mobile"];
    _customerName = [_model.adress_info objectForKey:@"consignee"];
    _payAll = _model.total_price;
    _balance = _model.total_price;
    [self.tableView reloadData];
    
//    [SVProgressHUD dismiss];
}

- (void)payAction:(id)sender{
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信支付",@"支付宝支付",@"支付宝网页支付", nil];
    [myActionSheet showInView:self.view];
    
//    NSLog(@"支付");
    
    
}

#pragma mark -- tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIdentifier = @"complainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        UILabel *leftLabel = [self createLabel:CGRectMake(10, 0, 70, 50) andLabelText:MyLocalizedString(@"订单号")];
        UILabel *orderNUmLabel = [self createLabel:CGRectMake(kScreenWidth - 240, 0, 220, 50) andLabelText:_orderNum];
        orderNUmLabel.textAlignment = NSTextAlignmentRight;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:leftLabel];
        [cell addSubview:orderNUmLabel];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        UILabel *firstLabel = [self createLabel:CGRectMake(10, 0, kScreenWidth, 30) andLabelText:MyLocalizedString(@"收货地址")];
        UILabel *addressLabel = [self createLabel:CGRectMake(70, 15, kScreenWidth, 50) andLabelText:_address];
        addressLabel.numberOfLines = 0;
        UILabel *customerLabel = [self createLabel:CGRectMake(70, 62, 100, 30) andLabelText:_customerName];
        UILabel *phoneNum = [self createLabel:CGRectMake(kScreenWidth - 120, 62, 100, 30) andLabelText:_phoneNum];
        phoneNum.textAlignment = NSTextAlignmentRight;
        phoneNum.textColor = [UIColor colorRGBWithRed:220 green:60 blue:100 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:firstLabel];
        [cell addSubview:addressLabel];
        [cell addSubview:customerLabel];
        [cell addSubview:phoneNum];
    }else if (indexPath.section == 0 && indexPath.row == 2){
        UILabel *leftLabel = [self createLabel:CGRectMake(10, 0, 100, 50) andLabelText:MyLocalizedString(@"应付总额")];
        UILabel *payAllLabel = [self createLabel:CGRectMake(kScreenWidth - 120, 0, 100, 50) andLabelText:_payAll];
        payAllLabel.textAlignment = NSTextAlignmentRight;
        payAllLabel.textColor = [UIColor colorRGBWithRed:220 green:60 blue:100 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:leftLabel];
        [cell addSubview:payAllLabel];
    }else if (indexPath.section == 0 && indexPath.row == 3){
        UILabel *leftLabel = [self createLabel:CGRectMake(10, 0, 100, 50) andLabelText:MyLocalizedString(@"账户余额")];
        UILabel *blanceLabel = [self createLabel:CGRectMake(kScreenWidth - 120, 0, 100, 50) andLabelText:_payAll];
        blanceLabel.textColor = [UIColor colorRGBWithRed:220 green:60 blue:100 alpha:1];
        blanceLabel.textAlignment = NSTextAlignmentRight;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:leftLabel];
        [cell addSubview:blanceLabel];
    }else{

    }
    
    return cell;
}

- (UILabel *)createLabel:(CGRect)rect andLabelText:(NSString *)labelText{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = labelText;
    label.font = [UIFont systemFontOfSize:12.f];
    [label setTextColor:[UIColor colorRGBWithRed:100 green:100 blue:100 alpha:1.f]];
    return label;
}

#pragma mark -- tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 100;
        }
        return 50;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor colorRGBWithRed:235 green:235 blue:235 alpha:1.f];
    if (section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(	10, 0, 100, 50)];
        label.text = MyLocalizedString(@"支付信息");
        [firstView addSubview:label];
    }
    return firstView;
}

#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"weixin");
        [WXPayModel getWXParagamWithCode:_orderNum block:^(NSString *appId, NSString *nonceStr, NSString *package, NSString *partnerId, NSString *prepayId, NSString *sign, NSString *timeStamp) {
            [[LOVWXPayClient shareInstance] parametersWithPartnerId:appId parpayId:prepayId package:package nonceStr:nonceStr timeStamp:timeStamp sign:sign];
            [[LOVWXPayClient shareInstance] payProduct];
        }];

    }
    if (buttonIndex == 1) {
        NSLog(@"zhifubao");
    }
    if (buttonIndex == 2) {
        NSLog(@"支付宝网页支付");
        PayViewController *payVC = [[PayViewController alloc] init];
        payVC.code = _orderNum;
        //    [self.navigationController pushViewController:payVC animated:YES];
        [self.navigationController presentViewController:payVC animated:YES completion:nil];
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
