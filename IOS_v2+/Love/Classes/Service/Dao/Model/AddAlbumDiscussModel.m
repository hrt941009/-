//
//  AddAlbumDiscussModel.m
//  Love
//
//  Created by use on 15-1-26.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "AddAlbumDiscussModel.h"
#import "APPReplayNetworkDao.h"
#import "APPNetworkDao.h"

static NSString * const kAddAlbumDiscussURL = @"Review/doAlbumReview";
static NSString * const kAddLiveCommentURL = @"Review/doArtistLiveReview";
@implementation AddAlbumDiscussModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)addAlbumDiscussAlbum:(NSString *)code To_id:(NSString *)toId Content:(NSString *)content Block:(void(^)(int code, NSString *msg))block{
//    NSString *urlStr = [NSString stringWithFormat:@"%@?album=%@&to_id=%@&content=%@",kAddAlbumDiscussURL,code,toId,content];
//    NSString *urlStr = [NSString stringWithFormat:@"%@",kAddAlbumDiscussURL];
    NSDictionary *dic = nil;
    if (toId.length == 0) {
        dic = @{@"album":code, @"content":content};
    }else{
        dic = @{@"album":code, @"to_id":toId, @"content":content};
    }
    [APPReplayNetworkDao postURLString:kAddAlbumDiscussURL parameters:dic block:^(int code, NSString *msg) {
        if (block) {
            block(code,msg);
        }
    }];
}

+ (void)addLiveCommentLive:(NSString *)liveID To_id:(NSString *)toId Content:(NSString *)content Block:(void(^)(int code, NSString *msg))block{
    NSDictionary *dic = nil;
    if (toId.length == 0) {
        dic = @{@"live":liveID, @"content":content};
    }else{
        dic = @{@"live":liveID, @"to_id":toId, @"content":content};
    }
    [APPReplayNetworkDao postURLString:kAddLiveCommentURL parameters:dic block:^(int code, NSString *msg) {
        if (block) {
            block(code,msg);
        }
    }];
}

@end
