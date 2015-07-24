//
//  LOVNetworkDao.h
//  Love
//
//  Created by 李伟 on 14-7-21.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  不需要登陆的数据
//

#import <Foundation/Foundation.h>



@class APPNetworkClient;
@interface APPNetworkDao : NSObject

+ (void)getURLString:(NSString *)urlString
          parameters:(NSDictionary *)paramters
               block:(void (^)(NSArray *array, NSNumber *currentTime, NSError *error))block;


@end
