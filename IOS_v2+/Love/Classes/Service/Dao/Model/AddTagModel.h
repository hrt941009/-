//
//  AddTagModel.h
//  Love
//
//  Created by use on 15-3-23.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kTagDataListNotificationName;
@interface AddTagModel : NSObject
@property (nonatomic, strong) NSString *tagId;
@property (nonatomic, strong) NSString *tagName;
- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (void)getTagListData;

+ (void)createNewTagWithIntro:(NSString *)intro tagName:(NSString *)tagName block:(void(^)(int code))block;

+ (void)addTagWithTagId:(NSString *)tagId ProductId:(NSString *)productId block:(void(^)(int code, NSString *msg))block;

@end
