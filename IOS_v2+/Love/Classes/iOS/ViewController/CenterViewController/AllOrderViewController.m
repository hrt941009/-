//
//  AllOrderViewController.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//订单状态( -1-所有订单，0-未支付，1-待发货，2-已发货，3-已收货，4-已取消，31-已评论)，5-退款申请中，51-待退货，52-已退货，53-卖家收货，50-确认退款)
#import "AllOrderViewController.h"
#import "AllOrderCell.h"
#import "OrderDetailController.h"
#import "PaymentViewController.h"
#import "ReciveViewController.h"

#import "AllOrderModel.h"
#import "OrderDetailModel.h"

#import "UIScrollView+MJRefresh.h"
#import "UIImageView+WebCache.h"

#import "LOVPageConfig.h"

#import "SendGoodsModel.h"

NSString * const kAllOrderStatus = @"-1";//所有商品
NSString * const kPayOrderStatus = @"0";//待付款
NSString * const kSendGoodsStatus = @"1";//待发货
NSString * const kPostStatus = @"3";//已收货
NSString * const kReciveStatus = @"2";//待收货
NSString * const kCancleStatus = @"4";//已取消
NSString * const kReturnMoneyStatus = @"5";//退款申请中
NSString * const kCommentStatus = @"31";//已评论
NSString * const kWillReturnStatus = @"51";//待退货
NSString * const kDidReturnStatus = @"52";//已退货
NSString * const kSellerDidGetCommodityStatus = @"53";//卖家收货
NSString * const kReturnMoneyDtatus = @"50";//确认退款

@interface AllOrderViewController ()<UITableViewDataSource, UITableViewDelegate,OrderCellButtonClickDelegate,UIAlertViewDelegate, OrderDetailDelegate>
{
    int nextPage;
    NSIndexPath *myIndexPath;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *statusArray;

@property (nonatomic, strong) NSMutableArray *payArray;
@property (nonatomic, strong) NSMutableArray *shipper;
@property (nonatomic, strong) NSMutableArray *takeOver;
@property (nonatomic, strong) NSMutableArray *orderFinish;

@property (nonatomic, strong) UINib *nib;

@property (nonatomic, strong) AllOrderModel *model;


@end

@implementation AllOrderViewController

#pragma mark -- OrderDetailDelegate
- (void)orderCancleButtonClick{
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 刷新
- (void)addFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDataAction];
    }];
}

- (id)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        
        nextPage = 1;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(allOrderDataNotice:)
                                                 name:kAllOrderListNotificationName
                                               object:nil];
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self addHeader];
    [self addFooter];
    
}

