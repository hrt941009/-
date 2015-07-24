//
//  MySubjectModel.h
//  Love
//
//  Created by lee wei on 14/10/22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  用户专辑列表
//

#import <Foundation/Foundation.h>

extern NSString * const kMySubjectNotificationName;

@interface MySubjectModel : NSObject

@property (nonatomic, strong) NSString *subjectID;//专辑ID
@property (nonatomic, strong) NSString *subjectName;//专辑名字
@property (nonatomic, strong) NSString *thumbPath; //专辑缩略图
@property (nonatomic, strong) NSString *fllowNum;   //关注数
@property (nonatomic, strong) NSString *discussNum;//评论数
@property (nonatomic, strong) NSString *intro;//专辑简介

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getMySubjectListWithUserID:(NSString *)userID page:(NSString *)p pageNumber:(NSString *)pNum;

+ (void)deleteSubjectWithSubjectID:(NSString *)subjectID block:(void(^)(int code, NSString *msg))block;

@end
