//
//  RedPacketTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "RedPacketTableViewCell.h"
#import "BuyBackgroundView.h"
#import "UIButton+Block.h"

@implementation RedPacketTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        BuyBackgroundView *bgView = [[BuyBackgroundView alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 50.f)];
        [self.contentView addSubview:bgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 0, 160.f, 50.f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        [bgView addSubview:_titleLabel];
  
        
        _redPacketTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - 60.f , 14.f, 50.f, 22.f)];
        _redPacketTextField.backgroundColor = [UIColor clearColor];
        _redPacketTextField.textColor = [UIColor blackColor];
        _redPacketTextField.borderStyle = UITextBorderStyleLine;
        _redPacketTextField.font = [UIFont systemFontOfSize:14.f];
        _redPacketTextField.delegate = self;
        _redPacketTextField.keyboardType = UIKeyboardTypeNumberPad;
        [bgView addSubview:_redPacketTextField];
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

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_delegate redPacketCellKeyboardDidShow];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_redPacketTextField resignFirstResponder];
}

@end
