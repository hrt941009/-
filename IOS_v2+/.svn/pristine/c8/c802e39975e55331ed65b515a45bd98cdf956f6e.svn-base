//
//  PutCartModel.m
//  Love
//
//  Created by lee wei on 15/1/17.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "PutCartModel.h"
#import "APPCommissionDetailDao.h"

static NSString *const kPutCartURL = @"order/cartAdd";

@implementation PutCartModel

/**
 skus页面，商品放入购物车
 
 @param  commo：sku接口中，sku的commo_id 与商品的id对应
                    commo_id" = (
                                456,
                        ）
                    "commo_list" =         {
                                "\U7070:\U5747\U7801" =  {
                                            id = 456;
                                }
                    }
 @param  num：商品数量
 @param  block：code=1 成功，code=0失败
 
 */
+ (void)putCartWithCommo:(NSString *)commo num:(NSString *)num block:(void(^)(NSString *code, NSString *msg))block
{
    [APPCommissionDetailDao getURLString:[NSString stringWithFormat:@"%@?commo=%@&num=%@", kPutCartURL, commo, num]
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       
                                       NSString *code = [dic objectForKey:@"code"];
                                       NSString *msg = [dic objectForKey:@"msg"];
                                       NSLog(@"code = %@, msg = %@", code, msg);
                                       if (error == nil) {
                                           if (block) {
                                               block(code, msg);
                                           }
                                       }else {
                                           if (block) {
                                               block(@"1", @"");
                                           }
                                       }
                                   }];
}

@end
