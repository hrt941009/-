//
//  JudgeIsDresserModel.m
//  Love
//
//  Created by use on 15-1-24.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "JudgeIsDresserModel.h"
#import "APPReplayNetworkDao.h"
#import "UserManager.h"
static NSString * const kJudgeIsDresserURL = @"ZaCenter/isZaSeller";
@implementation JudgeIsDresserModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)judgeIsDresserBlock:(void(^)(int code))block{
//    NSString *uid = [UserManager readUid];
    NSString *url = [NSString stringWithFormat:@"%@",kJudgeIsDresserURL];
    [APPReplayNetworkDao postURLString:url parameters:nil block:^(int code, NSString *msg) {
        block(code);
    }];
    
}

@end
