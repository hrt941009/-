//
//  NotificationCenterModel.h
//  Love
//
//  Created by use on 14-12-4.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//消息中心

#import <Foundation/Foundation.h>
extern NSString * const kNotificationCenterNotificationName;
@interface NotificationCenterModel : NSObject

@property (nonatomic ,strong) NSString *comment_id; //消息id
@property (nonatomic ,strong) NSString *create_time;//创建时间
@property (nonatomic ,strong) NSDictionary *from;//评论来源
@property (nonatomic ,strong) NSString *msg;//评论内容
@property (nonatomic ,strong) NSString *msg_type;//消息类型（2专辑，1商品，3直播，0系统）
@property (nonatomic ,strong) NSString *product_id;//商品消息ID
@property (nonatomic ,strong) NSString *product_name;//商品名称
@property (nonatomic ,strong) NSString *product_thumb;//商品图片
@property (nonatomic ,strong) NSString *product_type;//商品类型
@property (nonatomic ,strong) NSDictionary *to;//消息发送对象
@property (nonatomic ,strong) NSString *album_id;//专辑消息ID
@property (nonatomic ,strong) NSString *album_name;//
@property (nonatomic ,strong) NSString *album_thum;//
@property (nonatomic ,strong) NSString *live_id;//直播消息ID
@property (nonatomic ,strong) NSString *live_name;//
@property (nonatomic ,strong) NSString *live_thumb;//
@property (nonatomic ,strong) NSString *systemId;//系统消息ID
@property (nonatomic ,strong) NSString *type; //
@property (nonatomic ,strong) NSString *content;//
@property (nonatomic, strong) NSString *productDescription;//商品简介
@property (nonatomic, strong) NSString *liveDescription;//直播简介
@property (nonatomic, strong) NSString *albumDescription;//专辑简介

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getNotificationCenterDataPage:(NSString *)page andPageNum:(NSString*)pageNum;

//删除消息
+ (void)deleteNotificationNotiId:(NSString *)notiId type:(NSString *)type block:(void(^)(int code, NSString *msg))block;

@end
