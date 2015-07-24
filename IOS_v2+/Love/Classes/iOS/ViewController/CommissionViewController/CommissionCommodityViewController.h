//
//  CommissionCommodityViewController.h
//  Love
//
//  Created by lee wei on 14-8-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  商品信息
//

#import <UIKit/UIKit.h>

@interface CommissionCommodityViewController : LOVBaseViewController


@property (nonatomic, strong) NSArray   *imageArray;
@property (nonatomic, strong) NSString  *cid;  //商品id
@property (nonatomic, strong) NSString  *brandId;  //品牌id
@property (nonatomic, strong) NSString  *brandName;  //品牌id
@property (nonatomic, strong) NSString  *intro; //商品简介
@property (nonatomic, strong) NSString  *itemStr;
@property (nonatomic, strong) NSString  *titleStr;
@property (nonatomic, strong) NSString  *saleStr;
@property (nonatomic, strong) NSString  *nextPriceStr;
@property (nonatomic, strong) NSString  *isNextPriceStr;//0为不存在下次购买价(不显示下次购买价)，1为存在(显示下次购买价)
@property (nonatomic, strong) NSString  *isCouponStr;//是否有优惠券 0为无 1为有
@property (nonatomic, strong) NSString  *likeStr;
@property (nonatomic, strong) NSString  *subjectStr;
@property (nonatomic, strong) NSString  *commentStr;
@property (nonatomic, strong) NSString  *originalPriceStr;//原价价格（市场价）
@property (nonatomic, strong) NSString  *priceStr;//现价
@property (nonatomic, strong) NSString  *discountStr;//折扣值
@property (nonatomic, strong) NSString  *isDiscountStr;   //是否打折 0为不打折 1为打折 当为0时取discount为打折的值
@property (nonatomic, strong) NSString *stock;

- (void)getCommissionPhoto:(NSArray *)imageArray;

@end
