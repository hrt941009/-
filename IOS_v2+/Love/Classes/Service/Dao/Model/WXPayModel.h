//
//  WXPayModel.h
//  Love
//
//  Created by 刘轶男 on 15/4/27.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXPayModel : NSObject

+ (void)getWXParagamWithCode:(NSString *)code block:(void(^)(NSString *appId, NSString *nonceStr, NSString *package, NSString *partnerId, NSString *prepayId, NSString *sign, NSString *timeStamp))block;

@end
