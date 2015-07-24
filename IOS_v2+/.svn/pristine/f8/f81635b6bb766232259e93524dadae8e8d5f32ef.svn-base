//
//  CartModel.m
//  Love
//
//  Created by 李伟 on 14/11/15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CartModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"

/** 购物车店铺商品列表
 
 */
@implementation CartProductInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _allPrice = @"all_price";
        _attribute = @"attribute";
        _codeInfo = @"code";
        _commoId = @"commo_id";
        _commoStandard = @"commo_standard";
        _cartId = @"id";
        _numInfo = @"num";
        _priceInfo = @"price";
        _productId = @"product_id";
        _productName = @"product_name";
        _recomId = @"recom_id";
        _sellerId = @"seller_id";
        _stockNum = @"stock";
        _thumbPath = @"thumb";
        _userId = @"user_id";
    }
    return self;
}

@end


static NSString * const kCartURL = @"Order/cartList";
static NSString * const kDelCartURL = @"Order/cartDelete";
static NSString * const kEditCartURL = @"order/cartItemEdit";

NSString * const kCartNotificationName = @"kCartNotificationName";

/** 购物车列表
 
 */
@implementation CartModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _allPrice = [attributes valueForKey:@"all_price"];
        _allNum = [attributes valueForKey:@"all_num"];
        _sellerId = [attributes valueForKey:@"seller"];
        _sellerName = [attributes valueForKey:@"seller_name"];
        _typeID = [attributes valueForKey:@"type"];
        _productInfo = [attributes valueForKey:@"info"];
    }
    return self;
}

//购物车
+ (void)getCartList
{
    [APPNetworkDao getURLString:kCartURL
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              if ([array count] > 0) {
                                  for (NSDictionary *dic in array) {
                                      CartModel *model = [[CartModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  [[NSNotificationCenter defaultCenter] postNotificationName:kCartNotificationName object:[NSArray arrayWithArray:mutableArray]];
                              }
                          }];
}

/**
 首页分类浏览/侧边栏按实际排序
 
 @param   pid 	购物车id；删除多条的话，用_连接多个id，如： 2_3_4
 @param   type 	type=1 删除一条； type=2 删除多条
 @param  block 服务器返回结果
 */
+ (void)delCartProductWithID:(NSString *)pid type:(NSString *)type block:(void(^)(NSString *code, NSString *msg))block
{
    [APPCommissionDetailDao getURLString:[NSString stringWithFormat:@"%@?id=%@&type=%@", kDelCartURL, pid, type]
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSString *code = [dic objectForKey:@"code"];
                                       NSString *msg = [dic objectForKey:@"msg"];
                                       NSLog(@"del cart = %@ \n msg = %@", dic, msg);

                                       if (block) {
                                           block(code, msg);
                                       }
                                   }
     ];
}

/**
 修改购物车中商品数量
 
 @param  commo：sku接口中，sku的commo_id 与商品的id对应
 commo_id" = (
 456,
 ）
 "commo_list" =         {
 "\U7070:\U5747\U7801" =  {
 id = 456;
 }
 }
 @param  num：商品数量
 @param  block：code=1 成功，code=0失败
 
 */
+ (void)editCartWithCommo:(NSString *)commo num:(NSString *)num block:(void(^)(NSString *code, NSString *msg))block
{
    [APPCommissionDetailDao getURLString:[NSString stringWithFormat:@"%@?commo=%@&num=%@", kEditCartURL, commo, num]
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       
                                       NSString *code = [dic objectForKey:@"code"];
                                       NSString *msg = [dic objectForKey:@"msg"];
                                       NSLog(@"code = %@, msg = %@", code, msg);
                                       if (error == nil) {
                                           if (block) {
                                               block(code, msg);
                                           }
                                       }else {
                                           if (block) {
                                               block(@"0", @"");
                                           }
                                       }
                                   }];
}

@end
