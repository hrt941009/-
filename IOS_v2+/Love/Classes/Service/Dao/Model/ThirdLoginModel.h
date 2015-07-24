//
//  ThirdLoginModel.h
//  Love
//
//  Created by use on 15-2-2.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdLoginModel : NSObject

+ (void)thirdLoginWithKey:(NSString *)key Name:(NSString *)name Sex:(NSString *)sex Header:(NSString *)header block:(void(^)(int code, NSString *msg, NSString *uid, NSString *sig))block;

+ (void)autoLoginWithKey:(NSString *)key block:(void(^)(int code, NSString *msg, NSString *uid, NSString *sig))block;


@end
