//
//  ReturnMoneyModel.m
//  Love
//
//  Created by use on 14-12-26.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//退款模型
#import "ReturnMoneyModel.h"
#import "APPCommissionDetailDao.h"
static NSString * const kReturnMoneyURL = @"orderList/returnMoney";
@implementation ReturnMoneyModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)getReturnMoneyDataCode:(NSString *)code intro:(NSString *)intro type:(NSString *)type image:(NSString *)img money:(NSString *)money block:(void(^)(int code, NSString *msg))block{
    NSString *url = [NSString stringWithFormat:@"%@?code=%@&intro=%@&type=%@&img=%@&money=%@",kReturnMoneyURL,code,intro,type,img,money];
    [APPCommissionDetailDao getURLString:url
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       int code = [[dic objectForKey:@"code"] intValue];
                                       NSString *msg = [dic objectForKey:@"msg"];
                                       NSLog(@"msg = %@", msg);
                                       if (block) {
                                           block(code, msg);
                                           
                                       }
                                   }];
}
@end
