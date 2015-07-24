//
//  CartModel.h
//  Love
//
//  Created by 李伟 on 14/11/15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DelCartProduct)
{
    DelCartProductOne = 1,     //删除一个购物车中商品
    DelCartProductMultiple = 2 //删除多个购物车中商品
};

@interface CartProductInfoModel : NSObject

@property (nonatomic, strong) NSString *allPrice;//该订单价格
@property (nonatomic, strong) NSString *attribute;//
@property (nonatomic, strong) NSString *codeInfo;//
@property (nonatomic, strong) NSString *commoId;//
@property (nonatomic, strong) NSString *commoStandard;//
@property (nonatomic, strong) NSString *cartId;//
@property (nonatomic, strong) NSString *numInfo;//
@property (nonatomic, strong) NSString *priceInfo;//
@property (nonatomic, strong) NSString *productId;//
@property (nonatomic, strong) NSString *productName;//
@property (nonatomic, strong) NSString *recomId;//
@property (nonatomic, strong) NSString *sellerId;//
@property (nonatomic, strong) NSString *stockNum;//
@property (nonatomic, strong) NSString *thumbPath;//
@property (nonatomic, strong) NSString *userId;//


- (instancetype)init;

@end

@interface CartModel : NSObject

extern NSString * const kCartNotificationName;

@property (nonatomic, strong) NSString *allPrice;//该订单价格
@property (nonatomic, strong) NSString *allNum;//
@property (nonatomic, strong) NSString *sellerId;//
@property (nonatomic, strong) NSString *sellerName;//
@property (nonatomic, strong) NSString *typeID;//
@property (nonatomic, strong) NSArray *productInfo;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (void)getCartList;
+ (void)delCartProductWithID:(NSString *)pid type:(NSString *)type block:(void(^)(NSString *code, NSString *msg))block;
+ (void)editCartWithCommo:(NSString *)commo num:(NSString *)num block:(void(^)(NSString *code, NSString *msg))block;

@end
