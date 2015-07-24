//
//  DresserDetailProductCell.m
//  Love
//
//  Created by lee wei on 14/11/18.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserDetailProductCell.h"

@implementation DresserDetailProductCell

- (void)awakeFromNib {
    _priceLabel.textColor = [UIColor colorRGBWithRed:170.f green:28.f blue:67.f alpha:1.f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
