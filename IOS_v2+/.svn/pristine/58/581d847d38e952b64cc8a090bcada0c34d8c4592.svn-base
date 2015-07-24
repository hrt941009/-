//
//  ShareLabelListModel.m
//  Love
//
//  Created by use on 15-3-17.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareLabelListModel.h"
#import "APPNetworkDao.h"
static  NSString * const kShareLabelListURL = @"tag/tagShare";
NSString * const kShareLabelListNotificationName = @"kShareLabelListNotificationName";
@implementation ShareLabelListModel
- (instancetype)initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        _share_title = [attributes valueForKey:@"share_title"];
        _share_content = [attributes valueForKey:@"share_content"];
        _share_img = [attributes valueForKey:@"share_img"];
        _sex = [attributes valueForKey:@"sex"];
        _name = [attributes valueForKey:@"name"];
        _user_id = [attributes valueForKey:@"user_id"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _love = [attributes valueForKey:@"love"];
        _shareId = [attributes valueForKey:@"share_id"];
        _isLove = [attributes valueForKey:@"is_love"];
    }
    return self;
}

+ (void)getShareLabelListWithTagId:(NSString *)tagId page:(NSString *)page pageNumber:(NSString *)pnum{
    NSString *urlString = [NSString stringWithFormat:@"%@?tag_id=%@&p=%@&pnum=%@", kShareLabelListURL,tagId,page, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      ShareLabelListModel *model = [[ShareLabelListModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName: kShareLabelListNotificationName object:[NSArray arrayWithArray:resultArray]];
                          }];
}

@end
