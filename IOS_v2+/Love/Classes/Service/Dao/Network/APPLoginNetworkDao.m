//
//  LoginNetworkDao.m
//  Love
//
//  Created by 李伟 on 14/10/28.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "APPLoginNetworkDao.h"
#import "APPNetworkClient.h"
#import "UserManager.h"

@implementation APPLoginNetworkDao

/**
 登录
 
 @param  path：url
 @param  block：获取到的数据
 
 @block  array = 请求结果；currentTime = 服务器时间；error = 错误信息
 */
+ (void)postLoginURLString:(NSString *)urlString
                parameters:(NSDictionary *)parameters
                     block:(void (^)(NSDictionary *dic))block
{
    [SVProgressHUD showWithStatus:@"正在登录" maskType:SVProgressHUDMaskTypeNone];
    NSLog(@"urlString = %@", urlString);
    [[APPNetworkClient sharedClient] GET:[NSString stringWithFormat:@"%@%@", kAPPNetworkURLHeader, urlString]
                              parameters:parameters
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSLog(@"responseObject = %@", responseObject);
                                     int status = [[responseObject objectForKey:@"status"] intValue];
                                     if (status == 200) {
                                         NSDictionary *postsFromResponse = [responseObject valueForKeyPath:@"result"];
                                         if (block) {
                                             block(postsFromResponse);
                                             
                                         }
                                     }else{
                                         [SVProgressHUD showErrorWithStatus:@""];
                                     }
                                     
                                     [SVProgressHUD dismiss];
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"error = %@", error);
                                     if([error code] == NSURLErrorCancelled)
                                     {
                                         [SVProgressHUD dismiss];
                                         
                                         return [[[APPNetworkClient sharedClient] operationQueue] cancelAllOperations];
                                     }
                                     if (block) {
                                         block(@{});
                                         [SVProgressHUD showErrorWithStatus:@"服务器错误"];
                                         [SVProgressHUD dismiss];
                                         
                                     }
                                 }];
}

/**
 登录后的请求
 
 @param  path：url
 @param  block：获取到的数据
 
 @block  array = 请求结果；currentTime = 服务器时间；error = 错误信息
 */
+ (void)getInLoginURLString:(NSString *)urlString
                 parameters:(NSDictionary *)parameters
                      block:(void (^)(NSArray *array, NSNumber *currentTime, NSError *error))block;
{
    NSString *baseURLString = @"http://m.hafung.com/ht/index.php/Home/";
    NSURL *postURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",  baseURLString, urlString]];
    NSLog(@"postURL = %@", postURL);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"json = %@", jsonStr);
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:postURL];
    NSDictionary *sheaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    
    NSLog(@"sheaders---- %@", sheaders);
    
    //
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:postURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.f];
    //    NSString *str = AFQueryStringFromParametersWithEncoding(parameters, NSUTF8StringEncoding);
    [request setHTTPMethod:@"POST"];
    [request addValue:@"iOS" forHTTPHeaderField:@"User-Agent"];
    [request addValue:[UserManager readSig] forHTTPHeaderField:@"sig"];
    [request addValue:[UserManager readUid] forHTTPHeaderField:@"uid"];
    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    [request setAllHTTPHeaderFields:sheaders];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = nil;
        NSError *error = nil;
        id jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if (jsonData != nil && error == nil) {
            if ([jsonData isKindOfClass:[NSDictionary class]]) {
                dic = (NSDictionary *)jsonData;
                NSLog(@"dic = %@", dic);
                int status = [[dic objectForKey:@"status"] intValue];
                NSNumber *currentTime = [dic valueForKey:@"currentTime"];
                if (status == 200) {
                    NSArray *array = [dic valueForKeyPath:@"result"];
                    if (block) {
                        block(array, currentTime, error);
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"服务器获取数据错误"];
                }

            }
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"服务器获取数据错误"];
    }];
    
    [operation start];
}

@end
