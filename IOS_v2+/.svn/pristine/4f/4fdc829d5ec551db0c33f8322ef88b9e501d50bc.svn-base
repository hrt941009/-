//
//  UserInfoAndShareModel.m
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "UserInfoAndShareModel.h"
#import "APPCommissionDetailDao.h"
static  NSString * const kUserInfoAndShareListURL = @"tag/userHome";
@implementation UserInfoAndShareModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)getUserInfoAndShareList:(NSString *)userId block:(void(^)(NSDictionary *userInfo))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?user_id=%@",kUserInfoAndShareListURL,userId];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        if (block) {
            block(dic);
        }
    }];
}

@end
