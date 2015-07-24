//
//  SubjectModel.h
//  Love
//
//  Created by lee wei on 14-9-21.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kSubjectHomeNotificationName;
extern NSString * const kFollowTagNotificationName;
@interface SubjectModel : NSObject

@property (nonatomic, strong) NSString *sid;         //专辑ID
@property (nonatomic, strong) NSString *albumName;   //专辑名称
@property (nonatomic, strong) NSString *subjectDesc; //专辑介绍
//@property (nonatomic, strong) NSString *thumbPath;   //专辑封面图片

@property (nonatomic, strong) NSString *tagid;//标签ID
@property (nonatomic, strong) NSString *love;//喜欢数量
@property (nonatomic, strong) NSString *name;//标签名
@property (nonatomic, strong) NSString *thumbPath;//标签图片
@property (nonatomic, strong) NSString *isAttent;//是否关注

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getSubjectWithP:(NSString *)p pnum:(NSString *)pnum;

+ (void)addSubjectWithName:(NSString *)name desc:(NSString *)desc thumb:(NSString *)thumb block:(void(^)(int code))block;

+ (void)albumAddSubjectWithItem:(NSString *)itemID andAlbum:(NSString *)albumID block:(void(^)(int code))block;

+ (void)followTagWithPage:(NSString *)page Pnum:(NSString *)pnum;

@end
