//
//  SKUNumbersTableViewCell.h
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKUNumbersTableCellDelegate <NSObject>

- (void)skuNumbers:(int)numbers;

@end

@interface SKUNumbersTableViewCell : UITableViewCell

@property (nonatomic, assign)  int productNumbers;
@property (nonatomic, strong)  UILabel *numberslabel;
@property (nonatomic, strong)  UILabel *detailLabel1;
@property (nonatomic, strong)  UILabel *detailLabel2;
@property (nonatomic, strong)  UILabel *detailLabel3;

@property (nonatomic, strong)  UILabel *priceLabel1;
@property (nonatomic, strong)  UILabel *priceLabel2;
@property (nonatomic, strong)  UILabel *priceLabel3;
@property (nonatomic, strong)  UIButton *minusButton;
@property (nonatomic, strong)  UIButton *plusButton;
@property (nonatomic, strong)  UITextField *textField;

@property (nonatomic, strong) NSArray *detailArray;
@property (nonatomic, strong) NSArray *priceArray;

@property (nonatomic, weak) id<SKUNumbersTableCellDelegate> delegate;


- (CGFloat)cellHeight;

@end
