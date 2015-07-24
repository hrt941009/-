//
//  CommissionCell.h
//  Love
//
//  Created by 李伟 on 14-8-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  返利
//

#import "TMQuiltViewCell.h"

//extern CGFloat const kCommissionCellBgViewMargin;
//extern CGFloat const kCommissionCellBgViewWidth;

@interface CommissionCell : TMQuiltViewCell


@property (nonatomic, strong) UIImageView *picImageView; // 商品图片
@property (nonatomic, strong) UILabel *sellerLabel, *descLabel;//卖家、商品描述
@property (nonatomic, strong) UILabel *oldPriceLabel, *newPriceLabel, *discountDataLabel;//原价、新价格、打几折
@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UIView *discountView;//背景 返利多少、优惠
@property (nonatomic, strong) UILabel *commissonLabel, *discountLabel;//返利多少、优惠
@property (nonatomic, strong) UILabel *likeLabel, *subjectLabel, *commentLabel;//喜欢数量、专题数量、评论数量
@property (nonatomic, strong) UIImageView *likeImageView, *subjectImageView, *commentImageView;//图标 喜欢数量、专题数量、评论数量

@end
