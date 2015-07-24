//
//  ShareListModel.h
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

extern NSString * const kShareListNotificationName;
extern NSString * const kProductListNotificationName;

#import <Foundation/Foundation.h>

@interface ShareListModel : NSObject
//用户主页分享
@property (nonatomic, strong) NSString *shareId;//分享ID
@property (nonatomic, strong) NSString *tagName;//标签
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *shareImg;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *myTitle;
//用户主页商品
@property (nonatomic, strong) NSString *productId;//商品ID
@property (nonatomic, strong) NSString *userId;//分享商品用户ID
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *tag;//标签ID
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *stock;//库存
@property (nonatomic, strong) NSString *deleted;
@property (nonatomic, strong) NSString *ststus;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getShareListWithShareId:(NSString *)shareId page:(NSString *)page pageNumber:(NSString *)pnum;

+ (void)getProductListWithUserId:(NSString *)userId page:(NSString *)page pageNumber:(NSString *)pnum;
@end
