//
//  MyLikeModel.h
//  Love
//
//  Created by use on 14-12-2.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//我的喜欢

#import <Foundation/Foundation.h>

extern NSString * const kMyLikeNotificationName;
extern NSString * const kShareLikeNotificationName;

@interface MyLikeModel : NSObject
//喜欢的商品
@property (nonatomic ,strong) NSString *commodityId;//商品ID
@property (nonatomic ,strong) NSString *name;//商品名称
@property (nonatomic ,strong) NSString *price;//商品价格
@property (nonatomic ,strong) NSString *thumb;//商品图片
@property (nonatomic ,strong) NSString *my_price;//用户购买价格
@property (nonatomic ,strong) NSString *commDescription;//商品简介

//喜欢的分享
@property (nonatomic, strong) NSString *tagName;//标签名称
@property (nonatomic, strong) NSString *shareContent;//分享内容
@property (nonatomic, strong) NSString *shareId;
@property (nonatomic, strong) NSString *header;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getMyLikeDataPage:(NSString *)page andPageNum:(NSString *)pNum;

+ (void)getShareLikeDataPage:(NSString *)page andPageNum:(NSString *)pnum;

@end
