//
//  CommissionModel.h
//  Love
//
//  Created by lee wei on 14-9-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  返利首页
//

#import <Foundation/Foundation.h>

extern NSString * const kRebateKey;
extern NSString * const kCouponKey;
extern NSString * const kDiscussKey;
extern NSString * const kLoveKey;
extern NSString * const kHotKey;

extern NSString * const kCommissionKeyNotificationName;
extern NSString * const kSearchNoticefationName;
extern NSString * const kTagProductNotificationName;
extern NSString * const kProductListDataNotificationName;


@interface CommissionModel : NSObject

@property (nonatomic, strong) NSString *cid;           //商品ID
@property (nonatomic, strong) NSString *cDetail;       //商品描述
@property (nonatomic, strong) NSString *thumb;         //瀑布流图片地址
@property (nonatomic, strong) NSString *originalPrice; //原价价格（市场价）
@property (nonatomic, strong) NSString *price;         //现价
@property (nonatomic, strong) NSString *save;          //加入专辑数量
@property (nonatomic, strong) NSString *discuss;       //评论数量
@property (nonatomic, strong) NSString *love;          //喜欢数量
@property (nonatomic, strong) NSString *isRebate;      //是否有返利 0为无 1为有
@property (nonatomic, strong) NSString *rebate;        //返利额度
@property (nonatomic, strong) NSString *hasCoupon;     //是否有优惠券 0为无 1为有
@property (nonatomic, strong) NSString *hasDiscount;   //是否打折 0为不打折 1为打折 当为0时取discount为打折的值
@property (nonatomic, strong) NSString *discount;      //折扣值
@property (nonatomic, strong) NSString *sales;         //总销量
@property (nonatomic, strong) NSString *brandName;     //品牌名称

//商品标签页
@property (nonatomic, strong) NSString *tagId;//首页商品下标签ID
@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *tagIntro;

//商品详情
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *markedPrice;//原价
@property (nonatomic, strong) NSString *loveNum;
@property (nonatomic, strong) NSString *effect;//功效
@property (nonatomic, strong) NSString *myTagId;//标签id

//分享详情
@property (nonatomic, strong) NSString *shareName;
@property (nonatomic, strong) NSString *shareIntro;
@property (nonatomic, strong) NSString *shareTag;
@property (nonatomic, strong) NSString *shareTagId;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getHomePageDataWithTime:(NSString *)time
                            key:(NSString *)key
                              p:(NSString *)p
                           pnum:(NSString *)pnum;

+ (void)getCatagoryDataWithType:(NSString *)type
                            key:(NSString *)key
                              p:(NSString *)p
                           pnum:(NSString *)pnum;

+ (void)getSearchDataWithKeyword:(NSString *)keyword page:(NSString *)page pageNumber:(NSString *)pnum;
//二期首页商品标签列表
+ (void)getProductMainDataWithKey:(NSString *)key
                             Page:(NSString *)page
                             pnum:(NSString *)pnum;

//二期标签下对应商品列表
+ (void)getProductListDataWithPage:(NSString *)page
                              pnum:(NSString *)pnum
                             tagId:(NSString *)tagId;

@end
