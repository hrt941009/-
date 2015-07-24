//
//  PriceAndNumbersTableViewCell.h
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PriceAndNumbersCellDelegate <NSObject>

- (void)priceAndNumbersKeyboardDidShow;

@end

@interface PriceAndNumbersTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *numberDetailLabel;
@property (nonatomic, strong) UITextField *numberTextField;

@property (nonatomic, weak) id<PriceAndNumbersCellDelegate> delegate;

@property (nonatomic, assign) BOOL isDetail;

@end
