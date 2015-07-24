//
//  FollowSubjectTableViewCell.m
//  Love
//
//  Created by lee wei on 14-9-22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowSubjectTableViewCell.h"

@implementation FollowSubjectTableViewCell

- (void)awakeFromNib
{
    _descTextView.editable = NO;
    _descTextView.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(94, 1, kScreenWidth - 104, 32);
    _descTextView.frame = CGRectMake(94, 32, kScreenWidth - 104, 62);
    _likeButton.frame = CGRectMake(94, 96, 70, 14);
    _commentButton.frame = CGRectMake(kScreenWidth - 164, 96, 70, 14);
}

- (IBAction)cancelFollowAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_delegate cancelFollowButton:button];
}

@end
