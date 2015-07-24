//
//  MyCartFooterView.m
//  Love
//
//  Created by lee wei on 15/1/19.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "MyCartFooterView.h"

@implementation MyCartFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorRGBWithRed:248.f green:248.f blue:248.f alpha:0.9];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1.f)];
        lineView.backgroundColor = [UIColor colorRGBWithRed:231.f green:231.f blue:231.f alpha:1.f];
        [self addSubview:lineView];
        
        _allSelectButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _allSelectButton.frame = CGRectMake(5.f, 2.f, 70.f, 44.f);
        _allSelectButton.backgroundColor = [UIColor clearColor];
        [_allSelectButton setTitle:MyLocalizedString(@"全选") forState:UIControlStateNormal];
        [_allSelectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _allSelectButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_allSelectButton setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];

        _allSelectButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50.f);
        _allSelectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:_allSelectButton];
    }
    return self;
}

- (void)setDeleteButton
{
    if ([_buyView isKindOfClass:[UIView class]]) {
        [_buyView removeFromSuperview];
    }
    _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _delButton.frame = CGRectMake(CGRectGetMaxX(_allSelectButton.frame) + 160.f, 2.f, 70.f, 34.f);
    _delButton.backgroundColor = [UIColor colorRGBWithRed:224.f green:35.f blue:84.f alpha:1.f];
    [_delButton setTitle:MyLocalizedString(@"Delete") forState:UIControlStateNormal];
    [_delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _delButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_delButton addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _delButton.layer.borderColor = [[UIColor colorRGBWithRed:181.f green:90.f blue:107.f alpha:1.f] CGColor];
    _delButton.layer.borderWidth = 1.f;
    _delButton.layer.cornerRadius = 4.f;
    [self addSubview:_delButton];
}

- (void)setBuyPriceView
{
    if ([_delButton isKindOfClass:[UIButton class]]) {
        [_delButton removeFromSuperview];
    }
    _buyView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 200.f, 0, 190.f, self.frame.size.height)];
    _buyView.backgroundColor = [UIColor clearColor];
    [self addSubview:_buyView];
    
    _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110.f, self.frame.size.height)];
    _totalPriceLabel.backgroundColor = [UIColor clearColor];
    _totalPriceLabel.textColor = [UIColor colorRGBWithRed:213.f green:1.f blue:67.f alpha:1.f];
    _totalPriceLabel.font = [UIFont systemFontOfSize:16.f];
    _totalPriceLabel.adjustsFontSizeToFitWidth = YES;
    _totalPriceLabel.textAlignment = NSTextAlignmentCenter;
    [_buyView addSubview:_totalPriceLabel];
    
    _settleUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settleUpButton.frame = CGRectMake(CGRectGetMaxX(_totalPriceLabel.frame) + 5.f, 3.f, 70.f, 34.f);
    _settleUpButton.backgroundColor = [UIColor colorRGBWithRed:203.f green:53.f blue:87.f alpha:1.f];
    [_settleUpButton setTitle:MyLocalizedString(@"结算") forState:UIControlStateNormal];
    [_settleUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _settleUpButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_settleUpButton addTarget:self action:@selector(settleUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _settleUpButton.layer.borderColor = [[UIColor colorRGBWithRed:235.f green:37.f blue:88.f alpha:1.f] CGColor];
    _settleUpButton.layer.borderWidth = 1.f;
    _settleUpButton.layer.cornerRadius = 3.f;
    [_buyView addSubview:_settleUpButton];
}


- (void)delButtonAction:(id)sender
{
    [_delegate deleteProductAction];
}

- (void)settleUpButtonAction:(id)sender
{
    [_delegate settleUpProductAction];
}

@end
