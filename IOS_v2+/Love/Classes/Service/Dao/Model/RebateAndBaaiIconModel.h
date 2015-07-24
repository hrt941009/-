//
//  RebateAndBaaiIconModel.h
//  Love
//
//  Created by use on 14-12-10.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//返利与八爱币
//返利总值接口
#import <Foundation/Foundation.h>
extern NSString * const kRebateAndBaaiIconNoticefationName;
@interface RebateAndBaaiIconModel : NSObject
@property (nonatomic ,strong) NSString *all_return;//返利值

@property (nonatomic, strong) NSString *baai_money;//八爱币总数;

- (instancetype)initWithAttributtes:(NSDictionary *)attributes;
+ (void)getRebateAndBaaiIcon;

+ (void)getAllBaaiIconBlock:(void(^)(int baaiIconNum))block;
@end
