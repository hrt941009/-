//
//  FollowMe.h
//  Love
//
//  Created by 李伟 on 14-10-16.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  添加关注、取消关注
//

#import <Foundation/Foundation.h>

//1-商品 , 3-海淘卖家 ,4-专辑，5-美妆师, 6-品牌，7-用户
typedef NS_ENUM(NSInteger, FollowModelType)
{
    FollowModelTypeWithCommission = 1,
    FollowModelTypeWithHaitao = 3,
    FollowModelTypeWithSubject = 4,
    FollowModelTypeWithDresser = 5,
    FollowModelTypeWithBrand = 6,
    FollowModelTypeWithUser = 7
};

@interface FollowMeModel : NSObject

+ (void)doFollowWithId:(NSString *)sid type:(NSInteger)ctype block:(void(^)(int code))block;


+ (void)isFollowWithID:(NSString *)sid type:(NSInteger)ctype block:(void(^)(int code))block;

+ (void)doFollowLive:(NSString *)liveId block:(void (^)(int code))block;
+ (void)cancleFollowLive:(NSString *)liveId block:(void(^)(int code))block;
@end
