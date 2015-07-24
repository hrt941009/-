//
//  DresserHomePageCell.m
//  Love
//
//  Created by 李伟 on 14/11/15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserHomePageCell.h"

@implementation DresserHomePageCell

- (void)awakeFromNib {
    // Initialization code
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _introLabel.numberOfLines = 2;
    _addressLabel.adjustsFontSizeToFitWidth = YES;
    _dateTimeLabel.adjustsFontSizeToFitWidth = YES;
    
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 3.f;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(133, 8, kScreenWidth - 141, 26);
    _introLabel.frame = CGRectMake(133, 36, kScreenWidth - 141, 38);
    _addressLabel.frame = CGRectMake(155, 91, kScreenWidth - 163, 24);
    _dateTimeLabel.frame = CGRectMake(133, 74, kScreenWidth - 141, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
