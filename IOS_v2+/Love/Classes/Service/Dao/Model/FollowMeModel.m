//
//  FollowMe.m
//  Love
//
//  Created by 李伟 on 14-10-16.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowMeModel.h"
#import "APPReplayNetworkDao.h"
#import "APPCommissionDetailDao.h"

///Attend/doattend?id=102&type=1
static NSString * const kFollowMeURL = @"Attend/doattend";

//Attend/isAttention?id=102&type=1
static NSString * const kisFollowURL = @"Attend/isAttention";
static NSString * const kFollowLiveURL = @"Attend/LikeArtistLives";
static NSString * const kCancleFollowLiveURL = @"Attend/delLoveLive";

@implementation FollowMeModel
/**
 添加直播关注
 
 @param  live：  直播ID
 
 @return block
 */
+ (void)doFollowLive:(NSString *)liveId block:(void (^)(int code))block{
    NSDictionary *postDic = @{@"live":liveId};
    [APPReplayNetworkDao postURLString:kFollowLiveURL parameters:postDic block:^(int code, NSString *msg) {
        NSLog(@"msg = %@",msg);
        if (block) {
            block(code);
        }
    }];

}
/*
 取消直播关注
 */

+ (void)cancleFollowLive:(NSString *)liveId block:(void(^)(int code))block{
    NSDictionary *postDic = @{@"live":liveId};
    [APPReplayNetworkDao postURLString:kCancleFollowLiveURL parameters:postDic block:^(int code, NSString *msg) {
        NSLog(@"msg = %@",msg);
        if (block) {
            block(code);
        }
    }];
}

/**
 添加关注、取消关注
 
 @param  id：  商品ID，海淘卖家ID ，专辑ID，美妆师ID，品牌ID，被关注用户ID，
 @param  type：关注类型（1-商品 , 3-海淘卖家 ,4-专辑，5-美妆师, 6-品牌，7-用户）
 
 @return block
 */
+ (void)doFollowWithId:(NSString *)sid type:(NSInteger)ctype block:(void(^)(int code))block
{
    if (sid == nil) {
        sid = @"";
    }
    NSDictionary *postDic = @{@"id": sid, @"type": [NSString stringWithFormat:@"%ld", (unsigned long)ctype]};
    [APPReplayNetworkDao postURLString:kFollowMeURL
                            parameters:postDic
                                 block:^(int code, NSString *msg) {
                                     NSLog(@"msg = %@", msg);
                                     if (block) {
                                         block(code);
                                     }
                                 }];
    
}

/**
 添加关注、取消关注
 
 @param  id：  商品ID，海淘卖家ID ，专辑ID，美妆师sID，品牌ID，被关注用户ID，
 @param  type：关注类型（1-商品 , 3-海淘卖家 ,4-专辑，5-美妆师, 6-品牌，7-用户）
 
 @return Notification
 */
+ (void)isFollowWithID:(NSString *)sid type:(NSInteger)ctype block:(void(^)(int code))block
{
    NSDictionary *postDic = @{@"id": sid, @"type": [NSString stringWithFormat:@"%ld", (unsigned long)ctype]};
    [APPReplayNetworkDao postURLString:kisFollowURL
                            parameters:postDic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code);
                                     }
                                 }];
}



@end
