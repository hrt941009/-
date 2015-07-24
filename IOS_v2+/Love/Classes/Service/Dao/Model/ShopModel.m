//
//  ShopModel.m
//  Love
//
//  Created by lee wei on 14/12/20.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ShopModel.h"
#import "APPCommissionDetailDao.h"
#import "UserManager.h"


static NSString * const kShopInfoURL = @"Shop/shopInfoById?id";

@implementation ShopModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shopName = @"shop_name";
        _shopLogo = @"shop_logo";
        _isAttent = @"is_attent";
        _funsNum = @"funs_num";
        _allCount = @"all_count";
        _returnCount = @"return_discount_count";
        _itemNum = @"new_item_num";
    }
    return self;
}

- (void)getShopInfoWithId:(NSString *)shopId block:(void(^)(NSDictionary *dic))block
{
    NSString *sig = [UserManager readSig];
    NSString *uid = [UserManager readUid];
    
    NSString *urlString = [NSString stringWithFormat:@"%@=%@&sig=%@&uid=%@", kShopInfoURL, shopId, sig, uid];
    [APPCommissionDetailDao getURLString:urlString block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        if ([dic count] > 0) {
            if (block) {
                block(dic);
            }
        }
    }];
}

@end
