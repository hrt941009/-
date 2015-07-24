//
//  AfterSaleOrderListModel.m
//  Love
//
//  Created by use on 14-12-26.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "AfterSaleOrderListModel.h"
#import "APPNetworkDao.h"
NSString * const kAfterSaleOrderListNoticefationName = @"kAfterSaleOrderListNoticefationName";

static NSString * const kAfterSaleOrderListURL = @"orderList/service";
@implementation AfterSaleOrderListModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _code = [attributes objectForKey:@"code"];
        _product_name = [attributes objectForKey:@"product_name"];
        _product_thumb = [attributes objectForKey:@"product_thumb"];
        _commo_id = [attributes objectForKey:@"commo_id"];
        _product_id = [attributes objectForKey:@"product_id"];
        _commo_standard = [attributes objectForKey:@"commo_standard"];
        _price = [attributes objectForKey:@"price"];
        _rebate = [attributes objectForKey:@"rebate"];
        _num = [attributes objectForKey:@"num"];
        _status = [attributes objectForKey:@"status"];
        _create_time = [attributes objectForKey:@"create_time"];
    }
    return self;
}

+ (void)getAfterSaleOrderListWithPage:(NSString *)page pageNumber:(NSString *)pageNumber{
    NSString *url = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kAfterSaleOrderListURL,page,pageNumber];
    [APPNetworkDao getURLString:url
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      AfterSaleOrderListModel *model = [[AfterSaleOrderListModel alloc] initWithAttributtes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                            [[NSNotificationCenter defaultCenter] postNotificationName:kAfterSaleOrderListNoticefationName object:[NSArray arrayWithArray:resultArray]];
                          }];
}
@end
