//
//  BrandTableViewCell.m
//  Love
//
//  Created by lee wei on 14-9-22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BrandTableViewCell.h"

@implementation BrandTableViewCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorRGBWithRed:235 green:235 blue:235 alpha:1];
    _descTextView.editable = NO;
    _descTextView.userInteractionEnabled = NO;
    _levelImageView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(115, 3, kScreenWidth - 123, 32);
    _descTextView.frame = CGRectMake(115, 34, kScreenWidth - 123, 62);
    _likeButton.frame = CGRectMake(90, 90, 70, 14);
    _publishButton.frame = CGRectMake(kScreenWidth - 154, 97, 70, 14);
    
    _backView.frame = CGRectMake(0, 5, kScreenWidth, 115);
    _backView.layer.borderColor = [[UIColor colorRGBWithRed:237 green:237 blue:237 alpha:1] CGColor];
    _backView.layer.borderWidth = 1.f;
    _addressLabel.frame = CGRectMake(115, 39, kScreenWidth - 123, 40);
}

- (IBAction)cancelFollowBrandAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_delegate cancelFollowButton:button];
}

@end
