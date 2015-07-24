//
//  SearchKeyWordModel.h
//  Love
//
//  Created by use on 15-1-13.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

//搜索标签获取

#import <Foundation/Foundation.h>

@interface SearchKeyWordModel : NSObject
- (instancetype)initWithAttributtes:(NSDictionary *)attributes;
+ (void)searchKeyWordData:(NSString*)page pageNumber:(NSString*)pnum block:(void(^)(NSMutableArray *dataArray))block;
@end
