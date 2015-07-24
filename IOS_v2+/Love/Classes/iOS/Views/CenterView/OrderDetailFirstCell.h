//
//  OrderDetailFirstCell.h
//  Love
//
//  Created by use on 14-11-20.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol getCancleButtonActionDelegate <NSObject>

- (void)getCancleButtonAction:(UIButton*)button;

@end

@interface OrderDetailFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *orderMoney;
@property (weak, nonatomic) IBOutlet UILabel *orderSumMoney;
@property (weak, nonatomic) IBOutlet UILabel *rebateMoney;
@property (weak, nonatomic) IBOutlet UILabel *postage;

@property (nonatomic ,weak) id<getCancleButtonActionDelegate>delegate;

@property (nonatomic,strong)NSString *orderNum;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *cancleOrder;
- (IBAction)cancleOrderAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *backView;


@end
