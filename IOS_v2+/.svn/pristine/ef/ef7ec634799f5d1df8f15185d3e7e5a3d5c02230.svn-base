//
//  APPThirdLoginDao.m
//  Love
//
//  Created by use on 15-2-2.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "APPThirdLoginDao.h"
#import "APPNetworkClient.h"

@implementation APPThirdLoginDao
+ (void)postURLString:(NSString *)urlString
           parameters:(NSDictionary *)parameters
                block:(void (^)(int code, NSString *msg, NSString *uid, NSString *sig))block{
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
                                                         if ([postsFromResponse objectForKey:@"uid"]) {
                                                             NSString *uid = [postsFromResponse valueForKey:@"uid"];
                                                             NSString *sig = [postsFromResponse valueForKey:@"sig"];
                                                             if (block) {
                                                                 block(code, msg, uid, sig);
                                                                 
                                                             }else{
                                                                 block(code, msg, nil, nil);
                                                             }
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
                                         block(500, @"服务器错误", nil, nil);
                                         [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                         [SVProgressHUD dismiss];
                                         
                                     }
                                 }];

}
@end
