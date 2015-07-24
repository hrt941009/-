//
//  APPHomePageNetworkDao.m
//  Love
//
//  Created by 李伟 on 14-7-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "APPHomePageNetworkDao.h"
#import "APPNetworkClient.h"

@implementation APPHomePageNetworkDao

/**
 首页 和服务器进行通信
 
 @param  path： url
、 @param  block：获取到的数据
 
 @block  array = 请求的结果； error = 错误信息
 */
+ (void)getURLString:(NSString *)urlString
               block:(void (^)(NSDictionary *resultDic, NSError *error))block
{
    [[APPNetworkClient sharedClient] GET:[NSString stringWithFormat:@"%@%@", kAPPNetworkURLHeader, urlString]
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSError *error = nil;
                                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                         if ([responseObject count]) {
                                             int status = [[responseObject objectForKey:@"status"] intValue];
                                             if (status == 200) {
                                                 id postsFromResponse = [responseObject valueForKeyPath:@"result"];
                                                 if ([postsFromResponse isKindOfClass:[NSDictionary class]]) {
                                                     if ([postsFromResponse count]) {
                                                         if (block) {
                                                             block(postsFromResponse, error);
                                                         }
                                                     }
                                                 }else{
                                                     [SVProgressHUD showErrorWithStatus:@"Result Data Error"];
                                                 }
                                             }else if(status == 610 || status == 604 || status == 404){
                                                 NSString *msg = [[responseObject valueForKey:@"result"] valueForKey:@"msg"];
                                                 NSLog(@"msg = %@", msg);
                                                 [SVProgressHUD showErrorWithStatus:@"未找到商品"];
                                             }
                                             else{
                                                 [SVProgressHUD showErrorWithStatus:@"未找到商品"];
                                             }
                                         }
                                     }else{
                                         [SVProgressHUD showErrorWithStatus:@"responseObject Data Error"];
                                     }

                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"error = %@", error);
                                     if([error code] == NSURLErrorCancelled)
                                     {
                                         //[SVProgressHUD dismiss];
                                         
                                         return [[[APPNetworkClient sharedClient] operationQueue] cancelAllOperations];
                                     }
                                     if (block) {
                                         block(@{}, error);
                                         [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                         [SVProgressHUD dismiss];
                                     }
                                 }];
}


@end
