//
//  SendGoodsModel.m
//  Love
//
//  Created by use on 14-12-12.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "SendGoodsModel.h"
#import "APPReplayNetworkDao.h"
static NSString * const kSendGoodsURL = @"orderList/orderNotic";
static NSString * const kReciveURL = @"orderList/confirmOrderList";
static NSString * const kOrderCancleURL = @"orderList/changeOrder";
@implementation SendGoodsModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (void)sendGoodsForCode:(NSString *)code block:(void(^)(int code, NSString *msg))block{
    NSDictionary *dic = @{@"code": code};
    [APPReplayNetworkDao postURLString:kSendGoodsURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code,msg);
                                     }
                                 }];
}

+ (void)reciveForStatusandCode:(NSString *)code block:(void(^)(int code))block{
    NSDictionary *dic = @{@"code":code};
    [APPReplayNetworkDao postURLString:kReciveURL
                            parameters:dic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code);
                                     }
                                 }];
}

+ (void)orderCancleForCode:(NSString *)code andStatus:(NSString *)status block:(void(^)(int code))block{
    NSDictionary *dic = @{@"status":status, @"code":code};
    [APPReplayNetworkDao postURLString:kOrderCancleURL parameters:dic block:^(int code, NSString *msg) {
        block(code);
    }];
}

@end
