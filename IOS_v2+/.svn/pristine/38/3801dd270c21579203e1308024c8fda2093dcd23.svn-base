//
//  SKUValueTableViewCell.m
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SKUValueTableViewCell.h"

@implementation SKUValueTableViewCell

- (void)awakeFromNib {
    _nameLabel.textColor = [UIColor colorRGBWithRed:233.f green:60.f blue:103.f alpha:0.8];
    
    tempWidth = 0;


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIButton *button = nil;
    for (NSInteger i = 0; i < [_valueArray count]; i++) {
        NSString *text = _valueArray[i];
        //CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:12.f] constrainedToSize:CGSizeMake(200.f, 20.f) lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat btnWidth = 30.f;//size.width + 30.f;
        tempWidth = tempWidth + btnWidth;
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + btnWidth * i + 10 * i, 0, btnWidth, 20.f);
        button.backgroundColor = [UIColor clearColor];
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [button setTitle:text forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    
    if (tempWidth > 300.f) {
        _scrollView.scrollEnabled = YES;
        _scrollView.contentSize = CGSizeMake(tempWidth, 20.f);
    }else{
        _scrollView.scrollEnabled = NO;
        _scrollView.contentSize = CGSizeMake(300.f, 20.f);
    }
}

- (void)buttonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    for (id btn in [_scrollView subviews]) {
        if ([btn isMemberOfClass:[UIButton class]]) {
            UIButton *_btn = (UIButton *)btn;
            _btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            //button.selected = NO;
        }
    }
    button.layer.borderColor = [[UIColor Readability] CGColor];
    [_delegate skuValueButton:button];
}

@end
