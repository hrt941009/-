//
//  ShareProductTableViewCell.m
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareProductTableViewCell.h"

@implementation ShareProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _productName.frame = CGRectMake(148, 38, kScreenWidth - 158, 20);
    _introLabel.frame = CGRectMake(148, 54, kScreenWidth - 158, 41);
    _introLabel.numberOfLines = 0;
    _priceLabel.textColor = [UIColor colorRGBWithRed:233 green:60 blue:103 alpha:1];
    _addCartButton.frame = CGRectMake(kScreenWidth - 58, 90, 48, 30);
    _lineView.frame = CGRectMake(148, 119, kScreenWidth - 158, 1);
    _priceLabel.adjustsFontSizeToFitWidth = YES;
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = 3.f;
    
    _lineView.backgroundColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.1];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addCartAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [_delegate shareProductAddCartButton:button];
}
@end
