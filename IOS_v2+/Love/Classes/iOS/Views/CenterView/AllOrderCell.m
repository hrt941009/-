//
//  AllOrderCell.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "AllOrderCell.h"

@implementation AllOrderCell

- (void)awakeFromNib
{
    
//    _bgView.layer.borderColor = [[UIColor GitHub] CGColor];
//    _bgView.layer.borderWidth = 1.f;
    
//    _orderStatusButton.layer.borderColor = [[UIColor Twitter] CGColor];
//    _orderStatusButton.layer.borderWidth = 1.f;
    _orderStatusButton.layer.masksToBounds = YES;
    _orderStatusButton.layer.cornerRadius = 3.f;
//    _orderStatusButton.titleLabel.textColor = [UIColor whiteColor];
    _orderStatusButton.backgroundColor = [UIColor colorRGBWithRed:230 green:63 blue:105 alpha:1];
//    [self.bgView bringSubviewToFront:_orderStatusButton];
    _receivedButton.layer.masksToBounds = YES;
    _receivedButton.layer.cornerRadius = 3.f;
    _receivedButton.backgroundColor = [UIColor colorRGBWithRed:230 green:63 blue:105 alpha:1];
//    [self.bgView bringSubviewToFront:_receivedButton];
    
    
    
    
}

- (void)layoutSubviews{
    _centerLine.frame = CGRectMake(0, 84, kScreenWidth - 5, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)orderStatusButtonAction:(id)sender
{
    if ([_delegate respondsToSelector:@selector(orderButtonClick:)]) {
        [_delegate orderButtonClick:sender];
    }
}
- (IBAction)receivedButtonAction:(id)sender
{
    if ([_delegate respondsToSelector:@selector(reciveButtonClick:)]) {
        [_delegate reciveButtonClick:sender];
    }
}

@end
