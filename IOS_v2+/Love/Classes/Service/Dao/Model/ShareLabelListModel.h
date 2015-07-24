//
//  ShareLabelListModel.h
//  Love
//
//  Created by use on 15-3-17.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
// 二期接口

//标签内的分享页列表

#import <Foundation/Foundation.h>

extern NSString * const kShareLabelListNotificationName;

@interface ShareLabelListModel : NSObject
@property (nonatomic, strong) NSString *share_title;//标题
@property (nonatomic, strong) NSString *share_content;//简介
@property (nonatomic, strong) NSArray *share_img;//分享的图片
@property (nonatomic, strong) NSString *sex;//0为女，1为男
@property (nonatomic, strong) NSString *name;//用户名
@property (nonatomic, strong) NSString *user_id;//用户id
@property (nonatomic, strong) NSString *thumbPath;//显示图
@property (nonatomic, strong) NSString *love;//喜欢数
@property (nonatomic, strong) NSString *shareId;//分享主页ID
@property (nonatomic, strong) NSString *isLove;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getShareLabelListWithTagId:(NSString *)tagId page:(NSString *)page pageNumber:(NSString *)pnum;

@end
