//
//  SendGoodsModel.h
//  Love
//
//  Created by use on 14-12-12.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//提醒发货，确认收货，订单取消

#import <Foundation/Foundation.h>

@interface SendGoodsModel : NSObject

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (void)sendGoodsForCode:(NSString *)code block:(void(^)(int code, NSString *msg))block;
+ (void)reciveForStatusandCode:(NSString *)code block:(void(^)(int code))block;
+ (void)orderCancleForCode:(NSString *)code andStatus:(NSString *)status block:(void(^)(int code))block;
@end
