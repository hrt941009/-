//
//  CommentListModel.m
//  Love
//
//  Created by lee wei on 14-9-29.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommentListModel.h"
#import "APPNetworkDao.h"


static NSString * const kCommentListURL = @"Review/getItemReview";
static NSString * const kAlbumCommentListURL = @"Review/getAlbumReview";
static NSString * const kCommentLiveURL = @"Review/getArtistLiveReview";
NSString * const kAlbumCommentNotificationName = @"kAlbumCommentNotificationName";
NSString * const kLiveCommentNotificationName = @"kLiveCommentNotificationName";

@implementation CommentListModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _commentId = [attributes objectForKey:@"comment_id"];
        _commentCreateTime = [attributes objectForKey:@"create_time"];
        _commentMessage = [attributes objectForKey:@"msg"];
        if ([attributes objectForKey:@"to"] != NULL) {
            _toUserId = [[attributes objectForKey:@"to"] objectForKey:@"user_id"];
            _toName = [[attributes objectForKey:@"to"] objectForKey:@"name"];
            _toHeader = [[attributes objectForKey:@"to"] objectForKey:@"header"];
        }else{
            _toUserId = @"";
            _toName = @"";
            _toHeader = @"";
        }
        if ([attributes objectForKey:@"from"] != NULL) {
            _fromUserId = [[attributes objectForKey:@"from"] objectForKey:@"user_id"];
            _fromName = [[attributes objectForKey:@"from"] objectForKey:@"name"];
            _fromHeader = [[attributes objectForKey:@"from"] objectForKey:@"header"];
        }else{
            _fromUserId = @"";
            _fromName = @"";
            _fromHeader = @"";
        }
    }
    return self;
}


+ (void)getCommentWithItem:(NSString *)item page:(NSString *)page pnum:(NSString *)pnum block:(void(^)(NSArray *array))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@?item=%@&p=%@&pnum=%@", kCommentListURL, item, page, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      CommentListModel *model = [[CommentListModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  if (block) {
                                      block([NSArray arrayWithArray:mutableArray]);
                                  }
                              }
                          }];
}

+ (void)getCommentWithAlbumID:(NSString *)aid page:(NSString *)page pnum:(NSString *)pnum
{
    NSString *urlString = [NSString stringWithFormat:@"%@?album=%@&p=%@&pnum=%@", kAlbumCommentListURL, aid, page, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      CommentListModel *model = [[CommentListModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                            [[NSNotificationCenter defaultCenter] postNotificationName:kAlbumCommentNotificationName
                                                    object:resultArray];
                          }];
}

+ (void)getCommentWithLiveID:(NSString *)liveid page:(NSString *)page pnum:(NSString *)pnum{
    NSString *urlString = [NSString stringWithFormat:@"%@?live=%@&p=%@&pnum=%@", kCommentLiveURL, liveid, page, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      CommentListModel *model = [[CommentListModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kLiveCommentNotificationName
                                                                                  object:resultArray];
                          }];
}

+ (void)getCommentWithProductID:(NSString *)productId page:(NSString *)page pnum:(NSString *)pnum{
    NSString *urlString = [NSString stringWithFormat:@"%@?item=%@&p=%@&pnum=%@", kCommentListURL, productId, page, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      CommentListModel *model = [[CommentListModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kAlbumCommentNotificationName
                                                object:resultArray];
    }];

}

@end
