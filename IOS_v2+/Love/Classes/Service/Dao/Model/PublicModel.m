//
//  PublicModel.m
//  Love
//
//  Created by use on 15-4-1.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "PublicModel.h"
#import "APPReplayNetworkDao.h"
#import "APPNetworkDao.h"

static NSString * const kPublicProductURL = @"PublishActive/publishProduct";
static NSString * const kPublicShareURL = @"PublishActive/publishShare";
static NSString * const kTagListURL = @"PublishActive/taglist";

NSString * const kPublishTagListNotificationName = @"kPublishTagListNotificationName";

@implementation PublicModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _tagId = [attributes valueForKey:@"id"];
        _tagName = [attributes valueForKey:@"name"];
    }
    return self;
}

+ (void)getPublishTagList{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kTagListURL];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                PublicModel *model = [[PublicModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: kPublishTagListNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

+ (void)publicProductWithTagId:(NSString *)tagId ProductName:(NSString *)productName Intro:(NSString *)intro Stock:(NSString *)stock ImgList:(NSString *)imgList Location:(NSString *)location Price:(NSString *)price blcok:(void(^)(int code,NSString *msg))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kPublicProductURL];
    NSDictionary *dic = @{@"tag_id":tagId,@"product_name":productName,@"intro":intro,@"stock":stock,@"img":imgList,@"location":location,@"price":price};
    [APPReplayNetworkDao postURLString:urlStr parameters:dic block:^(int code, NSString *msg) {
        if (block) {
            block(code,msg);
        }
    }];
}

+ (void)publicShareWithTagId:(NSString *)tagId Title:(NSString *)title Intro:(NSString *)intro ImgList:(NSString *)imgList Location:(NSString *)location block:(void(^)(int code,NSString *msg))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kPublicShareURL];
    NSDictionary *dic = @{@"tag_id":tagId,@"intro":intro,@"img":imgList,@"location":location,@"title":title};
    [APPReplayNetworkDao postURLString:urlStr parameters:dic block:^(int code, NSString *msg) {
        if (block) {
            block(code,msg);
        }
    }];
}

@end
