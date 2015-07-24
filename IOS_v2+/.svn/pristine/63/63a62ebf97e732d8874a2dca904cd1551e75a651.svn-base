//
//  ComplainModel.m
//  Love
//
//  Created by use on 15-1-7.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ComplainModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"
NSString * const kComplainNoticefationName = @"kComplainNoticefationName";
static NSString * const kComplainURL = @"orderList/showService";
@implementation ComplainModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _date = [attributes objectForKey:@"date"];
        _service_code = [attributes objectForKey:@"service_code"];
        _service_result = [attributes objectForKey:@"service_result"];
        _service_type = [attributes objectForKey:@"service_type"];
        _money = [attributes objectForKey:@"money"];
        _img = [attributes objectForKey:@"img"];
    }
    return self;
}
+ (void)getComplainDataCode:(NSString *)code block:(void(^)(NSString *date, NSString *service_result, NSString *service_code, NSString *service_type, NSString *money, NSArray *img))block{
    NSString *url = [NSString stringWithFormat:@"%@?code=%@",kComplainURL,code];
    [APPCommissionDetailDao getURLString:url block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        ComplainModel *model = [[ComplainModel alloc] initWithAttributtes:dic];
        NSString *date = model.date;
        NSString *service_result = model.service_result;
        NSString *service_code = model.service_code;
        NSString *service_type = model.service_type;
        NSString *money = model.money;
        NSArray *img = model.img;
        if (block) {
            block(date,service_result,service_code,service_type,money,img);
        }
    }];
}

@end
