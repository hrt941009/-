//
//  APPCommissionDetailDao.h
//  Love
//
//  Created by lee wei on 14-9-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APPNetworkClient;

@interface APPCommissionDetailDao : NSObject

+ (void)getURLString:(NSString *)urlString
               block:(void (^)(NSDictionary *dic, NSNumber *currentTime, NSError *error))block;

@end
