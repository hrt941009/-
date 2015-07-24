//
//  SearchKeyWordModel.m
//  Love
//
//  Created by use on 15-1-13.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "SearchKeyWordModel.h"
#import "APPCommissionDetailDao.h"
static NSString * const kSearchKeyWordURL = @"Search/showKeyword";
@implementation SearchKeyWordModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (void)searchKeyWordData:(NSString*)page pageNumber:(NSString*)pnum block:(void(^)(NSMutableArray *dataArray))block{
    NSString *url = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kSearchKeyWordURL,page,pnum];
    [APPCommissionDetailDao getURLString:url block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        mutableArray = [dic objectForKey:@"list"];
        if (block) {
            block(mutableArray);
        }
    }];
    
}
@end
