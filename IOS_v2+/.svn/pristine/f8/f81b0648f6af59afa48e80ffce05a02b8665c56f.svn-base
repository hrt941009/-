//
//  CommentReplayModel.h
//  Love
//
//  Created by lee wei on 14-9-30.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentReplayModel : NSObject

+ (void)postReplayWithItem:(NSString *)item
                      toId:(NSString *)toId
                   content:(NSString *)content
                     block:(void(^)(int code))block;
+ (void)postShareReplayItemShareId:(NSString *)shareId
                           content:(NSString *)content
                             block:(void(^)(int code))block;

+ (void)postLiveRepalyItemLiveId:(NSString *)liveId
                         content:(NSString *)content
                           block:(void(^)(int code))block;
@end
