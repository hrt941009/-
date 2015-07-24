//
//  SKUImageViewTableViewCell.m
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SKUImageViewTableViewCell.h"

@implementation SKUImageViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.contentView.backgroundColor = [UIColor colorRGBWithRed:234.f green:234.f blue:234.f alpha:1.f];
    _priceLabel.textColor = [UIColor colorRGBWithRed:227.f green:88.f blue:120.f alpha:1.f];
}


- (void)getStockLabelTextWithNumbers:(NSString *)numbers
{
    NSString *stockStr1 = @"库存";
    NSString *stockStr2 = @"件";
    
    NSUInteger len1 = [stockStr1 length];
    NSUInteger stockLen = [numbers length];
    
    _stockLabel.textColor = [UIColor darkGrayColor];
    _stockLabel.text = [NSString stringWithFormat:@"%@%@%@", stockStr1, numbers, stockStr2];
    
    if (_stockLabel.text) {
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:_stockLabel.text];
        
        [attributeStr setAttributes:@{NSForegroundColorAttributeName: [UIColor colorRGBWithRed:220.f green:38.f blue:84.f alpha:1.f]}
                              range:NSMakeRange(len1, stockLen)];
        
        
        _stockLabel.attributedText = attributeStr;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
