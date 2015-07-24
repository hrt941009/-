//
//  APPRegisterNetworkDao.m
//  Love
//
//  Created by 李伟 on 14-8-5.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "APPRegisterNetworkDao.h"
#import "APPNetworkClient.h"
#import "AFNetworking.h"

@implementation APPRegisterNetworkDao

/**
 注册 和服务器进行通信
 
 @param  path：url
 @param  block：获取到的数据
 
 @block  msg = 请求结果；currentTime = 服务器时间；status = 200 发送成功，其它值失败；error = 错误信息
 */


+ (void)getURLString:(NSString *)urlString
               block:(void (^)(NSString *msg , NSNumber *currentTime, int status, NSError *error, int code))block
{
    [SVProgressHUD showWithStatus:@"正在连接" maskType:SVProgressHUDMaskTypeNone];
    
    [[APPNetworkClient sharedClient] GET:[NSString stringWithFormat:@"%@%@",kAPPNetworkURLHeader, urlString]
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSLog(@"responseObject = %@", responseObject);
                                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                         if ([responseObject count]) {
                                             id postsFromResponse = [responseObject valueForKeyPath:@"result"];
                                             if ([postsFromResponse isKindOfClass:[NSDictionary class]]) {
                                                 int statu = [[responseObject valueForKeyPath:@"status"] intValue];
                                                 if (statu == 200) {
                                                     id msg = [postsFromResponse valueForKey:@"msg"];
                                                     int code = [[postsFromResponse valueForKey:@"code"] intValue];
                                                     if ([msg isKindOfClass:[NSString class]]) {
                                                         if (block) {
                                                             block(msg,
                                                                   [responseObject valueForKey:@"currentTime"], //服务器时间
                                                                   statu,
                                                                   nil, code);
                                                             [SVProgressHUD dismiss];
                                                         }
                                                     }
                                                    
                                                 }
                                             }else{
                                                 [SVProgressHUD showErrorWithStatus:@"Result Data Error"];
                                             }
                                         }
                                     }else{
                                         [SVProgressHUD showErrorWithStatus:@"responseObject Data Error"];
                                     }
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"error = %@", error);
                                     if([error code] == NSURLErrorCancelled)
                                     {
                                         [SVProgressHUD dismiss];
                                         
                                         return [[[APPNetworkClient sharedClient] operationQueue] cancelAllOperations];
                                     }
                                     if (block) {
                                         block(nil, nil, 0, error, 0);
                                         [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                         [SVProgressHUD dismiss];
                                     }
                                 }];
}


@end
