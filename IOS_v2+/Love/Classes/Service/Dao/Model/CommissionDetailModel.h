//
//  CommissionDetailModel.h
//  Love
//
//  Created by lee wei on 14-9-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  返利商品详情 返利商品介绍
//

#import <Foundation/Foundation.h>

extern NSString * const kCommissionDescNotificationName;

@interface CommissionDescModel : NSObject

+ (void)getCommissionDescListWithID:(NSString *)cid;

@end


//  返利商品详情
@interface CommissionDetailModel : NSObject

@property (nonatomic, strong) NSString *cid;           //商品ID
@property (nonatomic, strong) NSString *cName;         //标题
@property (nonatomic, strong) NSArray  *cImageArray;   //商品图片
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

@property (nonatomic, strong) NSString *hasNextPrice;   //0为不存在下次购买价(不显示下次购买价)，1为存在(显示下次购买价)
@property (nonatomic, strong) NSString *nextPrice;      //下次购买价
@property (nonatomic, strong) NSString *isAttention;    //0为未喜欢 1为喜欢
@property (nonatomic, strong) NSString *commissionStock;//库存

@property (nonatomic, strong) NSString *sales;          //总销量
@property (nonatomic, strong) NSString *brandId;        //品牌ID
@property (nonatomic, strong) NSString *brandName;      //品牌名称
@property (nonatomic, strong) NSString *intro;          //商品简介

- (instancetype)initWithAttributes:(NSDictionary *)attributes;


+ (void)getDetailWithItem:(NSString *)item block:(void(^)(NSArray *array))block;

@end
