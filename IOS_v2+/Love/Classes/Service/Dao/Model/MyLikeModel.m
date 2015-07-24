//
//  MyLikeModel.m
//  Love
//
//  Created by use on 14-12-2.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "MyLikeModel.h"
#import "APPNetworkDao.h"
static NSString * const kMyLikeURL = @"Attend/itemList";
static NSString * const kShareLikeURL = @"Attend/shareList";
NSString * const kMyLikeNotificationName = @"kMyLikeNotificationName";
NSString * const kShareLikeNotificationName = @"kShareLikeNotificationName";
@implementation MyLikeModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _commodityId = [attributes objectForKey:@"id"];
        _name = [attributes objectForKey:@"name"];
        _price = [attributes objectForKey:@"price"];
        _thumb = [attributes objectForKey:@"thumb"];
        _my_price = [attributes objectForKey:@"my_price"];
        _commDescription = [attributes objectForKey:@"add_description"];
        
        _tagName = [attributes valueForKey:@"tag_name"];
        _shareContent = [attributes valueForKey:@"share_content"];
        _shareId = [attributes valueForKey:@"share_id"];
        _header = [attributes valueForKey:@"thumb"];
        
    }
    return self;
}

+ (void)getMyLikeDataPage:(NSString *)page andPageNum:(NSString *)pNum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kMyLikeURL,page,pNum];
    [APPNetworkDao getURLString:urlStr
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      MyLikeModel *model = [[MyLikeModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                            [[NSNotificationCenter defaultCenter] postNotificationName: kMyLikeNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

+ (void)getShareLikeDataPage:(NSString *)page andPageNum:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kShareLikeURL,page,pnum];
    [APPNetworkDao getURLString:urlStr
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      MyLikeModel *model = [[MyLikeModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName: kShareLikeNotificationName object:[NSArray arrayWithArray:resultArray]];
                          }];

}

@end
