//
//  APPNetworkClient.m
//  Love
//
//  Created by 李伟 on 14-7-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "APPNetworkClient.h"

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

//static const int port = 7070;
//static const char *ip = "54.179.128.228";//http://m.hafung.com/ht/index.php/Home/
//http://112.124.27.233/ht/index.php/home/

static NSString * const kAPPAddressName = @"http://m.baai.com";
NSString * const kAPPHTMLHeader = @"baai2/html";
static NSString * const kAPPHostName = @"http://112.124.27.233";
NSString * const kAPPNetworkURLHeader = @"ht_dev_test/index.php/home/";
 
@implementation APPNetworkClient

+ (NSString *)lovRequestIP
{
    return [NSString stringWithFormat:@"%@/", kAPPHostName];
}

+ (NSString *)lovRequestURL
{
    return [NSString stringWithFormat:@"%@/%@", kAPPHostName, kAPPNetworkURLHeader];
}
+ (NSString *)lovRequestADDR
{
    return [NSString stringWithFormat:@"%@/%@",kAPPAddressName,kAPPHTMLHeader];
}
/**
 sharedClient：1 检查网络是否连接；2 连接服务器
 
 @return _client
 */
+ (instancetype)sharedClient
{
    //ip地址
    NSString *APIBaseURLWithString = [NSString stringWithFormat:@"%@", kAPPHostName];
    // [NSString stringWithFormat:@"http://%@:%d", [NSString stringWithUTF8String:ip], port];

    static APPNetworkClient *_client;
    static dispatch_once_t onceToken;
    
    

    /**-- 检查ip
    struct sockaddr_in addr;
    addr.sin_len = sizeof(addr);
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = inet_addr(ip);

    Reachability *rb = [Reachability reachabilityWithAddress:&addr];
    NetworkStatus status = [rb currentReachabilityStatus];
    
    if (status == NotReachable) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
        
    }else{
        dispatch_once(&onceToken, ^{
            _client = [[APPNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLWithString]];
            _client.requestSerializer = [AFJSONRequestSerializer serializer];
            _client.requestSerializer.timeoutInterval = 25.f;
            _client.responseSerializer = [AFJSONResponseSerializer serializer];
            _client.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
            

        });

    }
    */
    
    Reachability *rb = [Reachability reachabilityWithHostname:@"www.baai.com"];
    NetworkStatus status = [rb currentReachabilityStatus];
    
    if (status == NotReachable) {
        [SVProgressHUD showErrorWithStatus:MyLocalizedString(@"网络连接失败")];
        
    }else{
        dispatch_once(&onceToken, ^{
            _client = [[APPNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLWithString]];
            _client.requestSerializer = [AFJSONRequestSerializer serializer];
            _client.requestSerializer.timeoutInterval = 20.f;
            _client.responseSerializer = [AFJSONResponseSerializer serializer];
            _client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
            
        });
    }
    return _client;
}

@end
