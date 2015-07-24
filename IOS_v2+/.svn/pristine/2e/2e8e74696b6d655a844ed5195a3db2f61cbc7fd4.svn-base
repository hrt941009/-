//
//  FollowModel.h
//  Love
//
//  Created by lee wei on 14-7-29.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  关注买手
//

#import <Foundation/Foundation.h>

extern NSString * const LoveMyFollowDataNotification;

@interface MyFollowModel : NSObject

@property (nonatomic, strong) NSString *sellerID;         //卖家ID
@property (nonatomic, strong) NSString *header;           //商家头像URL
@property (nonatomic, strong) NSString *flag;             //国旗图标URL
@property (nonatomic, strong) NSString *sellerName;       //卖家姓名
@property (nonatomic, strong) NSString *sellerDescription;      //卖家介绍
@property (nonatomic, strong) NSString *shoppingLiveTime; //直播时间，服务端下发字串
@property (nonatomic, strong) NSString *status;           //现在状态，0，暂无直播，1，直播中，2，扫货中
@property (nonatomic, strong) NSString *follow;           //跟随者数量
@property (nonatomic, strong) NSString *live;             //直播总数
@property (nonatomic, strong) NSString *photos;           //照片数
//@property (nonatomic, strong) NSString *live;//此次shoppingShow的ID

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)getMyFollowDataWithPage:(NSString *)p pnum:(NSString *)pnum;

@end
