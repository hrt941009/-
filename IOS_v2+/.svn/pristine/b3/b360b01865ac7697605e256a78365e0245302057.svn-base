//
//  FollowModel.m
//  Love
//
//  Created by lee wei on 14-7-29.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyFollowModel.h"
#import "APPNetworkDao.h"
#import "UserManager.h"

//HtFollow/followSellerList?p=1&pnum=10
static NSString * const kMyFollowURL = @"HtFollow/followSellerList";

NSString * const LoveMyFollowDataNotification = @"LoveMyLiveDataNotification";


@implementation MyFollowModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _sellerID = [attributes valueForKey:@"sellerID"];
        _header = [attributes valueForKey:@"header"];
        _flag = [attributes valueForKey:@"flag"];
        _sellerName = [attributes valueForKey:@"sellerName"];
        _sellerDescription = [attributes valueForKey:@"description"];
        _shoppingLiveTime = [attributes valueForKey:@"shoppingLiveTime"];
        _status = [attributes valueForKey:@"status"];
        _follow = [attributes valueForKey:@"follow"];
        _live = [attributes valueForKey:@"live"];
        _photos = [attributes valueForKey:@"photos"];
    }
    return self;
}

/** 关注买手
 
 @param   p 	页码
 @param   pnum 	每页条数
 @param   sig 	登录后获取
 @param   uid 	登录后获取
 
 */
+ (void)getMyFollowDataWithPage:(NSString *)p pnum:(NSString *)pnum
{
    NSString *sig = [UserManager readSig];
    NSString *uid = [UserManager readUid];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@&sig=%@&uid=%@", kMyFollowURL,p, pnum, sig, uid];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:array.count];
                              
                              for (NSDictionary *dic in array) {
                                  MyFollowModel *myFollow = [[MyFollowModel alloc] initWithAttributes:dic];
                                  [mutableArray addObject:myFollow];
                              }
                              if ([[NSArray arrayWithArray:mutableArray] count] > 0) {
                                  [[NSNotificationCenter defaultCenter] postNotificationName:LoveMyFollowDataNotification
                                                                                      object:[NSArray arrayWithArray:mutableArray]
                                                                                    userInfo:nil];
                              }
                              
                          }];
}

@end
