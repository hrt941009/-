//
//  APPReplayNetworkDao.m
//  Love
//
//  Created by lee wei on 14-9-30.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "APPReplayNetworkDao.h"
#import "APPNetworkClient.h"

@implementation APPReplayNetworkDao

/**
 通用 和服务器进行通信
 
 @param  path：url
 @param  block：获取到的数据
 
 @block  array = 请求结果；currentTime = 服务器时间；error = 错误信息
 */
+ (void)postURLString:(NSString *)urlString
           parameters:(NSDictionary *)parameters
                block:(void (^)(int code, NSString *msg))block
{
   // [SVProgressHUD showWithStatus:@"正在连接" maskType:SVProgressHUDMaskTypeNone];
    
    NSLog(@"urlString = %@", urlString);
    [[APPNetworkClient sharedClient] GET:[NSString stringWithFormat:@"%@%@", kAPPNetworkURLHeader, urlString]
                               parameters:parameters
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSLog(@"responseObject = %@", responseObject);
                                      if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                          if ([responseObject count]) {
                                              int status = [[responseObject objectForKey:@"status"] intValue];
                                              if (status == 200) {
                                                  id postsFromResponse = [responseObject valueForKeyPath:@"result"];
                                                  if ([postsFromResponse isKindOfClass:[NSDictionary class]]) {
                                                      if ([postsFromResponse count]) {
                                                          int code = [[postsFromResponse objectForKey:@"code"] intValue];
                                                          NSString *msg = [postsFromResponse objectForKey:@"msg"];
                                                          NSLog(@"msg = %@", msg);
                                                          if (block) {
                                                              block(code, msg);
                                                              
                                                          }
                                                      }
                                                  }else{
                                                      [SVProgressHUD showErrorWithStatus:@"Result Data Error"];
                                                  }
                                              }else{
                                                  [SVProgressHUD showErrorWithStatus:@""];
                                              }
                                          }
                                      }else{
                                          [SVProgressHUD showErrorWithStatus:@"responseObject Data Error"];
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"error = %@", error);
                                      if([error code] == NSURLErrorCancelled)
                                      {
                                          [SVProgressHUD dismiss];
                                          
                                          return [[[APPNetworkClient sharedClient] operationQueue] cancelAllOperations];
                                      }
                                      if (block) {
                                          block(500, @"服务器错误");
                                          [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                          [SVProgressHUD dismiss];
                                          
                                      }
                                  }];
}


@end
