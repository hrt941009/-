//
//  DresserProductViewController.h
//  Love
//
//  Created by lee wei on 14/11/19.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//美妆师直播商品详情

#import <UIKit/UIKit.h>

@interface DresserProductViewController : LOVBaseViewController

@property (nonatomic, strong) NSString  *cid;  //商品id
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
@property (nonatomic, strong) NSString *stockStr; //库存
@property (nonatomic, strong) NSString *isAttention;//是否喜欢
@property (nonatomic, strong) NSString *dresserId;//美妆师ID
@property (nonatomic, strong) NSString *productIntro;

@property (nonatomic, strong) NSArray  *imageArray;

- (void)getProductPhoto:(NSArray *)imageArray;

@end
