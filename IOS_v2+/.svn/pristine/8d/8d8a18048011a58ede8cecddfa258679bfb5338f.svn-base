//
//  SubjectDetailModel.h
//  Love
//
//  Created by lee wei on 14-9-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kSubjectDetailNotificationName;

@interface SubjectDetailModel : NSObject

@property (nonatomic, strong) NSString *productId; //商品ID
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productThumbPath;
@property (nonatomic, strong) NSString *productIntro;
@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *productLove; //喜欢数量
@property (nonatomic, strong) NSString *productSave; //加入专辑数量
@property (nonatomic, strong) NSString *productDiscuss; //评论数

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getSubjectAlbum:(NSString *)album p:(NSString *)p pnum:(NSString *)pnum;

@end
