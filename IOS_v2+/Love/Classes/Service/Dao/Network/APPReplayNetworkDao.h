//
//  APPReplayNetworkDao.h
//  Love
//
//  Created by lee wei on 14-9-30.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APPNetworkClient;
@interface APPReplayNetworkDao : NSObject

+ (void)postURLString:(NSString *)urlString
           parameters:(NSDictionary *)parameters
                block:(void (^)(int code, NSString *msg))block;

@end
