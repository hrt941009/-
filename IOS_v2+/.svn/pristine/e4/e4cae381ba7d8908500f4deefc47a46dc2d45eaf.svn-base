//
//  ShareDetialDataModel.m
//  Love
//
//  Created by use on 15-3-19.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareDetialDataModel.h"
#import "APPCommissionDetailDao.h"
#import "APPNetworkDao.h"
static  NSString * const kShareDetailURL = @"share/shareDetail";
static NSString * const kShareDiscussURL = @"share/getMoreDiscuss";
static NSString * const kShareProductDetailURL = @"ShareProduct/product_detail";
static NSString * const kTagShareProductURL = @"tagProduct/productDetail";
NSString * const kShareCommentDataListNotificationName = @"kShareCommentDataListNotificationName";

@implementation ShareDetialDataModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _name = [attributes valueForKey:@"name"];
        _header = [attributes valueForKey:@"header"];
        _createTime = [attributes valueForKey:@"create_time"];
        _content = [attributes valueForKey:@"content"];
        _discussId = [attributes valueForKey:@"discuss_id"];
    }
    return self;
}

+ (void)getShareDetailDataWithShareId:(NSString *)shareId block:(void(^)(NSDictionary *detailInfo))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?share=%@",kShareDetailURL,shareId];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        if (block) {
            block(dic);
        }
    }];
}

+ (void)getShareProductDetailDataWithProductId:(NSString *)productId block:(void(^)(NSDictionary *detailInfo))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%@",kShareProductDetailURL,productId];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        if (block) {
            block(dic);
        }
    }];
}

+ (void)getProductDetailDataWithProductId:(NSString *)productId tagId:(NSString *)tagId block:(void(^)(NSDictionary *detailInfo))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%@&tag_id=%@",kTagShareProductURL,productId,tagId];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        if (block) {
            block(dic);
        }
    }];
}

+ (void)getShareDiscussDataWithShareId:(NSString *)shareId page:(NSString *)page pnum:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?share=%@&p=%@&pnum=%@",kShareDiscussURL,shareId,page,pnum];
    [APPNetworkDao getURLString:urlStr
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      ShareDetialDataModel *model = [[ShareDetialDataModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName: kShareCommentDataListNotificationName object:[NSArray arrayWithArray:resultArray]];
                          }];
}

@end
