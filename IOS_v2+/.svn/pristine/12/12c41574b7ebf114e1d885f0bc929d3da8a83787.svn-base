//
//  ShopDiscountModel.h
//  Love
//
//  Created by lee wei on 14/12/21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//  店铺-优惠返利
//

#import <Foundation/Foundation.h>

extern NSString * const kShopDiscountNotificationName;

@interface ShopDiscountModel : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *isRebate;
@property (nonatomic, strong) NSString *rebateInfo;
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *thumb;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getShopDiscountWithShopID:(NSString *)shopID page:(NSString *)page pageNum:(NSString *)pageNum;

@end
