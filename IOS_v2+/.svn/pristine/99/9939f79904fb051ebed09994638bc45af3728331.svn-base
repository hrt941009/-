//
//  ThirdGetUserInfo.m
//  Love
//
//  Created by use on 15-2-2.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ThirdGetUserInfo.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

static NSString * const qqUserInfoHeader = @"https://graph.qq.com/user/get_user_info";
static NSString * const sinaUserInfoHeader = @"https://api.weibo.com/2/users/show.json";

@implementation ThirdGetUserInfo

+ (void)qqGetUserInfoWithAccessToken:(NSString *)access_token oauthConsumerKey:(NSString *)oauth_consumer_key openid:(NSString *)openid block:(void(^)(NSDictionary *dic))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?oauth_consumer_key=%@&access_token=%@&openid=%@",qqUserInfoHeader,oauth_consumer_key,access_token,openid];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.f];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        if (block) {
            block(dic);
        }
    }else{
          [SVProgressHUD showErrorWithStatus:@"获取用户信息失败！"];
    }
    
}

+ (void)sinaGetUserInfoWithAccessToken:(NSString *)access_token uid:(NSString *)uid block:(void(^)(NSDictionary *dic))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?access_token=%@&uid=%@",sinaUserInfoHeader,access_token,uid];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.f];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data != nil) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        if (block) {
            block(dic);
        }
    }else{
          [SVProgressHUD showErrorWithStatus:@"获取用户信息失败！"];
    }
}


@end
