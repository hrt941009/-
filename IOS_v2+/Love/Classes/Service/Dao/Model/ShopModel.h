//
//  ShopModel.h
//  Love
//
//  Created by lee wei on 14/12/20.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//  店铺首页信息
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject

@property (nonatomic, strong) NSString *shopName;//	 	店铺名称
@property (nonatomic, strong) NSString *shopLogo;//	 	店铺logo图
@property (nonatomic, strong) NSString *isAttent;//	 	是否关注 1已关注 0 未关注
@property (nonatomic, strong) NSString *funsNum;//	 	粉丝数
@property (nonatomic, strong) NSString *allCount;//	 	所有商品数
@property (nonatomic, strong) NSString *returnCount;//	 	返利优惠商品数量
@property (nonatomic, strong) NSString *itemNum;//	 	新品数量

- (instancetype)init;

- (void)getShopInfoWithId:(NSString *)shopId block:(void(^)(NSDictionary *dic))block;

@end
