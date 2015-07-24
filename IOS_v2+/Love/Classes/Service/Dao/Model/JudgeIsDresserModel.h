//
//  JudgeIsDresserModel.h
//  Love
//
//  Created by use on 15-1-24.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

//判断该用户是不是美妆师

#import <Foundation/Foundation.h>

@interface JudgeIsDresserModel : NSObject
- (instancetype)initWithAttributtes:(NSDictionary *)attributes;

+ (void)judgeIsDresserBlock:(void(^)(int code))block;

@end
