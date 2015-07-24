//
//  APPUploadFileDao.h
//  Love
//
//  Created by 李伟 on 14/12/22.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//  文件上传
//

#import <Foundation/Foundation.h>

@class APPNetworkClient;
@interface APPUploadFileDao : NSObject

- (instancetype)init;
- (NSString *)generateBoundaryString;

+ (void)uploadImage:(UIImage *)image
          imageName:(NSString *)imageName
             parmas:(NSDictionary *)params
             urlStr:(NSString *)urlString
              block:(void (^)(NSDictionary *dic, NSError *error))block;

@end
