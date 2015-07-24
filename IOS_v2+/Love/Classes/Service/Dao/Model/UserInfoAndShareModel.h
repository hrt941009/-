//
//  UserInfoAndShareModel.h
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoAndShareModel : NSObject
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) NSArray *shareList;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getUserInfoAndShareList:(NSString *)userId block:(void(^)(NSDictionary *userInfo))block;

@end
