//
//  LOVWXPayClient.m
//  Love
//
//  Created by 刘轶男 on 15/4/25.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "LOVWXPayClient.h"
#import "LOVThirdLoginConfig.h"
#import "UserManager.h"
#import "AppDelegate.h"
#import "WXUtil.h"
@interface LOVWXPayClient()

@property (nonatomic, strong) NSString *partnerId;
@property (nonatomic, strong) NSString *prepayId;
@property (nonatomic, strong) NSString *package;
@property (nonatomic, strong) NSString *nonceStr;
@property (nonatomic, strong) NSString *timeStamp;
@property (nonatomic, strong) NSString *sign;

@end

@implementation LOVWXPayClient

+(instancetype)shareInstance{
    static LOVWXPayClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[LOVWXPayClient alloc] init];
    });
    return sharedClient;
}

- (void)parametersWithPartnerId:(NSString *)partnerId
                       parpayId:(NSString *)parpayId
                        package:(NSString *)package
                       nonceStr:(NSString *)nonceSte
                      timeStamp:(NSString *)timeStamp
                           sign:(NSString *)sign{
    self.partnerId = partnerId;
    self.prepayId = parpayId;
    self.package = package;
    self.nonceStr = nonceSte;
    self.timeStamp = timeStamp;
    self.sign = sign;
    
//    [self payProduct];
}

- (NSMutableDictionary *)twoSign{
    if (_prepayId.length > 0) {
//        获取到_prepayId后进行第二次签名
        NSString *package,*time_stamp,*nonce_str;
//        设置支付参数
        time_stamp = _timeStamp;
        nonce_str = [WXUtil md5:time_stamp];
        package = @"Sign=WXPay";
        
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: kWXAPP_ID        forKey:@"appid"];
        [signParams setObject: nonce_str    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: MCH_ID        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: _prepayId     forKey:@"prepayid"];
        
        //生成签名
        NSString *sign  = [self createMd5Sign:signParams];
        
        //添加签名
        [signParams setObject: sign         forKey:@"sign"];
        
        return signParams;
    }else{
        NSLog(@"没有获取到prepayId");
    }
    return nil;
}

//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", PARTNER_ID];
    //得到MD5 sign签名
    NSString *md5Sign =[WXUtil md5:contentString];
    
    //输出Debug Info
//    [debugInfo appendFormat:@"MD5签名字符串：\n%@\n\n",contentString];
    
    return md5Sign;
}


- (void)payProduct{
//    NSDictionary *dic = [self twoSign];
    NSLog(@"sign = %@",[self twoSign]);
    
    
     [self getAccessToken];
}

- (void)getAccessToken{
    [WXApi registerApp:kWXAPP_ID];
//    [WXApi registerApp:kWXAPP_ID withDescription:kWXAPP_SECRET];
    NSDictionary *dic = [self twoSign];
    // 调起微信支付
    PayReq *request   = [[PayReq alloc] init];
    request.partnerId = [dic objectForKey:@"partnerid"];/** 商家向财付通申请的商家id */
    request.prepayId  = [dic objectForKey:@"prepayid"];/** 预支付订单 */
    request.package   = [dic objectForKey:@"package"];/** 商家根据财付通文档填写的数据和签名 */
    request.nonceStr  = [dic objectForKey:@"noncestr"];/** 随机串，防重发 */
    NSString *timestamp = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]];
    request.timeStamp = [timestamp intValue];/** 时间戳，防重发 */
    request.sign = [dic objectForKey:@"sign"];/** 商家根据微信开放平台文档对数据做的签名 */
    [WXApi safeSendReq:request];
}


@end
