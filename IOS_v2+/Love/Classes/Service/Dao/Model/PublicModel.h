//
//  PublicModel.h
//  Love
//
//  Created by use on 15-4-1.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kPublishTagListNotificationName;
@interface PublicModel : NSObject
@property (nonatomic, strong) NSString *tagId;
@property (nonatomic, strong) NSString *tagName;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getPublishTagList;

//tag_id 标签id	int
//title	标题（UI图上的美妆类型）
//intro	发布分享的简介
//img	分享的图片 多张用_来链接
//location	发布地点
+ (void)publicProductWithTagId:(NSString *)tagId ProductName:(NSString *)productName Intro:(NSString *)intro Stock:(NSString *)stock ImgList:(NSString *)imgList Location:(NSString *)location Price:(NSString *)price blcok:(void(^)(int code,NSString *msg))block;



//tag_id 标签id	int
//product_name	发布商品的名称
//intro	发布商品的简介
//stock	库存
//img	商品图片 多张用_来链接
//location	发布地点
//price	商品价格（元为单位）
+ (void)publicShareWithTagId:(NSString *)tagId Title:(NSString *)title Intro:(NSString *)intro ImgList:(NSString *)imgList Location:(NSString *)location block:(void(^)(int code,NSString *msg))block;

@end
