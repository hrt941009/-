//
//  SubjectInfoModel.m
//  Love
//
//  Created by 李伟 on 14/11/10.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SubjectInfoModel.h"
#import "APPCommissionDetailDao.h"

static NSString * const kSubjectInfoURL = @"Album/info";

@implementation SubjectInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _subjectId = @"id";
        _albumName = @"album_name";
        _albumIntro = @"intro";
        _thumbPath = @"thumb";
        _fllowNum = @"fllow";
        _discussNum = @"discuss";
        _userId = @"user_id";
        _userName = @"user_name";
        _userHeader = @"user_header";
    }
    return self;
}

/**
 
 @param   sid 	专辑id
 
 @return  block
 */
+ (void)getSubjectInfoWithId:(NSString *)sid block:(void (^)(NSDictionary *))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@?ablum=%@", kSubjectInfoURL, sid];
    [APPCommissionDetailDao getURLString:urlString
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       if ([dic count] > 0) {
                                           if (block) {
                                               block(dic);
                                           }
                                       }
                                   }];
}

@end
