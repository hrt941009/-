//
//  APPCommissionDetailDao.m
//  Love
//
//  Created by lee wei on 14-9-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "APPCommissionDetailDao.h"
#import "APPNetworkClient.h"

@implementation APPCommissionDetailDao

/**
 通用 和服务器进行通信
 
 @param  path：url
 @param  paramters：传入的参数，paramters=nil 为GET，paramters!=nil 为POST
 @param  block：获取到的数据
 
 @block  dic = 请求结果；currentTime = 服务器时间；error = 错误信息
 */
+ (void)getURLString:(NSString *)urlString
               block:(void (^)(NSDictionary *dic, NSNumber *currentTime, NSError *error))block
{
    //[SVProgressHUD showWithStatus:@"正在连接" maskType:SVProgressHUDMaskTypeNone];
    NSString *url = [NSString stringWithFormat:@"%@%@", kAPPNetworkURLHeader, urlString];
    NSLog(@"urlString = %@", url);
    [[APPNetworkClient sharedClient] GET:url
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSLog(@"responseObject = %@", responseObject);
                                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                         if ([responseObject count]) {
                                             int status = [[responseObject objectForKey:@"status"] intValue];
                                             if (status == 200) {
                                                 id postsFromResponse = [responseObject valueForKeyPath:@"result"];
                                                 if ([postsFromResponse isKindOfClass:[NSDictionary class]]) {
                                                     if ([postsFromResponse count]) {
                                                         if (block) {
                                                             block(postsFromResponse,
                                                                   [responseObject valueForKey:@"currentTime"], //服务器时间
                                                                   nil);
                                                         }
                                                     }
                                                 }else{
                                                     [SVProgressHUD showErrorWithStatus:@"Result Data Error"];
                                                 }
                                                 //[SVProgressHUD dismiss];
                                             }else if(status == 610 || status == 604 || status == 404){
                                                 NSString *msg = [[responseObject valueForKey:@"result"] valueForKey:@"msg"];
                                                 NSLog(@"msg = %@", msg);
                                                 [SVProgressHUD showErrorWithStatus:msg];
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
                                         block(@{}, nil, error);
                                         [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                         //[SVProgressHUD dismiss];
                                         
                                     }
                                 }];
    //[SVProgressHUD dismiss];
}


@end
