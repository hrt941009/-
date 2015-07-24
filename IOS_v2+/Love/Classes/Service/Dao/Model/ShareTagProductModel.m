//
//  ShareTagProductModel.m
//  Love
//
//  Created by use on 15-3-26.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareTagProductModel.h"
#import "APPNetworkDao.h"

static NSString * const kShareTagProductURL = @"IndexShare/tagproduct";
NSString * const kShareTagProductDataListNotificationName = @"kShareTagProductDataListNotificationName";
@implementation ShareTagProductModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _productId = [attributes valueForKey:@"id"];
        _productName = [attributes valueForKey:@"name"];
        _thumb = [attributes valueForKey:@"thumb"];
        _location = [attributes valueForKey:@"location"];
        _intro = [attributes valueForKey:@"intro"];
        _createTime = [attributes valueForKey:@"create_time"];
    }
    return self;
}

+ (void)getShareTagProductDataListWithPage:(NSString *)page pageNum:(NSString *)pageNum tagId:(NSString *)tagId{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&tag_id=%@",kShareTagProductURL,page,pageNum,tagId];
    [APPNetworkDao getURLString:urlStr parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
        NSArray *resultArray = nil;
        if ([array count] > 0) {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                ShareTagProductModel *model = [[ShareTagProductModel alloc] initWithAttributes:dic];
                [mutableArray addObject:model];
            }
            resultArray = [NSArray arrayWithArray:mutableArray];
        }else{
            resultArray = [NSArray array];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName: kShareTagProductDataListNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

@end
