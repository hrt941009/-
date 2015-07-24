//
//  AfterSaleOrderListModel.h
//  Love
//
//  Created by use on 14-12-26.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//售后服务订单列表
#import <Foundation/Foundation.h>
extern NSString * const kAfterSaleOrderListNoticefationName;
@interface AfterSaleOrderListModel : NSObject

@property (nonatomic, strong) NSString *code;//商品订单号
@property (nonatomic, strong) NSString *product_name;//商品名称
@property (nonatomic, strong) NSString *product_thumb;//商品图片
@property (nonatomic, strong) NSString *commo_id;//商品id
@property (nonatomic, strong) NSString *product_id;//
@property (nonatomic, strong) NSString *commo_standard;//商品属性
@property (nonatomic, strong) NSString *price;//商品价格
@property (nonatomic, strong) NSString *rebate;//商品返利值
@property (nonatomic, strong) NSString *num;//商品数量
@property (nonatomic, strong) NSString *status;//订单状态
@property (nonatomic, strong) NSString *create_time;//创建时间
- (instancetype)initWithAttributtes:(NSDictionary *)attributes;

+ (void)getAfterSaleOrderListWithPage:(NSString *)page pageNumber:(NSString *)pageNumber;
@end
