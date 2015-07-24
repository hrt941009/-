//
//  ThirdGetUserInfo.h
//  Love
//
//  Created by use on 15-2-2.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdGetUserInfo : NSObject<NSURLConnectionDelegate>

@property (nonatomic, strong) NSData *reciveData;

+ (void)qqGetUserInfoWithAccessToken:(NSString *)access_token oauthConsumerKey:(NSString *)oauth_consumer_key openid:(NSString *)openid block:(void(^)(NSDictionary *dic))block;

+ (void)sinaGetUserInfoWithAccessToken:(NSString *)access_token uid:(NSString *)uid block:(void(^)(NSDictionary *dic))block;

@end
