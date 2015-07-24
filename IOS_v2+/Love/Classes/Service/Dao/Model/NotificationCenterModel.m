//
//  NotificationCenterModel.m
//  Love
//
//  Created by use on 14-12-4.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "NotificationCenterModel.h"
#import "APPNetworkDao.h"
#import "APPReplayNetworkDao.h"

static NSString * const kNotificationCenterURL = @"Msg/getAllMsg";
static NSString * const kDeleteNotificationURL = @"Msg/delmsg";
NSString * const kNotificationCenterNotificationName = @"kNotificationCenterNotificationName";
@implementation NotificationCenterModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _content = [attributes objectForKey:@"content"];
        _type = [attributes objectForKey:@"type"];
        _systemId = [attributes objectForKey:@"id"];
        _live_id = [attributes objectForKey:@"live_id"];
        _live_name = [attributes objectForKey:@"live_name"];
        _live_thumb = [attributes objectForKey:@"live_thumb"];
        _album_id = [attributes objectForKey:@"album_id"];
        _album_name = [attributes objectForKey:@"album_name"];
        _album_thum = [attributes objectForKey:@"album_thumb"];
        _to = [attributes objectForKey:@"to"];
        _from = [attributes objectForKey:@"from"];
        _product_id = [attributes objectForKey:@"product_id"];
        _product_name = [attributes objectForKey:@"product_name"];
        _product_thumb = [attributes objectForKey:@"product_thumb"];
        _product_type = [attributes objectForKey:@"product_type"];
        _comment_id = [attributes objectForKey:@"comment_id"];
        _create_time = [attributes objectForKey:@"create_time"];
        _msg = [attributes objectForKey:@"msg"];
        _msg_type = [attributes objectForKey:@"msg_type"];
        _productDescription = [attributes objectForKey:@"product_description"];
        _liveDescription = [attributes objectForKey:@"live_description"];
        _albumDescription = [attributes objectForKey:@"album_description"];
        
    }
    return self;
}

+ (void)getNotificationCenterDataPage:(NSString *)page andPageNum:(NSString*)pageNum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kNotificationCenterURL,page,pageNum];
    [APPNetworkDao getURLString:urlStr
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      NotificationCenterModel *model = [[NotificationCenterModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                            [[NSNotificationCenter defaultCenter] postNotificationName: kNotificationCenterNotificationName object:[NSArray arrayWithArray:resultArray]];
    }];
}

+ (void)deleteNotificationNotiId:(NSString *)notiId type:(NSString *)type block:(void(^)(int code, NSString *msg))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%@&type=%@",kDeleteNotificationURL,notiId,type];
    [APPReplayNetworkDao postURLString:urlStr parameters:nil block:^(int code, NSString *msg) {
        block(code,msg);
    }];
}

@end
