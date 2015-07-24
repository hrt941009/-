//
//  SettingModel.m
//  Love
//
//  Created by use on 15-1-5.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "SettingModel.h"
#import "APPCommissionDetailDao.h"
#import "APPReplayNetworkDao.h"
static NSString * const kFeedBackURL = @"Opinion/upView";
@implementation SettingModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)getFeedBackDataString:(NSString *)string
                      contact:(NSString *)contact
                        block:(void(^)(int code, NSString *msg))block{
    NSDictionary *dic = @{@"view":string, @"contact":contact};
    NSString *url = [NSString stringWithFormat:@"%@",kFeedBackURL];
    [APPReplayNetworkDao postURLString:url parameters:dic block:^(int code, NSString *msg) {
        if (block) {
            block(code,msg);
        }
    }];
}
@end
