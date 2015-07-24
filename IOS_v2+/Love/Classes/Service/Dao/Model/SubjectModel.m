//
//  SubjectModel.m
//  Love
//
//  Created by lee wei on 14-9-21.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SubjectModel.h"
#import "APPNetworkDao.h"
#import "APPReplayNetWorkDao.h"
#import "SVProgressHUD.h"
#import "APPCommissionDetailDao.h"

static NSString * const kTagHomeURL = @"tag/showtag";
static NSString * const kAddSubjectURL = @"Album/createAblum";
static NSString * const kAlbumAddSubjectURL = @"Album/addItem";
static NSString * const kFollowTagURL = @"attend/tagList";

NSString * const kSubjectHomeNotificationName = @"kSubjectHomeNotificationName";

NSString * const kFollowTagNotificationName = @"kFollowTagNotificationName";

@implementation SubjectModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _tagid = [attributes valueForKey:@"id"];
        _love = [attributes valueForKey:@"love"];
        _name = [attributes valueForKey:@"name"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _isAttent = [attributes valueForKey:@"is_attent"];
    }
    return self;
}

/**
 
 @param   p 	页码
 @param   pnum 	每页条数
 
 @return  block
 */
+ (void)getSubjectWithP:(NSString *)p pnum:(NSString *)pnum
{
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@", kTagHomeURL, p, pnum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                         NSArray *resultArray = nil;
                         if ([array count] > 0) {
                             NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                             for (NSDictionary *dic in array) {
                                 SubjectModel *model = [[SubjectModel alloc] initWithAttributes:dic];
                                 [mutableArray addObject:model];
                             }
                             resultArray = [NSArray arrayWithArray:mutableArray];
                         }else{
                             resultArray = [NSArray array];
                         }
                         [[NSNotificationCenter defaultCenter] postNotificationName:kSubjectHomeNotificationName
                                                                             object:resultArray
                                                                           userInfo:nil];
                     }];
}

+ (void)addSubjectWithName:(NSString *)name desc:(NSString *)desc thumb:(NSString *)thumb block:(void(^)(int code))block
{
    NSDictionary *postDic = @{@"name": name, @"description": desc, @"thumb": thumb};
    
    [APPReplayNetworkDao postURLString:kAddSubjectURL
                            parameters:postDic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code);
                                     }
                                 }];
}

+ (void)albumAddSubjectWithItem:(NSString *)itemID andAlbum:(NSString *)albumID block:(void(^)(int code))block{
    NSDictionary *postDic = @{@"item": itemID, @"album": albumID};
    [APPReplayNetworkDao postURLString:kAlbumAddSubjectURL
                            parameters:postDic
                                 block:^(int code, NSString *msg) {
                                     if (block) {
                                         block(code);
                                     }
                                 }];
}

+ (void)followTagWithPage:(NSString *)page Pnum:(NSString *)pnum{
    NSString *urlStr = [NSString stringWithFormat:@"%@?p=%@&pnum=%@",kFollowTagURL,page,pnum];
    [APPNetworkDao getURLString:urlStr
                     parameters:nil block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                         NSArray *resultArray = nil;
                         if ([array count] > 0) {
                             NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                             for (NSDictionary *dic in array) {
                                 SubjectModel *model = [[SubjectModel alloc] initWithAttributes:dic];
                                 [mutableArray addObject:model];
                             }
                             resultArray = [NSArray arrayWithArray:mutableArray];
                         }else{
                             resultArray = [NSArray array];
                         }
                         [[NSNotificationCenter defaultCenter] postNotificationName:kFollowTagNotificationName
                                                                             object:resultArray
                                                                           userInfo:nil];
                     }];

}

@end
