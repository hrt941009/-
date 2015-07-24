//
//  CommentReplayModel.m
//  Love
//
//  Created by lee wei on 14-9-30.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommentReplayModel.h"
#import "APPReplayNetworkDao.h"

static NSString * const kCommentReplayURL = @"Review/doProductReview";
static NSString * const kShareCommentReplayURL = @"share/doShareDiscuss";
static NSString * const kLiveCommentReplayURL = @"Review/doArtistLiveReview";
@implementation CommentReplayModel

//item
//商品ID	int
//
//to_id	回复评论ID	int 	 	 	非回复则为空
//content	回复内容	string
+ (void)postReplayWithItem:(NSString *)item
                      toId:(NSString *)toId
                   content:(NSString *)content
                     block:(void(^)(int code))block
{
    NSDictionary *postDic = @{@"item": item, @"to_id": toId, @"content": content};
    NSLog(@"postDic = %@", postDic);
    [APPReplayNetworkDao postURLString:kCommentReplayURL
                            parameters:postDic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code);
                                     }
                                 }];
}

//分享页面回复评论
+ (void)postShareReplayItemShareId:(NSString *)shareId
                           content:(NSString *)content
                             block:(void(^)(int code))block{
    NSDictionary *postDic = @{@"share": shareId, @"content": content};
    [APPReplayNetworkDao postURLString:kShareCommentReplayURL
                            parameters:postDic
                                 block:^(int code, NSString *msg) {
                                     block(code);
                                 }];
}
//直播页面回复评论
+ (void)postLiveRepalyItemLiveId:(NSString *)liveId
                         content:(NSString *)content
                           block:(void(^)(int code))block{
    NSDictionary *postDic = @{@"live":liveId,@"content":content};
    [APPReplayNetworkDao postURLString:kLiveCommentReplayURL parameters:postDic block:^(int code, NSString *msg) {
        if (block) {
            block(code);
        }
    }];
}

@end
