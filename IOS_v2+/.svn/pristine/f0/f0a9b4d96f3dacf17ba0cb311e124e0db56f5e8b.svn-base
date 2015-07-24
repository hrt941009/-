//
//  CCBottomView.m
//  Love
//
//  Created by lee wei on 14-9-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CCBottomView.h"

@implementation CCBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bottomPriceStr = @"0";
        _bottomDiscount = @"0";
    }
    return self;
}

- (void)setBottomViewForWirte:(BOOL)isWirte
{
    if (isWirte) {
        for (id button in [self subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [(UIButton *)button removeFromSuperview];
            }
        }
        for (id label in [self subviews]) {
            if ([label isKindOfClass:[UILabel class]]) {
                [(UILabel *)label removeFromSuperview];
            }
        }
        _wirteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _wirteButton.frame = CGRectMake(kScreenWidth - 90, 5, 80, 35);
        _wirteButton.backgroundColor = [UIColor whiteColor];
        [_wirteButton setTitle:@"评论" forState:UIControlStateNormal];
        [_wirteButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        _wirteButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _wirteButton.backgroundColor = [UIColor clearColor];
//        _wirteButton.layer.masksToBounds = YES;
//        _wirteButton.layer.cornerRadius = 3.f;
//        _wirteButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        _wirteButton.layer.borderWidth = 1.f;
        [_wirteButton addTarget:self action:@selector(writeAction) forControlEvents:UIControlEventTouchUpInside];
 
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 5, kScreenWidth - 100, 35)];
        textField.backgroundColor = [UIColor whiteColor];
        //        textField.borderStyle = UITextBorderStyleLine;
        textField.placeholder = @" 您想说点什么";
        textField.font = [UIFont systemFontOfSize:15.f];
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 3.f;
        textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        textField.layer.borderWidth = 1.f;
        
        UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, 35)];
        [textButton addTarget:self action:@selector(writeAction) forControlEvents:UIControlEventTouchUpInside];
        textButton.enabled = YES;
        
        [textField addSubview:textButton];
        [self addSubview:_wirteButton];
        [self addSubview:textField];
        
    }
    if (!isWirte) {
        for (id button in [self subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [(UIButton *)button removeFromSuperview];
            }
        }
        
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(3.f, 0, 80., self.frame.size.height)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = [UIColor colorRGBWithRed:248.f green:4.f blue:74.f alpha:1.f];
        _priceLabel.font = [UIFont systemFontOfSize:20.f];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        _priceLabel.text = [NSString stringWithFormat:@"%@", _bottomPriceStr];
        [self addSubview:_priceLabel];
        
        _discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame) + 1.f, 10.f, 36.f, self.frame.size.height/4)];
        _discountLabel.backgroundColor = [UIColor colorRGBWithRed:239.f green:34.f blue:86.f alpha:1.f];
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.font = [UIFont systemFontOfSize:10.f];
        _discountLabel.adjustsFontSizeToFitWidth = YES;
        _discountLabel.layer.cornerRadius = 8.f;
        _discountLabel.text = [NSString stringWithFormat:@"%@折", _bottomDiscount];
        _discountLabel.layer.masksToBounds = YES;
        _discountLabel.layer.cornerRadius = 3.f;
        [self addSubview:_discountLabel];
        
        _originalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame) + 1.f, self.frame.size.height/2, 50., self.frame.size.height/2)];
        _originalPriceLabel.backgroundColor = [UIColor clearColor];
        _originalPriceLabel.textAlignment = NSTextAlignmentCenter;
        _originalPriceLabel.textColor = [UIColor colorWithWhite:0 alpha:0.6];
        _originalPriceLabel.font = [UIFont systemFontOfSize:12.f];
        _originalPriceLabel.adjustsFontSizeToFitWidth = YES;
        _originalPriceLabel.text = [NSString stringWithFormat:@"%@元", _bottomOriginalPriceStr];
        [self addSubview:_originalPriceLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(3.f, 11.f, _originalPriceLabel.frame.size.width - 3.f, 1.f)];
        lineView.backgroundColor = [UIColor blackColor];
        [_originalPriceLabel addSubview:lineView];
        
        _putCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _putCartButton.frame = CGRectMake(CGRectGetMaxX(_originalPriceLabel.frame) + 12.f, 7.f, 70.f, 30.f);
        _putCartButton.frame = CGRectMake(kScreenWidth - 160.f, 7.f, 70.f, 30.f);
//        _putCartButton.backgroundColor = [UIColor colorRGBWithRed:233.f green:60.f blue:103.f alpha:0.8f];
//        [_putCartButton setBackgroundImage:[UIImage imageNamed:@"cc_put_cart"] forState:UIControlStateNormal];
        [_putCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_putCartButton setTitleColor:[UIColor colorRGBWithRed:233 green:60 blue:103 alpha:0.8] forState:UIControlStateNormal];
        _putCartButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _putCartButton.layer.masksToBounds = YES;
        _putCartButton.layer.cornerRadius = 3.f;
        _putCartButton.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.3] CGColor];
        _putCartButton.layer.borderWidth = 1.f;
        [_putCartButton addTarget:self action:@selector(putCartAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_putCartButton];
        
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _buyButton.frame = CGRectMake(CGRectGetMaxX(_putCartButton.frame) + 12.f, 7.f, 70.f, 30.f);
        _buyButton.frame = CGRectMake(kScreenWidth - 80.f, 7.f, 70.f, 30.f);
        _buyButton.backgroundColor = [UIColor colorRGBWithRed:233.f green:60.f blue:103.f alpha:0.8f];
//        [_buyButton setBackgroundImage:[UIImage imageNamed:@"cc_buy"] forState:UIControlStateNormal];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _buyButton.layer.masksToBounds = YES;
        _buyButton.layer.cornerRadius = 3.f;
        [_buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buyButton];
    }
}

- (void)writeAction
{
    [_delgate writeMyComment];
}

- (void)putCartAction
{
    [_delgate putCart];
}

- (void)buyAction
{
    [_delgate buyNow];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