- (void)addHeader{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    __block NSInteger orderStatus = _orderStatus;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        if (orderStatus == MyOrderStatusALl) {
            [AllOrderModel getAllOrderStatus:kAllOrderStatus andPage:kLovStartPage andPageNum:kLovPageNumber];
        }
        if (orderStatus == MyOrderStatusPay) {
            [AllOrderModel getAllOrderStatus:kPayOrderStatus andPage:kLovStartPage andPageNum:kLovPageNumber];
        }
        if (orderStatus == MyOrderStatusSendGoods) {
            [AllOrderModel getAllOrderStatus:kSendGoodsStatus andPage:kLovStartPage andPageNum:kLovPageNumber];
        }
        if (orderStatus == MyOrderStatusReceive) {
            [AllOrderModel getAllOrderStatus:kReciveStatus andPage:kLovStartPage andPageNum:kLovPageNumber];
        }
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)allOrderDataNotice:(NSNotification*)noti{
    [self.dataArray addObjectsFromArray: noti.object];
    [self.tableView reloadData];
    
    if ([_dataArray count] == 0) {
        [self.tableView setFooterHidden:YES];
    }
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)loadingDataAction{
    nextPage = nextPage + 1;
    if (_orderStatus == MyOrderStatusALl) {
        [AllOrderModel getAllOrderStatus:kAllOrderStatus andPage:[NSString stringWithFormat:@"%d",nextPage] andPageNum:kLovPageNumber];
    }
    if (_orderStatus == MyOrderStatusPay) {
        [AllOrderModel getAllOrderStatus:kPayOrderStatus andPage:[NSString stringWithFormat:@"%d",nextPage] andPageNum:kLovPageNumber];
    }
    if (_orderStatus == MyOrderStatusSendGoods) {
        [AllOrderModel getAllOrderStatus:kSendGoodsStatus andPage:[NSString stringWithFormat:@"%d",nextPage] andPageNum:kLovPageNumber];
    }
    if (_orderStatus == MyOrderStatusReceive) {
        [AllOrderModel getAllOrderStatus:kReciveStatus andPage:[NSString stringWithFormat:@"%d",nextPage] andPageNum:kLovPageNumber];
    }
    
//    [self.tableView footerEndRefreshing];
//    [self.tableView headerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAllOrderListNotificationName object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"kAllOrderCellIdentifier";
    static NSString *noDataCellIdentifier = @"noDataCellIdentifier";
    if ([_dataArray count] > 0) {
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"AllOrderCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:kCellIdentifier];
        }
        AllOrderCell *cell = (AllOrderCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        cell.delegate = self;
        [cell.contentView bringSubviewToFront:cell.orderStatusButton];
        [cell.contentView bringSubviewToFront:cell.receivedButton];
        [cell.contentView bringSubviewToFront:cell.centerLine];
        [cell.contentView bringSubviewToFront:cell.orderDateLabel];
        [cell.contentView bringSubviewToFront:cell.orderNumberLabel];
        [cell.contentView bringSubviewToFront:cell.orderPriceLabel];
        [cell.contentView bringSubviewToFront:cell.orderDate];
        [cell.contentView bringSubviewToFront:cell.orderNumber];
        [cell.contentView bringSubviewToFront:cell.orderPrice];
        [cell.contentView bringSubviewToFront:cell.orderStatus];
        [cell.contentView bringSubviewToFront:cell.orderStatusLabel];
//        去除复用cell里面的内容
        for (UIView * vi in cell.bgView.subviews) {
            [vi removeFromSuperview];
        }
        _model = _dataArray[indexPath.row];
        cell.orderPriceLabel.text = _model.total_price;
        cell.orderDateLabel.text = _model.create_time;
        if ([_model.status isEqual:@"0"]) {
            cell.orderStatusLabel.text = MyLocalizedString(@"未支付");
        }
        else if ([_model.status isEqual:@"1"]) {
            cell.orderStatusLabel.text = MyLocalizedString(@"待发货");
        }
        else if ([_model.status isEqual:@"2"]) {
            cell.orderStatusLabel.text = MyLocalizedString(@"待收货");
        }
        else if ([_model.status isEqual:@"3"]) {
            cell.orderStatusLabel.text = MyLocalizedString(@"订单完成");
        }
        else if ([_model.status isEqual:@"4"]){
            cell.orderStatusLabel.text = MyLocalizedString(@"订单取消");
        }
        else if ([_model.status isEqual:@"5"]){
            cell.orderStatusLabel.text = MyLocalizedString(@"退款申请中");
        }
        else if ([_model.status isEqual:@"31"]){
            cell.orderStatusLabel.text = MyLocalizedString(@"已评论");
        }
        else if ([_model.status isEqual:@"51"]){
            cell.orderStatusLabel.text = MyLocalizedString(@"待退货");
        }
        else if ([_model.status isEqual:@"52"]){
            cell.orderStatusLabel.text = MyLocalizedString(@"已退货");
        }
        else if ([_model.status isEqual:@"53"]){
            cell.orderStatusLabel.text = MyLocalizedString(@"卖家确认");
        }
        else if ([_model.status isEqual:@"50"]){
            cell.orderStatusLabel.text = MyLocalizedString(@"确认退款");
        }
        //    cell.titleLabel.text = _model.seller_name;
        CGFloat height = 192.f - 14.f + ([_model.order_detail count] - 1)*60;
        [cell.bgView setFrame:CGRectMake(0, 14, kScreenWidth, height)];
        
/*
    获取的数据中，颜色和尺寸的数据为空导致崩溃
 */
        for (int i = 0; i < [_model.order_detail count]; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 84 + 65 * i, 50, 50)];
            NSDictionary *dic = _model.order_detail[i];
            NSString *img = [dic objectForKey:@"product_thumb"];
            NSURL *imgUrl = [NSURL URLWithString:img];
            [imageView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            [cell.bgView addSubview:imageView];
            
            if (i != [_model.order_detail count] - 1) {
                UIView *lineVi = [[UIView alloc] initWithFrame:CGRectMake(5, 138 + 65 * i, kScreenWidth - 10, 0.5)];
                lineVi.backgroundColor = [UIColor grayColor];
                [cell.bgView addSubview:lineVi];
            }
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 70 + 65 * i, kScreenWidth - 110, 50)];
            titleLabel.text = [_model.order_detail[i] objectForKey:@"product_name"];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.numberOfLines = 0;
            titleLabel.font = [UIFont systemFontOfSize:12.f];
            [cell.bgView addSubview:titleLabel];
            
            UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 115 + 65 * i, 60, 20)];
            colorLabel.text = MyLocalizedString(@"颜色分类");
            colorLabel.backgroundColor = [UIColor clearColor];
            colorLabel.font = [UIFont systemFontOfSize:12.f];
            [cell.bgView addSubview:colorLabel];
            
            
            
            UILabel *color = [[UILabel alloc] initWithFrame:CGRectMake(140, 115 + 65 * i, 160, 20)];
            NSArray *sanddard = [_model.order_detail[i] objectForKey:@"commo_standard"];
            if (sanddard.count == 2)
            {
                NSString *colorStr = sanddard[0];
                NSString *sizeStr = sanddard[1];
                color.text = [NSString stringWithFormat:@"%@  %@",colorStr,sizeStr];
            }
            if (sanddard.count == 1) {
                NSString *colorStr = sanddard[0];
                color.text = [NSString stringWithFormat:@"%@",colorStr];
            }
            
            color.backgroundColor = [UIColor clearColor];
            color.font = [UIFont systemFontOfSize:12.f];
            [cell.bgView addSubview:color];
            
        }
        
        switch (_orderStatus) {
            case MyOrderStatusALl:
                cell.orderNumberLabel.text = _model.code;
                if ([_model.status  isEqual: @"0"]) {
                    //                cell.orderStatusLabel.text = @"未支付";
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"付款") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor colorRGBWithRed:229 green:63 blue:105 alpha:1]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status  isEqual: @"1"]){
                    //                cell.orderStatusLabel.text = @"待发货";
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"提醒发货") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor colorRGBWithRed:229 green:63 blue:105 alpha:1]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status  isEqual: @"2"]){
                    //                cell.orderStatusLabel.text = @"已发货";
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"订单追踪") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor colorRGBWithRed:229 green:63 blue:105 alpha:1]];
                    cell.receivedButton.alpha = 1;
                }
                if ([_model.status isEqual:@"3"]){
                    //                cell.orderStatusLabel.text = @"订单完成";
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"订单追踪") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor colorRGBWithRed:229 green:63 blue:105 alpha:1]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status isEqual:@"4"]){
//                    [cell.orderStatusButton removeFromSuperview];
//                    cell.orderStatusButton.alpha = 0;
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"订单取消") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor lightGrayColor]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status isEqual:@"5"]){
//                    cell.orderStatusButton.alpha = 0;
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"退货申请中") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor lightGrayColor]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status isEqual:@"31"]){
                    //                    cell.orderStatusButton.alpha = 0;
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"已评论") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor lightGrayColor]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status isEqual:@"51"]){
                    //                    cell.orderStatusButton.alpha = 0;
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"待退货") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor lightGrayColor]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status isEqual:@"52"]){
                    //                    cell.orderStatusButton.alpha = 0;
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"已退货") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor lightGrayColor]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status isEqual:@"53"]){
                    //                    cell.orderStatusButton.alpha = 0;
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"卖家确认") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor lightGrayColor]];
                    cell.receivedButton.alpha = 0;
                }
                if ([_model.status isEqual:@"50"]){
                    //                    cell.orderStatusButton.alpha = 0;
                    [cell.orderStatusButton setTitle:MyLocalizedString(@"确认退款") forState:UIControlStateNormal];
                    [cell.orderStatusButton setBackgroundColor:[UIColor lightGrayColor]];
                    cell.receivedButton.alpha = 0;
                }
                break;
            case MyOrderStatusPay:
                [cell.orderStatusButton setTitle:MyLocalizedString(@"付款") forState:UIControlStateNormal];
                cell.receivedButton.alpha = 0;
                cell.orderNumberLabel.text = _model.code;
                //            cell.orderStatusLabel.text = @"待付款";
                break;
            case MyOrderStatusSendGoods:
                [cell.orderStatusButton setTitle:MyLocalizedString(@"提醒发货") forState:UIControlStateNormal];
                cell.receivedButton.alpha = 0;
                cell.orderNumberLabel.text = _model.code;
                //            cell.orderStatusLabel.text = @"待发货";
                break;
            case MyOrderStatusReceive:
                [cell.orderStatusButton setTitle:MyLocalizedString(@"订单追踪") forState:UIControlStateNormal];
                cell.receivedButton.alpha = 1;
                cell.orderNumberLabel.text = _model.code;
                //            cell.orderStatusLabel.text = @"待收货";
                break;
                
            default:
                break;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:noDataCellIdentifier];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"还没有订单");
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    

}
//点击付款，提醒发货，订单追踪触发的事件
- (void)orderButtonClick:(UIButton*)button{
    if (_orderStatus == MyOrderStatusPay) {
        myIndexPath = nil;
        myIndexPath = [_tableView indexPathForCell:(AllOrderCell *)[[[button superview] superview] superview]];
        AllOrderModel *model = (AllOrderModel*)_dataArray[myIndexPath.row];
        [OrderDetailModel getOrderDetail:model.code];
        PaymentViewController *paymentVC = [[PaymentViewController alloc] init];
        paymentVC.orderNum = model.code;
        [self.navigationController pushViewController:paymentVC animated:YES];
        
        
    }else if (_orderStatus == MyOrderStatusSendGoods){
        NSString *orderNum = [self getOrderNumber:button];
//        SendGoodsViewController *sendGoodsVC = [[SendGoodsViewController alloc] init];
//        sendGoodsVC.orderNum = orderNum;
//        [self.navigationController pushViewController:sendGoodsVC animated:YES];
        __unsafe_unretained typeof(self) mySelf = self;
        [SendGoodsModel sendGoodsForCode:orderNum block:^(int code, NSString *msg) {
            if (code == 1) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"已给提醒卖家发货") delegate:mySelf cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }else if (_orderStatus == MyOrderStatusReceive){
        NSIndexPath *indexPath = nil;
        if (VersionNumber_iOS_8) {
            indexPath = [_tableView indexPathForCell:(AllOrderCell*)[[button superview] superview]];
        }else{
            indexPath = [_tableView indexPathForCell:(AllOrderCell*)[[button superview] superview]];
        }
        
        NSInteger row = indexPath.row;
        _model = (AllOrderModel*)_dataArray[row];
        NSString *orderNum = _model.orderId;
        ReciveViewController *reciveVC = [[ReciveViewController alloc] init];
        reciveVC.orderNum = orderNum;
        reciveVC.code = _model.code;
        [self.navigationController pushViewController:reciveVC animated:YES];
    }else if (_orderStatus == MyOrderStatusALl){
//        所有订单中的button点击事件
        NSIndexPath *indexPath = nil;
        if (VersionNumber_iOS_8) {
            indexPath = [_tableView indexPathForCell:(AllOrderCell*)[[button superview] superview]];
        }else{
            indexPath = [_tableView indexPathForCell:(AllOrderCell*)[[button superview] superview]];
        }
        
        NSInteger row = indexPath.row;
        _model = (AllOrderModel*)_dataArray[row];
        if ([_model.status  isEqual: @"0"]) {
            PaymentViewController *paymentVC = [[PaymentViewController alloc] init];
            paymentVC.orderNum = _model.code;
            paymentVC.customerID = _model.orderId;
            //        paymentVC.phoneNum = model.
            paymentVC.payAll = _model.total_price;
            [self.navigationController pushViewController:paymentVC animated:YES];
        }else if ([_model.status  isEqual: @"1"]) {
            NSLog(@"提醒发货");
            __unsafe_unretained typeof(self) mySelf = self;
            [SendGoodsModel sendGoodsForCode:_model.code block:^(int code, NSString *msg) {
                if (code == 1) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"已给提醒卖家发货") delegate:mySelf cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }];
        }else if ([_model.status  isEqual: @"2"]){
            ReciveViewController *reciveVC = [[ReciveViewController alloc] init];
            reciveVC.orderNum = _model.code;
            [self.navigationController pushViewController:reciveVC animated:YES];
        }else if ([_model.status isEqual: @"3"]){
            ReciveViewController *reciveVC = [[ReciveViewController alloc] init];
            reciveVC.orderNum = _model.code;
            [self.navigationController pushViewController:reciveVC animated:YES];
        }else{
            
        }
    }
    
}

