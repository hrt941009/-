//
//  MyLikeCell.m
//  Love
//
//  Created by lee wei on 14-10-6.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyLikeCell.h"

@implementation MyLikeCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(80, 3, kScreenWidth - 90, 40);
    _descLabel.frame = CGRectMake(80, 44, kScreenWidth - 90, 35);
}

@end
