//
//  MeTagListModel.m
//  Love
//
//  Created by use on 15-4-2.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "MeTagListModel.h"
#import "APPCommissionDetailDao.h"
#import "APPNetworkDao.h"
static NSString * const kMeTagListURL = @"UserTag/userTag";
static NSString * const kMeTagProductListURL = @"UserTag/ProductList";
NSString * const kMeTagListNotificationName = @"kMeTagListNotificationName";
NSString * const kMeTagProductListNotificationName = @"kMeTagProductListNotificationName";
@implementation MeTagListModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _tagId = [attributes valueForKey:@"id"];
        _tagName = [attributes valueForKey:@"name"];
        _tagIntro = [attributes valueForKey:@"intro"];
        _tagHeader = [attributes valueForKey:@"thumb"];
        
        _productId = [attributes valueForKey:@"product_id"];
        _productHeader = [attributes valueForKey:@"thumb"];
        _productName = [attributes valueForKey:@"name"];
        _productPrice = [attributes valueForKey:@"price"];
        _productIntro = [attributes valueForKey:@"intro"];
    }
    return self;
}

+ (void)getTagListDataWithPage:(NSString *)page PageNum:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kMeTagListURL,page,pnum];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
            NSArray *tagListArr = [NSArray arrayWithArray:[dic objectForKey:@"tag_list"]];
            NSArray *resultArray = nil;
            if ([tagListArr count] > 0) {
                NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in tagListArr) {
                    MeTagListModel *model = [[MeTagListModel alloc] initWithAttributes:dic];
                    [mutableArray addObject:model];
                }
                resultArray = [NSArray arrayWithArray:mutableArray];
            }else{
                resultArray = [NSArray array];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName: kMeTagListNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

+ (void)getTagProductListDataWith:(NSString *)tagId Page:(NSString *)page Pnum:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?tag_id=%@&p=%@&pnum=%@",kMeTagProductListURL,tagId,page,pnum];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                MeTagListModel *model = [[MeTagListModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: kMeTagProductListNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

@end
