//
//  ShopNewModel.h
//  Love
//
//  Created by lee wei on 14/12/21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//  店铺 - 上新
//

#import <Foundation/Foundation.h>

extern NSString * const kShopNewNotificationName;

@interface ShopNewModel : NSObject

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getShopNewWithShopID:(NSString *)shopID page:(NSString *)page pageNum:(NSString *)pageNum;

@end
