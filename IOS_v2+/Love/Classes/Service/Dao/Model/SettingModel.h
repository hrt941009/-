//
//  SettingModel.h
//  Love
//
//  Created by use on 15-1-5.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//我-设置-数据模型
#import <Foundation/Foundation.h>

@interface SettingModel : NSObject
- (instancetype)initWithAttributtes:(NSDictionary *)attributes;

+ (void)getFeedBackDataString:(NSString *)string
                      contact:(NSString *)contact
                        block:(void(^)(int code, NSString *msg))block;
@end
