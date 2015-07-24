//
//  LoginNetworkDao.h
//  Love
//
//  Created by 李伟 on 14/10/28.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class APPNetworkClient;
@interface APPLoginNetworkDao : NSObject

+ (void)postLoginURLString:(NSString *)urlString
                parameters:(NSDictionary *)parameters
                     block:(void (^)(NSDictionary *dic))block;

+ (void)getInLoginURLString:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
                      block:(void (^)(NSArray *array, NSNumber *currentTime, NSError *error))block;

@end