- (NSString *)getOrderNumber:(UIButton*)button{
    NSIndexPath *indexPath = nil;
    AllOrderCell *cell = (AllOrderCell*)[[[button superview] superview] superview];
    indexPath = [_tableView indexPathForCell:cell];
    NSInteger row = [indexPath row];
    _model = (AllOrderModel*)_dataArray[row];
    return _model.code;
}


//点击“确认收货”按钮触发事件
- (void) reciveButtonClick:(UIButton *)button{
    NSIndexPath *indexPath = nil;
    indexPath = [_tableView indexPathForCell:(AllOrderCell*)[[button superview] superview]];
    NSInteger row = indexPath.row;
    _model = (AllOrderModel*)_dataArray[row];
    __unsafe_unretained typeof(self) mySelf = self;
    [SendGoodsModel reciveForStatusandCode:_model.code block:^(int code) {
        if (code == 1) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"收货完成") delegate:mySelf cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"收货失败") delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] > 0) {
        _model = (AllOrderModel*)_dataArray[indexPath.row];
        return 192.f + ([_model.order_detail count] - 1)*60;
    }else{
        return 192.f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] > 0) {
        OrderDetailController *orderDetailVC = [[OrderDetailController alloc] init];
        _model = (AllOrderModel*)_dataArray[indexPath.row];
        orderDetailVC.orderDetailCode = _model.code;
        orderDetailVC.delegate = self;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
}


#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.tableView headerBeginRefreshing];
    }
}

@end
