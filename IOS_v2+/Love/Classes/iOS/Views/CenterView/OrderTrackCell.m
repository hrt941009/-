//
//  OrderTrackCell.m
//  Love
//
//  Created by use on 14-11-21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "OrderTrackCell.h"

@implementation OrderTrackCell

- (void)awakeFromNib {
    // Initialization code
    self.locationCompany.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
