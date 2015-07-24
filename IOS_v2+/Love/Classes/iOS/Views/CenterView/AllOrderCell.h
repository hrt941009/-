//
//  AllOrderCell.h
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllOrderViewController.h"
@protocol OrderCellButtonClickDelegate <NSObject>
@required
- (void)orderButtonClick:(UIButton*)button;
- (void)reciveButtonClick:(UIButton*)button;
@end
@interface AllOrderCell : UITableViewCell

@property (nonatomic, assign) id<OrderCellButtonClickDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *centerLine;

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UILabel *orderNumberLabel, *orderPriceLabel, *orderDateLabel;
@property (nonatomic, strong) IBOutlet UIButton *orderStatusButton;
@property (nonatomic, strong) IBOutlet UIButton *receivedButton;

- (IBAction)orderStatusButtonAction:(id)sender;
- (IBAction)receivedButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *orderDate;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;



@end
