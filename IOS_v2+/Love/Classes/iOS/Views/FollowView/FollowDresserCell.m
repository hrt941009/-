//
//  FollowDresserCell.m
//  Love
//
//  Created by 李伟 on 14-10-16.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowDresserCell.h"

@implementation FollowDresserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelFollowAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_delegate cancelFollowButton:button];
}

@end
