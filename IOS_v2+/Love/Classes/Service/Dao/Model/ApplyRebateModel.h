//
//  ApplyRebateModel.h
//  Love
//
//  Created by use on 15-1-7.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

//支付宝常用账号信息获取

#import <Foundation/Foundation.h>

@interface ApplyRebateModel : NSObject
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *msg;

- (instancetype)initWithAttributtes:(NSDictionary *)attributes;
+ (void)getAlipayIDLisyData:(NSString *)aliapyId name:(NSString *)name baaiIcon:(NSString *)baaiIcon money:(NSString *)money block:(void(^)(NSString *code, NSString *msg))block;
@end
