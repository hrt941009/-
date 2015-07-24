//
//  FollowTagProductModel.m
//  Love
//
//  Created by use on 15-4-6.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//关注标签下的商品列表
#import "FollowTagProductModel.h"
#import "APPNetworkDao.h"
static NSString * const kFollowTagProductURL = @"attend/attendTagProduct";
NSString * const kFollowTagProductNotificationName = @"kFollowTagProductNotificationName";
@implementation FollowTagProductModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _productId = [attributes valueForKey:@"id"];
        _productName = [attributes valueForKey:@"name"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _intro = [attributes valueForKey:@"intro"];
        _loveNumber = [attributes valueForKey:@"love"];
        _isLove = [attributes valueForKey:@"is_love"];
    }
    return self;
}
+ (void)getFollowTagProductListDataWithTagId:(NSString *)tagId Page:(NSString *)page Pnum:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?tag_id=%@&p=%@&pnum=%@",kFollowTagProductURL,tagId,page,pnum];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                FollowTagProductModel *model = [[FollowTagProductModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: kFollowTagProductNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}
@end
