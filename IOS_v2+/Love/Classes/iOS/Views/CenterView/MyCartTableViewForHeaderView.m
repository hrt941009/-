//
//  MyCartTableViewForHeaderView.m
//  Love
//
//  Created by lee wei on 15/1/11.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "MyCartTableViewForHeaderView.h"

@implementation MyCartTableViewForHeaderView

- (void)commitInitInSection:(NSInteger)section;
{
    self.backgroundColor = [UIColor whiteColor];
    
    for (id object in [self subviews]) {
        [object removeFromSuperview];
    }
    UIView *footerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.7)];
    footerLineView.backgroundColor = [UIColor colorRGBWithRed:201.f green:201.f blue:201.f alpha:0.8];
    [self addSubview:footerLineView];
    
    self.allSectionSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allSectionSelectButton.frame = CGRectMake(5.f, 0, 40.f, self.frame.size.height);
    self.allSectionSelectButton.backgroundColor = [UIColor clearColor];
    self.allSectionSelectButton.tag = section;
    self.allSectionSelectButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20.f);
    [self.allSectionSelectButton addTarget:self action:@selector(sectionAllSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.allSectionSelectButton];
    
    self.shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.allSectionSelectButton.frame), 0, 200.f, self.frame.size.height)];
    self.shopNameLabel.backgroundColor = [UIColor clearColor];
    self.shopNameLabel.textColor = [UIColor darkGrayColor];
    self.shopNameLabel.textAlignment = NSTextAlignmentLeft;
    self.shopNameLabel.font = [UIFont systemFontOfSize:14.f];
    self.shopNameLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.shopNameLabel];
}

- (void)headerViewButtonSelected:(BOOL)select
{
    if (select) {
        [self.allSectionSelectButton setImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateNormal];
    }
    if (!select) {
        [self.allSectionSelectButton setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
    }
}

- (void)sectionAllSelectAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        [self.allSectionSelectButton setImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateNormal];
        [_delegate selectSectionHeader:YES inSection:button.tag];
    }else{
        [self.allSectionSelectButton setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
        [_delegate selectSectionHeader:NO inSection:button.tag];
    }
}

@end
