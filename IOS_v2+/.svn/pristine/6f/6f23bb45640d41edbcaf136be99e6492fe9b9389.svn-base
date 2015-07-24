//
//  MySubjectModel.m
//  Love
//
//  Created by lee wei on 14/10/22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MySubjectModel.h"
#import "APPNetworkDao.h"
#import "APPCommissionDetailDao.h"

static NSString * const kMySubjectListURL = @"Album/UserAlbumlists";
static NSString * const kDeleteSubjectUrl = @"Album/delAblum";
NSString * const kMySubjectNotificationName = @"kMySubjectNotificationName";

@implementation MySubjectModel

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        _subjectID = [attributes valueForKey:@"id"];
        _subjectName = [attributes valueForKey:@"album_name"];
        _thumbPath = [attributes valueForKey:@"thumb"];
        _fllowNum = [attributes valueForKey:@"fllow"];
        _discussNum = [attributes valueForKey:@"discuss"];
        _intro = [attributes valueForKey:@"intro"];
    }
    return self;
}

/** 获取用户专辑列表
 
 @param   p 	页码
 @param   pnum 	每页条数
 @param   userID 	用户ID
 
 */
+ (void)getMySubjectListWithUserID:(NSString *)userID page:(NSString *)p pageNumber:(NSString *)pNum
{
    [APPNetworkDao getURLString:[NSString stringWithFormat:@"%@?user=%@&p=%@&pnum=%@", kMySubjectListURL, userID, p, pNum]
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSArray *resultArray = nil;
                              if ([array count] > 0) {
                                  NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                  for (NSDictionary *dic in array) {
                                      MySubjectModel *model = [[MySubjectModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                  }
                                  resultArray = [NSArray arrayWithArray:mutableArray];
                              }else{
                                  resultArray = [NSArray array];
                              }
                            [[NSNotificationCenter defaultCenter] postNotificationName:kMySubjectNotificationName
                                                                                      object:[NSArray arrayWithArray:resultArray]
                                                                                    userInfo:nil];
                          }];
}
/** 删除用户专辑
 
 @param   subjectID 	专辑ID
 
 */

+ (void)deleteSubjectWithSubjectID:(NSString *)subjectID block:(void(^)(int code, NSString *msg))block{
    NSString *url = [NSString stringWithFormat:@"%@?album=%@",kDeleteSubjectUrl,subjectID];
    [APPCommissionDetailDao getURLString:url block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        int code = [[dic objectForKey:@"code"] intValue];
        NSString *msg = [dic objectForKey:@"msg"];
        if (block) {
            block(code,msg);
        }
    }];
}

@end
