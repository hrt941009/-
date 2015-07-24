//
//  CommissionCollectionCell.h
//  Love
//
//  Created by lee wei on 14-10-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kCommissionCellBgViewMargin;
extern CGFloat const kCommissionCellBgViewWidth;

@interface CommissionCollectionCell : UICollectionViewCell


@property (nonatomic, strong) IBOutlet UIImageView *picImageView; // 商品图片
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
