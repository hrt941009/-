//
//  ThirdLoginModel.m
//  Love
//
//  Created by use on 15-2-2.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ThirdLoginModel.h"
#import "APPThirdLoginDao.h"

static NSString * const kThirdLogin = @"users/otherlogin";
@implementation ThirdLoginModel

+ (void)thirdLoginWithKey:(NSString *)key Name:(NSString *)name Sex:(NSString *)sex Header:(NSString *)header block:(void(^)(int code, NSString *msg, NSString *uid, NSString *sig))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kThirdLogin];
    NSDictionary *dic = @{@"key":key, @"name":name, @"sex":sex, @"header":header};
//    NSDictionary *myDic = @{@"key":key};
    [APPThirdLoginDao postURLString:urlStr parameters:dic block:^(int code, NSString *msg, NSString *uid,NSString *sig) {
        if (block) {
            block(code,msg,uid, sig);
        }
    }];
}

+ (void)autoLoginWithKey:(NSString *)key block:(void(^)(int code, NSString *msg, NSString *uid, NSString *sig))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kThirdLogin];
    NSDictionary *myDic = @{@"key":key};
    [APPThirdLoginDao postURLString:urlStr parameters:myDic block:^(int code, NSString *msg, NSString *uid,NSString *sig) {
        if (block) {
            block(code,msg,uid, sig);
        }
    }];
}

@end
