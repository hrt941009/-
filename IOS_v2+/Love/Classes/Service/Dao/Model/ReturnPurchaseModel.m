//
//  ReturnPurchaseModel.m
//  Love
//
//  Created by use on 14-12-26.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ReturnPurchaseModel.h"
#import "APPCommissionDetailDao.h"
#import "APPNetworkDao.h"
#import "APPNetworkClient.h"
static NSString * const kReturnPurchaseURL = @"orderList/returnItem";
@implementation ReturnPurchaseModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)getReturnPurchaseDataCode:(NSString *)code
                            intro:(NSString *)intro
                           reason:(NSString *)reason
                            money:(NSString *)money
                            image:(NSString *)img
                            block:(void(^)(int code, NSString *msg))block{
//    NSString *url = [NSString stringWithFormat:@"%@?code=%@&intro=%@&reason=%@&img=%@&money=%@",kReturnPurchaseURL,code,intro,reason,img,money];
//    [APPCommissionDetailDao getURLString:url
//                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
//                                       int code = [[dic objectForKey:@"code"] intValue];
//                                       NSString *msg = [dic objectForKey:@"msg"];
//                                       NSLog(@"msg = %@", msg);
//                                       if (block) {
//                                           block(code, msg);
//            
//                                       }
//                                   }];
    NSString *url = [NSString stringWithFormat:@"%@%@",kAPPNetworkURLHeader,kReturnPurchaseURL];
    NSDictionary *parmeters = nil;
    if (intro.length == 0 && img.length != 0) {
        parmeters = @{@"code":code,@"reason":reason};
    }else if (intro.length != 0 && img.length == 0) {
        parmeters = @{@"code":code,@"intro":intro,@"reason":reason};
    }else if (intro.length == 0 && img.length == 0) {
        parmeters = @{@"code":code,@"reason":reason};
    }else{
        parmeters = @{@"code":code,@"intro":intro,@"reason":reason,@"img":img};
    }
//    NSDictionary *parmeters = @{@"code":code,@"intro":intro,@"reason":reason,@"img":img,@"money":money};
//    [APPNetworkDao getURLString:url parameters:parmeters block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
//        if ([array count] > 0) {
//            
//        }
//        
//        
//    }];
    [[APPNetworkClient sharedClient] GET:url parameters:parmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject count]) {
                int status = [[responseObject objectForKey:@"status"] intValue];
                if (status == 200) {
                    id postsFromResponse = [responseObject valueForKeyPath:@"result"];
                    if ([postsFromResponse isKindOfClass:[NSDictionary class]]) {
                        if ([postsFromResponse count]) {
                            NSLog(@"%@",[postsFromResponse objectForKey:@"msg"]);
                            if (block) {
                                block([[postsFromResponse objectForKey:@"code"] intValue],
                                      [postsFromResponse objectForKey:@"msg"]);
                            }
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"Result Data Error"];
                    }
                    //[SVProgressHUD dismiss];
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
            block( 0 , [NSString stringWithFormat:@"%@",error]);
            [SVProgressHUD showErrorWithStatus:@"服务器错误"];
            //[SVProgressHUD dismiss];
            
        }
    }];

}



@end
