//
//  AfterSaleCell.m
//  Love
//
//  Created by use on 14-11-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "AfterSaleCell.h"
#import "ComplainViewController.h"

@implementation AfterSaleCell

- (void)awakeFromNib
{
    // Initialization code
    
    _orderNumber.font = [UIFont systemFontOfSize:13.f];
    
    _iconImage.layer.borderColor = [[UIColor GitHub] CGColor];
    _iconImage.layer.borderWidth = 1.f;
    
    _choiceButton.layer.borderColor = [[UIColor GitHub] CGColor];
    _choiceButton.layer.borderWidth = 1.f;
    _choiceButton.layer.masksToBounds = YES;
    _choiceButton.layer.cornerRadius = 2.f;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _choiceButton.frame = CGRectMake(kScreenWidth - 80, 10, 60, 18);
    _orderNumber.frame = CGRectMake(80, 9, kScreenWidth - 165, 21);
    _line.frame = CGRectMake(10, 35, kScreenWidth - 20, 1);
    _introduce.frame = CGRectMake(96, 41, kScreenWidth - 106, 32);
    _money.frame = CGRectMake(kScreenWidth - 94, 69, 84, 31);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)choiceCommodityClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(pushComplainPage:)]) {
        [_delegate pushComplainPage:sender];
    }
}
@end
