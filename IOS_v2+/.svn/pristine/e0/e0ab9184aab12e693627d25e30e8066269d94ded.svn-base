//
//  DresserHomePageModel.h
//  Love
//
//  Created by lee wei on 14-10-18.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kDresserHomePageNotificationName;

@interface DresserHomePageModel : NSObject

@property (nonatomic, strong) NSString *picWhRatio;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *commentNum;
@property (nonatomic, strong) NSString *dresserHeader;
@property (nonatomic, strong) NSString *liveId;
@property (nonatomic, strong) NSString *liveName;
@property (nonatomic, strong) NSString *dresserLocation;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *dresserLevel;
@property (nonatomic, strong) NSString *thumbPath;

@property (nonatomic, strong) NSString *isAttention;

@property (nonatomic, strong) UIImage *thumbImage;


- (id)initWithAttributes:(NSDictionary *)attributes;
//美妆师首页
+ (void)getDresserListPage:(NSString *)page pageNum:(NSString *)pageNum;
+ (void)getDresserListPage:(NSString *)page pageNum:(NSString *)pageNum block:(void(^)(NSArray *array))block;
//获取美妆师直播详情
+ (void)getDresserLiveDataWithLiveId:(NSString *)liveId block:(void(^)(NSDictionary *dic))block;

@end
