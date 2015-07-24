//
//  ShareDetialDataModel.h
//  Love
//
//  Created by use on 15-3-19.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kShareCommentDataListNotificationName;
@interface ShareDetialDataModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *discussId;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;
//分享详情
+ (void)getShareDetailDataWithShareId:(NSString *)shareId block:(void(^)(NSDictionary *detailInfo))block;
//分享商品详情
+ (void)getShareProductDetailDataWithProductId:(NSString *)productId block:(void(^)(NSDictionary *detailInfo))block;

+ (void)getProductDetailDataWithProductId:(NSString *)productId tagId:(NSString *)tagId block:(void(^)(NSDictionary *detailInfo))block;

+ (void)getShareDiscussDataWithShareId:(NSString *)shareId page:(NSString *)page pnum:(NSString *)pnum;
@end
