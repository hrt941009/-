//
//  CommodityDetailTableViewCell.h
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuyBackgroundView;
@interface CommodityDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) BuyBackgroundView *bgView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UILabel *detailLabel;

- (CGFloat)setCellHeight;

@end
