//
//  OrderDetailFirstCell.m
//  Love
//
//  Created by use on 14-11-20.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "OrderDetailFirstCell.h"

@implementation OrderDetailFirstCell

- (void)awakeFromNib {
    // Initialization code
    _orderNumber.text = _orderNum;
    
    _cancleOrder.layer.masksToBounds = YES;
    _cancleOrder.layer.cornerRadius = 4.f;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _cancleOrder.frame = CGRectMake(kScreenWidth - 70, 8, 60, 26);
    _backView.frame = CGRectMake(0, 45, kScreenWidth, 30);
    _orderMoney.frame = CGRectMake(kScreenWidth - 111, 5, 101, 21);
    _orderSumMoney.frame = CGRectMake(kScreenWidth - 104, 73, 94, 21);
    _rebateMoney.frame = CGRectMake(kScreenWidth - 104, 91, 94, 21);
    _postage.frame = CGRectMake(kScreenWidth - 104, 107, 94, 21);
}

- (IBAction)cancleOrderAction:(id)sender {
    
    [_delegate getCancleButtonAction:sender];
    
}
@end
