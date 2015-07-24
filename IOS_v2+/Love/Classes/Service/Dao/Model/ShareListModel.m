//
//  ShareListModel.m
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareListModel.h"
#import "APPNetworkDao.h"
static  NSString * const kShareListURL = @"tag/userHomeShare";
static NSString * const kProductListURL = @"tag/userHomeProduct";
NSString * const kShareListNotificationName = @"kShareListNotificationName";
NSString * const kProductListNotificationName = @"kProductListNotificationName";
@implementation ShareListModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _shareId = [attributes valueForKey:@"share_id"];
        _tagName = [attributes valueForKey:@"tag_name"];
        _content = [attributes valueForKey:@"content"];
        _shareImg = [attributes valueForKey:@"share_img"];
        _location = [attributes valueForKey:@"location"];
        _createTime = [attributes valueForKey:@"create_time"];
        _thumb = [attributes valueForKey:@"thumb"];
        _myTitle = [attributes valueForKey:@"title"];
        
        _productId = [attributes valueForKey:@"id"];
        _userId = [attributes valueForKey:@"user_id"];
        _productName = [attributes valueForKey:@"product_name"];
        _intro = [attributes valueForKey:@"intro"];
        _tag = [attributes valueForKey:@"tag"];
        _price = [attributes valueForKey:@"price"];
        _stock = [attributes valueForKey:@"stock"];
        _deleted = [attributes valueForKey:@"deleted"];
        _ststus = [attributes valueForKey:@"status"];
    }
    return self;
}

+ (void)getShareListWithShareId:(NSString *)shareId page:(NSString *)page pageNumber:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?user_id=%@&p=%@&pnum=%@",kShareListURL,shareId,page,pnum];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                ShareListModel *model = [[ShareListModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: kShareListNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

+ (void)getProductListWithUserId:(NSString *)userId page:(NSString *)page pageNumber:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?user_id=%@&p=%@&pnum=%@",kProductListURL,userId,page,pnum];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                ShareListModel *model = [[ShareListModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: kProductListNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

@end
