//
//  RebateAndBaaiIconModel.m
//  Love
//
//  Created by use on 14-12-10.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "RebateAndBaaiIconModel.h"
#import "APPCommissionDetailDao.h"
NSString * const kRebateAndBaaiIconNoticefationName = @"kRebateAndBaaiIconNoticefationName";
static NSString * const kRebateURL = @"FlItem/returnCurryItem";

static NSString * const kBaaiIconNumURL = @"order/getBaai";
@implementation RebateAndBaaiIconModel

- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _all_return = [attributes objectForKey:@"all_return"];
        _baai_money = [attributes objectForKey:@"baai_money"];
    }
    return self;
}
+ (void)getRebateAndBaaiIcon{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kRebateURL];
    [APPCommissionDetailDao getURLString:urlStr
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                       RebateAndBaaiIconModel *model = [[RebateAndBaaiIconModel alloc] initWithAttributtes:dic];
                                       [mutableArray addObject:model];
                                       [[NSNotificationCenter defaultCenter] postNotificationName: kRebateAndBaaiIconNoticefationName object:[NSArray arrayWithArray:mutableArray]];
                                   }];
}

+ (void)getAllBaaiIconBlock:(void(^)(int baaiIconNum))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kBaaiIconNumURL];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        RebateAndBaaiIconModel *model = [[RebateAndBaaiIconModel alloc] initWithAttributtes:dic];
        int baaiIcon = [model.baai_money intValue];
        if (block) {
            block(baaiIcon);
        }
    }];
}

@end
