//
//  AfterSaleDetailViewController.m
//  Love
//
//  Created by use on 14-11-24.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "AfterSaleDetailViewController.h"
#import "ComplainViewController.h"
#import "ReturnPurchaseViewController.h"
#import "ReturnMoneyViewController.h"

@interface AfterSaleDetailViewController ()
@property (nonatomic ,strong) NSMutableArray *dataArray;
@end

@implementation AfterSaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"退货",@"退款",@"维权", nil];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"您需要的售后服务";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    for (int i = 0; i < [_dataArray count]; i++) {
        UIButton *bnt = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 200)/2, 120+60*i, 200, 40)];
        [bnt setTitle:_dataArray[i] forState:UIControlStateNormal];
        [bnt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        bnt.backgroundColor = [UIColor clearColor];
        bnt.layer.masksToBounds = YES;
        bnt.layer.cornerRadius = 4.f;
        bnt.tag = 100 + i;
        bnt.layer.borderColor = [[UIColor colorRGBWithRed:230 green:63 blue:105 alpha:1.f] CGColor];
        bnt.layer.borderWidth = 1.f;
        [bnt addTarget:self action:@selector(afterSaleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bnt];
    }
    
}

- (void)afterSaleButtonClicked:(UIButton*)sender {
    if (sender.tag == 101) {
        NSLog(@"1");
        ReturnPurchaseViewController *returnPurchaseVC = [[ReturnPurchaseViewController alloc] init];
        returnPurchaseVC.title = _dataArray[sender.tag - 100];
        returnPurchaseVC.orderNumber = _orderNumber;
        returnPurchaseVC.orderMoney = _orderMoney;
        returnPurchaseVC.orderStatus = _orderStatus;
        [self.navigationController pushViewController:returnPurchaseVC animated:YES];
    }
    if (sender.tag == 100) {
        NSLog(@"2");
        ReturnMoneyViewController *returnMoneyVC = [[ReturnMoneyViewController alloc] init];
        returnMoneyVC.title = _dataArray[sender.tag - 100];
        returnMoneyVC.orderNumber = _orderNumber;
        returnMoneyVC.orderStatus = _orderStatus;
        [self.navigationController pushViewController:returnMoneyVC animated:YES];
    }
    if (sender.tag == 102) {
        NSLog(@"3");
        ComplainViewController *complainVC = [[ComplainViewController alloc] init];
        complainVC.title = _dataArray[sender.tag - 100];
        complainVC.orderNumber = _orderNumber;
        [self.navigationController pushViewController:complainVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
