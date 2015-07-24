//
//  SubjectDetailModel.m
//  Love
//
//  Created by lee wei on 14-9-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SubjectDetailModel.h"
#import "APPNetworkDao.h"

NSString * const kSubjectDetailNotificationName = @"kSubjectDetailNotificationName";
static NSString * const kSubjectDetailURL = @"Album/itemList";

@implementation SubjectDetailModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _productId = [attributes valueForKey:@"product_id"];
        _productName = [attributes valueForKey:@"product_name"];
        _productIntro = [attributes valueForKey:@"intro"];
        _productPrice = [attributes valueForKey:@"price"];
        _productThumbPath = [attributes valueForKey:@"thumb"];
        _productSave = [attributes valueForKey:@"save"];
        _productDiscuss = [attributes valueForKey:@"discuss"];
        _productLove = [attributes valueForKey:@"love"];
    }
    return self;
}


/**
 @param   album 专辑ID
 @param   p 	页码
 @param   pnum 	每页条数
 
 @return  block
 */
+ (void)getSubjectAlbum:(NSString *)album p:(NSString *)p pnum:(NSString *)pnum
{
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&album=%@", kSubjectDetailURL, p, pnum, album];
    [APPNetworkDao getURLString:urlString
                     parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                         NSArray *resultArray = nil;
                         if ([array count] > 0) {
                             NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                             for (NSDictionary *dic in array) {
                                 SubjectDetailModel *model = [[SubjectDetailModel alloc] initWithAttributes:dic];
                                 [mutableArray addObject:model];
                             }
                             resultArray = [NSArray arrayWithArray:mutableArray];
                         }else{
                             resultArray = [NSArray array];
                         }
                         [[NSNotificationCenter defaultCenter] postNotificationName:kSubjectDetailNotificationName
                                                                             object:resultArray
                                                                           userInfo:nil];
                     }];
}

@end
