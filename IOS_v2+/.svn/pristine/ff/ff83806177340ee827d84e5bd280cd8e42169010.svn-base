//
//  SubjectInfoModel.h
//  Love
//
//  Created by 李伟 on 14/11/10.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  单个专辑信息
//

#import <UIKit/UIKit.h>

@interface SubjectInfoModel : NSObject

@property (nonatomic, strong) NSString *subjectId;//"96",
@property (nonatomic, strong) NSString *albumName;//专辑名字
@property (nonatomic, strong) NSString *albumIntro;//专辑介绍
@property (nonatomic, strong) NSString *thumbPath;//专辑缩略图
@property (nonatomic, strong) NSString *fllowNum;//关注数
@property (nonatomic, strong) NSString *discussNum;// 评论数
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userHeader;

- (instancetype)init;

+ (void)getSubjectInfoWithId:(NSString *)sid block:(void(^)(NSDictionary *dic))block;

@end
