//
//  CommentListModel.h
//  Love
//
//  Created by lee wei on 14-9-29.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kAlbumCommentNotificationName;
extern NSString * const kLiveCommentNotificationName;

@interface CommentListModel : NSObject

@property (nonatomic, strong) NSString *commentId;//评论ID(评论时作为to_id)
@property (nonatomic, strong) NSString *commentCreateTime;
@property (nonatomic, strong) NSString *commentMessage;//评论内容
@property (nonatomic, strong) NSString *toUserId;
@property (nonatomic, strong) NSString *toName;//被回复者
@property (nonatomic, strong) NSString *toHeader;
@property (nonatomic, strong) NSString *fromUserId;
@property (nonatomic, strong) NSString *fromName; //评论者
@property (nonatomic, strong) NSString *fromHeader;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getCommentWithItem:(NSString *)item page:(NSString *)page pnum:(NSString *)pnum block:(void(^)(NSArray *array))block;
+ (void)getCommentWithAlbumID:(NSString *)aid page:(NSString *)page pnum:(NSString *)pnum;

+ (void)getCommentWithLiveID:(NSString *)liveid page:(NSString *)page pnum:(NSString *)pnum;

+ (void)getCommentWithProductID:(NSString *)productId page:(NSString *)page pnum:(NSString *)pnum;

@end
