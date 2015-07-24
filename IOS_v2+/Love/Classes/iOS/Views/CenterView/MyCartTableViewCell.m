//
//  MyCartTableViewCell.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyCartTableViewCell.h"

@implementation MyCartTableViewCell

- (void)awakeFromNib
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10.f, 0, self.contentView.frame.size.width - 10.f, 0.6)];
    lineView.backgroundColor = [UIColor colorRGBWithRed:201.f green:201.f blue:201.f alpha:0.8];
    [self.contentView addSubview:lineView];
    
    _buyNumberTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _buyNumberTextField.layer.borderWidth = 0.5;
    _buyNumberTextField.enabled = NO;
    
    _selectButton.tag =MyCartButtonTagWithCell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellEdit:(BOOL)edit
{
   
    if (edit) {
        _numbersView.alpha = 1.f;
        _titleLabel.alpha = 0;
    }
    if (!edit) {
        _titleLabel.alpha = 1.f;
        _numbersView.alpha = 0;
    }
}

- (void)cellButtonSelect:(BOOL)select
{
    if (select) {
        //NSLog(@"cart_select");
        [self.selectButton setImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateNormal];
    }
    if (!select) {
        //NSLog(@"cart_unselect");
        [self.selectButton setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
    }
}

- (IBAction)minusButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    int num = [_buyNumberTextField.text intValue];
    num = num - 1;
    if (num > 1) {
        _buyNumberTextField.text = [NSString stringWithFormat:@"%d", num];
        [_delegate buyNumber:num button:button];
    }else{
        _buyNumberTextField.text = @"1";
        [_delegate buyNumber:1 button:button];
    }
}

- (IBAction)addButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    int num = [_buyNumberTextField.text intValue];
    num = num + 1;
    _buyNumberTextField.text = [NSString stringWithFormat:@"%d", num];
    [_delegate buyNumber:num button:button];
}

- (IBAction)selectButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        [_delegate selectButton:button select:YES];
    }
    if (!button.selected) {
        [_delegate selectButton:button select:NO];
    }
}

@end
