//
//  WXPayModel.m
//  Love
//
//  Created by 刘轶男 on 15/4/27.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "WXPayModel.h"
#import "APPCommissionDetailDao.h"

static NSString * const kWXPrePayURL = @"Weipay/preOrder";

@implementation WXPayModel
+ (void)getWXParagamWithCode:(NSString *)code block:(void(^)(NSString *appId, NSString *nonceStr, NSString *package, NSString *partnerId, NSString *prepayId, NSString *sign, NSString *timeStamp))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?code=%@",kWXPrePayURL,code];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        if (block) {
            NSString *appId = [dic objectForKey:@"appId"];
            NSString *nonceStr = [dic objectForKey:@"nonceStr"];
            NSString *package = [dic objectForKey:@"package"];
            NSString *partnerId = [dic objectForKey:@"partnerId"];
            NSString *prepayId = [dic objectForKey:@"prepayId"];
            NSString *sign = [dic objectForKey:@"sign"];
            NSString *timeStamp = [dic objectForKey:@"timeStamp"];
            block(appId,nonceStr,package,partnerId,prepayId,sign,timeStamp);
        }
    }];
}


@end
