//
//  SubmitOrderModel.m
//  Love
//
//  Created by use on 15-1-21.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//提交订单模型
#import "SubmitOrderModel.h"
#import "APPCommissionDetailDao.h"
#import "APPNetworkClient.h"
static NSString * const kSubmitOrderURL = @"Order/createOrder";
@implementation SubmitOrderModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _msg = [attributes objectForKey:@"msg"];
        _code = [attributes objectForKey:@"code"];
        _alipay_order_no = [attributes objectForKey:@"alipay_order_no"];
    }
    return self;
}
//code, id:num:price:recom 即 商品ID:商品数量:单价:推荐ID（recom从购物车列表和美妆师直播商品列表中获取） 若是多个商品，则用下划线分开
//msg, seller_id:msg 的形式，即 卖家ID:留言 多组用下划线分开
//invoice, 1个人 2企业
+ (void)submitOrderDataWithCode:(NSString*)code address:(NSString*)addressId Msg:(NSString *)msg baaiIcon:(NSString *)baaiIcon invoice:(NSString *)invoice cartId:(NSString *)cartId block:(void(^)(int code, NSString *msg, NSString *alipayOrderNo))block{
    NSString *url = [NSString stringWithFormat:@"%@?id=%@&address=%@&msg=%@&baai=%@&invoice=%@&cart=%@",kSubmitOrderURL,code,addressId,msg,baaiIcon,invoice,cartId];
    NSLog(@"SubmitOrderModel url = %@", url);
    [APPCommissionDetailDao getURLString:url block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        SubmitOrderModel *model = [[SubmitOrderModel alloc] initWithAttributtes:dic];
        int code = [model.code intValue];
        NSString *msg = model.msg;
        NSString *alipayCode = model.alipay_order_no;
        if (block) {
            block(code, msg, alipayCode);
        }
    }];
    
    
    
    
//    NSString *url = [NSString stringWithFormat:@"%@%@",kAPPNetworkURLHeader,kSubmitOrderURL];
//    NSDictionary *parmeters = @{@"id":code,@"address":addressId,@"baai":baaiIcon,@"invoice":invoice};
//    [[APPNetworkClient sharedClient] GET:url parameters:parmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            if ([responseObject count]) {
//                int status = [[responseObject objectForKey:@"status"] intValue];
//                if (status == 200) {
//                    id postsFromResponse = [responseObject valueForKeyPath:@"result"];
//                    if ([postsFromResponse isKindOfClass:[NSDictionary class]]) {
//                        if ([postsFromResponse count]) {
//                            NSLog(@"%@",[postsFromResponse objectForKey:@"msg"]);
//                            if (block) {
//                                block([[postsFromResponse objectForKey:@"code"] intValue],
//                                      [postsFromResponse objectForKey:@"msg"]);
//                            }
//                        }
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:@"Result Data Error"];
//                    }
//                    //[SVProgressHUD dismiss];
//                }else if(status == 610 || status == 604 || status == 404){
//                    NSString *msg = [[responseObject valueForKey:@"result"] valueForKey:@"msg"];
//                    NSLog(@"msg = %@", msg);
//                    [SVProgressHUD showErrorWithStatus:@"未找到商品"];
//                }
//                else{
//                    [SVProgressHUD showErrorWithStatus:@"未找到商品"];
//                }
//            }
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"responseObject Data Error"];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error = %@", error);
//        if([error code] == NSURLErrorCancelled)
//        {
//            //[SVProgressHUD dismiss];
//            
//            return [[[APPNetworkClient sharedClient] operationQueue] cancelAllOperations];
//        }
//        if (block) {
//            block( 0 , [NSString stringWithFormat:@"%@",error]);
//            [SVProgressHUD showErrorWithStatus:@"服务器错误"];
//            //[SVProgressHUD dismiss];
//            
//        }
//    }];

    
}
@end
