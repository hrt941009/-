//
//  MyHistoryOrderCell.m
//  Love
//
//  Created by lee wei on 14-10-5.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyHistoryOrderCell.h"

@implementation MyHistoryOrderCell

- (void)awakeFromNib
{
    _titleLabel.font = [UIFont boldSystemFontOfSize:13.f];
    _titleLabel.numberOfLines = 4;
    _descLabel.numberOfLines = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



/**
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleOriginX = self.titleLabel.frame.origin.x;
    CGFloat titleOriginY = self.titleLabel.frame.origin.y;
    CGFloat titleWidth = self.titleLabel.frame.size.width;
    CGFloat titleHeight = 0;
    
    CGSize titleSize = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(titleWidth, 600.f) lineBreakMode:NSLineBreakByWordWrapping];
    if (titleSize.height < 40.f) {
        titleHeight = 40.f;
    }else{
        titleHeight = titleSize.height;
    }
    self.titleLabel.frame = CGRectMake(titleOriginX, titleOriginY, titleWidth, titleHeight);
    
    CGFloat descOriginX = self.descLabel.frame.origin.x;
    CGFloat descWidth = self.descLabel.frame.size.width;
    CGFloat descHeight = 0;
    
    CGSize descSize = [self.descLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(descWidth, 600.f) lineBreakMode:NSLineBreakByWordWrapping];
    if (descSize.height < 40.f) {
        descHeight = 40.f;
    }else{
        descHeight = descSize.height;
    }
    self.descLabel.frame = CGRectMake(descOriginX, CGRectGetMaxY(self.titleLabel.frame), descWidth, descHeight);

    CGRect rect = self.frame;
    rect.size.height = self.titleLabel.frame.size.height + self.descLabel.frame.size.height + 5.f;
    self.frame = rect;
}
*/

@end
