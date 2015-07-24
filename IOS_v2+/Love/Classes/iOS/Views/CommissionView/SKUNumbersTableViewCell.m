//
//  SKUNumbersTableViewCell.m
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SKUNumbersTableViewCell.h"

@implementation SKUNumbersTableViewCell

- (void)awakeFromNib {
    
    _productNumbers = 1;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _numberslabel = [[UILabel alloc] initWithFrame:CGRectMake(3.f, 0, 60.f, self.contentView.frame.size.height)];
    _numberslabel.text = MyLocalizedString(@"购买数量");
    _numberslabel.textColor = [UIColor colorRGBWithRed:232.f green:107.f blue:136.f alpha:1.f];
    _numberslabel.adjustsFontSizeToFitWidth = YES;
    _numberslabel.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_numberslabel];
//
    CGFloat detailWidth = 60.f;
    CGFloat detailHeight = 22.f;
    CGFloat priceWidth = 70.f;
    _detailLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numberslabel.frame) + 10.f, 0, detailWidth, detailHeight)];
    _detailLabel1.backgroundColor = [UIColor clearColor];
    _detailLabel1.textColor = [UIColor lightGrayColor];
    _detailLabel1.font = [UIFont systemFontOfSize:10.f];
    _detailLabel1.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_detailLabel1];
    
    _detailLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(_detailLabel1.frame.origin.x, CGRectGetMaxY(_detailLabel1.frame), detailWidth, detailHeight)];
    _detailLabel2.backgroundColor = [UIColor clearColor];
    _detailLabel2.textColor = [UIColor lightGrayColor];
    _detailLabel2.font = [UIFont systemFontOfSize:10.f];
    _detailLabel2.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_detailLabel2];
    
    _detailLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(_detailLabel1.frame.origin.x, CGRectGetMaxY(_detailLabel2.frame), detailWidth, detailHeight)];
    _detailLabel3.backgroundColor = [UIColor clearColor];
    _detailLabel3.textColor = [UIColor lightGrayColor];
    _detailLabel3.font = [UIFont systemFontOfSize:10.f];
    _detailLabel3.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_detailLabel3];
    
    _priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_detailLabel1.frame), 0, priceWidth, detailHeight)];
    _priceLabel1.backgroundColor = [UIColor clearColor];
    _priceLabel1.textColor = [UIColor colorRGBWithRed:232.f green:107.f blue:136.f alpha:1.f];
    _priceLabel1.font = [UIFont systemFontOfSize:12.f];
    _priceLabel1.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_priceLabel1];
    
    _priceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(_priceLabel1.frame.origin.x, CGRectGetMaxY(_priceLabel1.frame), priceWidth, detailHeight)];
    _priceLabel2.backgroundColor = [UIColor clearColor];
    _priceLabel2.textColor = [UIColor colorRGBWithRed:232.f green:107.f blue:136.f alpha:1.f];
    _priceLabel2.font = [UIFont systemFontOfSize:12.f];
    _priceLabel2.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_priceLabel2];
    
    _priceLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(_priceLabel1.frame.origin.x, CGRectGetMaxY(_priceLabel2.frame), priceWidth, detailHeight)];
    _priceLabel3.backgroundColor = [UIColor clearColor];
    _priceLabel3.textColor = [UIColor colorRGBWithRed:232.f green:107.f blue:136.f alpha:1.f];
    _priceLabel3.font = [UIFont systemFontOfSize:12.f];
    _priceLabel3.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_priceLabel3];
//
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _minusButton.frame = CGRectMake(216.f, 12.f, 28.f, 20.f);
    _minusButton.backgroundColor = [UIColor clearColor];
    [_minusButton setImage:[UIImage imageNamed:@"sku_minus"] forState:UIControlStateNormal];
    [_minusButton addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_minusButton];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minusButton.frame), 12.f, 40.f, 20.f)];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.enabled = NO;
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.text = [NSString stringWithFormat:@"%d", _productNumbers];
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_textField];
    
    _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _plusButton.frame = CGRectMake(CGRectGetMaxX(_textField.frame), 12.f, 28.f, 20.f);
    _plusButton.backgroundColor = [UIColor clearColor];
    _plusButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10.f);
    [_plusButton setImage:[UIImage imageNamed:@"sku_plus"] forState:UIControlStateNormal];
    [_plusButton addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_plusButton];
    
    
    UIView *footerLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 2.f, self.contentView.frame.size.width, 1.f)];
    footerLine.backgroundColor = [UIColor colorRGBWithRed:237.f green:237.f blue:237.f alpha:1.f];
    [self.contentView addSubview:footerLine];

}

- (CGFloat)cellHeight
{
    CGFloat height = 0;
    CGFloat labelArrayHeight = [_detailArray count] * 22.f;
    if (labelArrayHeight > 44.f) {
        height = labelArrayHeight + 10.f;
    }else {
        height = 44.f;
    }
    
    return height;
}

- (void)minusAction:(id)sender
{
    if (_productNumbers <= 1) {
        return;
    }
    _productNumbers = _productNumbers - 1;
    _textField.text = [NSString stringWithFormat:@"%d", _productNumbers];
    [_delegate skuNumbers:_productNumbers];
}


- (void)plusAction:(id)sender
{
    if (_productNumbers >= 999) {
        return;
    }
    _productNumbers = _productNumbers + 1;
    _textField.text = [NSString stringWithFormat:@"%d", _productNumbers];
    [_delegate skuNumbers:_productNumbers];
}

@end
