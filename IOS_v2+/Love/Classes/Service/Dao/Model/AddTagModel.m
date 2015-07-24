//
//  AddTagModel.m
//  Love
//
//  Created by use on 15-3-23.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "AddTagModel.h"
#import "APPNetworkDao.h"
#import "APPReplayNetworkDao.h"
static NSString * const kTagListURL = @"ShareProduct/taglist";
static NSString * const kCreateNewTagURL = @"UserTag/createTag";
static NSString * const kAddTagURL = @"ShareProduct/addProduct";
NSString * const kTagDataListNotificationName = @"kTagDataListNotificationName";
@implementation AddTagModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _tagId = [attributes valueForKey:@"id"];
        _tagName = [attributes valueForKey:@"name"];
    }
    return self;
}

+ (void)getTagListData{
    NSString *urlStr = [NSString stringWithFormat:@"%@",kTagListURL];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                AddTagModel *model = [[AddTagModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: kTagDataListNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

//+ (void)createNewTagWithType:(NSString *)type tagName:(NSString *)tagName productId:(NSString *)productId block:(void(^)(int code))block{
//    NSString *urlStr = [NSString stringWithFormat:@"%@?type=%@&tag_name=%@&product_id=%@",kCreateNewTagURL,type,tagName,productId];
//    [APPReplayNetworkDao postURLString:urlStr parameters:nil block:^(int code, NSString *msg) {
//        if (block) {
//            block(code);
//        }
//    }];
//}

+ (void)createNewTagWithIntro:(NSString *)intro tagName:(NSString *)tagName block:(void(^)(int code))block{
    NSDictionary *dic = @{@"intro":intro, @"tag_name":tagName};
    NSString *urlStr = [NSString stringWithFormat:@"%@",kCreateNewTagURL];
    [APPReplayNetworkDao postURLString:urlStr parameters:dic block:^(int code, NSString *msg) {
        if (block) {
            block(code);
        }
    }];
}

+ (void)addTagWithTagId:(NSString *)tagId ProductId:(NSString *)productId block:(void(^)(int code, NSString *msg))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?tag_id=%@&product_id=%@",kAddTagURL,tagId,productId];
    [APPReplayNetworkDao postURLString:urlStr parameters:nil block:^(int code, NSString *msg) {
        if (block) {
            block(code,msg);
        }
    }];
}

@end
