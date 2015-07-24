//
//  LOVNetworkDao.m
//  Love
//
//  Created by 李伟 on 14-7-21.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "APPNetworkDao.h"
#import "APPNetworkClient.h"


@implementation APPNetworkDao

/**
 通用 和服务器进行通信
 
 @param  path：url
 @param  paramters：传入的参数，paramters=nil 为GET，paramters!=nil 为POST
 @param  block：获取到的数据
 
 @block  array = 请求结果；currentTime = 服务器时间；error = 错误信息
 */
+ (void)getURLString:(NSString *)urlString
          parameters:(NSDictionary *)paramters
               block:(void (^)(NSArray *array, NSNumber *currentTime, NSError *error))block
{
    //[SVProgressHUD showWithStatus:@"正在连接" maskType:SVProgressHUDMaskTypeNone];
    NSString *string = [NSString stringWithFormat:@"%@%@", kAPPNetworkURLHeader, urlString];
    NSLog(@"url = %@", string);
    [[APPNetworkClient sharedClient] GET:string
                              parameters:paramters
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                         if ([responseObject count]) {
                                             int status = [[responseObject objectForKey:@"status"] intValue];
                                             if (status == 200) {
                                                 id postsFromResponse = [responseObject valueForKeyPath:@"result"];
                                                 NSLog(@"responseObject = %@", responseObject);
                                                 if ([postsFromResponse isKindOfClass:[NSArray class]]) {
                                                     if (block) {
                                                         block(postsFromResponse,
                                                               [responseObject valueForKey:@"currentTime"], //服务器时间
                                                               nil);
                                                         
                                                     }                                                 }else{
                                                     [SVProgressHUD showErrorWithStatus:@"Result Data Error"];
                                                 }
                                             }
                                         }
                                     }else{
                                         [SVProgressHUD showErrorWithStatus:@"responseObject Data Error"];
                                     }
                                     
                                     
                                     //[SVProgressHUD dismiss];
                                     
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"error = %@", error);
                                     if([error code] == NSURLErrorCancelled){
                                         [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                         
                                         return [[[APPNetworkClient sharedClient] operationQueue] cancelAllOperations];
                                     }
                                     if (block) {
                                         block([NSArray array], nil, error);
                                         [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                         
                                     }
                                 }];
    

}



@end
