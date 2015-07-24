//
//  ReciveAddressCell.m
//  Love
//
//  Created by use on 14-12-3.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ReciveAddressCell.h"

@implementation ReciveAddressCell

- (void)awakeFromNib {
    // Initialization code
    _address.numberOfLines = 0;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _phoneNum.frame = CGRectMake(kScreenWidth - 165, 10, 145, 21);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
