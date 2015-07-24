//
//  AlipayIDListModel.m
//  Love
//
//  Created by use on 15-1-7.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "AlipayIDListModel.h"
#import "APPCommissionDetailDao.h"
#import "APPNetworkDao.h"

@implementation AlipayIDListModel
static NSString * const kAlipayIDListURL = @"FlItem/showUserAlipay";
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _alipay = [attributes objectForKey:@"alipay"];
        _name = [attributes objectForKey:@"name"];
    }
    return self;
}
//+ (void)getAlipayIDLisyDataBlock:(void(^)(NSString *alipay, NSString *name))block{
//    NSString *url = [NSString stringWithFormat:@"%@",kAlipayIDListURL];
//    [APPCommissionDetailDao getURLString:url block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
//        AlipayIDListModel *model = [[AlipayIDListModel alloc] initWithAttributtes:dic];
//        NSString *alipay = model.alipay;
//        NSString *name = model.name;
//        if (block) {
//            block(alipay,name);
//        }
//    }];
//}

+ (void)getAlipayIDLisyDataBlock:(void(^)(NSArray *array))block{
    NSString *url = [NSString stringWithFormat:@"%@",kAlipayIDListURL];
    [APPNetworkDao getURLString:url parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        if (block) {
            block(array);
        }
    }];
}

@end
