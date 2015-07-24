//
//  SubmitButtonTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SubmitButtonTableViewCell.h"
#import "BuyBackgroundView.h"
#import "UIButton+Block.h"

@implementation SubmitButtonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        BuyBackgroundView *bgView = [[BuyBackgroundView alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 48.f)];
        bgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:bgView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height);
        [button setTitle:@"下单" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            
        }];
        [bgView addSubview:button];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
