//
//  LogisticsModel.m
//  Love
//
//  Created by use on 14-12-22.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "LogisticsModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"
NSString * const kLogisticeNoticefationName = @"kLogisticeNoticefationName";
static NSString * const kRebateURL = @"Express/getExpressInfo";
@implementation LogisticsModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _express_data = [attributes objectForKey:@"express_data"];
        _express_name = [attributes objectForKey:@"express_name"];
        _express_code = [attributes objectForKey:@"express_code"];
    }
    return self;
}
+ (void)getLogisticeDataCode:(NSString *)code{
    NSString *url = [NSString stringWithFormat:@"%@?code=%@",kRebateURL,code];

    [APPCommissionDetailDao getURLString:url
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       LogisticsModel *model = [[LogisticsModel alloc] initWithAttributtes:dic];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:kLogisticeNoticefationName object:model];
                                   }];
    
}
@end
