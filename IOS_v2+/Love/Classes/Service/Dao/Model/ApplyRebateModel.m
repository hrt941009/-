//
//  ApplyRebateModel.m
//  Love
//
//  Created by use on 15-1-7.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ApplyRebateModel.h"
#import "APPCommissionDetailDao.h"
static NSString * const kApplyRebateURL = @"FlItem/addReturnRecord";
@implementation ApplyRebateModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _code = [attributes objectForKey:@"code"];
        _msg = [attributes objectForKey:@"msg"];
    }
    return self;
}
+ (void)getAlipayIDLisyData:(NSString *)aliapyId name:(NSString *)name baaiIcon:(NSString *)baaiIcon money:(NSString *)money block:(void(^)(NSString *code, NSString *msg))block{
    NSString *url = [NSString stringWithFormat:@"%@?alipay=%@&name=%@&baai_money=%@&cny=%@",kApplyRebateURL,aliapyId,name,baaiIcon,money];
    [APPCommissionDetailDao getURLString:url block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        ApplyRebateModel *model = [[ApplyRebateModel alloc] initWithAttributtes:dic];
        NSString *code = model.code;
        NSString *msg = model.msg;
        if (block) {
            block(code,msg);
        }
    }];
}
@end
