//
//  APPRegisterNetworkDao.h
//  Love
//
//  Created by 李伟 on 14-8-5.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  注册功能接口
//

#import <Foundation/Foundation.h>

@interface APPRegisterNetworkDao : NSObject

+ (void)getURLString:(NSString *)urlString
               block:(void (^)(NSString *msg , NSNumber *currentTime, int status, NSError *error, int code))block;

@end
