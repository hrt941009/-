//
//  uploadImageModel.h
//  Love
//
//  Created by use on 14-12-22.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//个人信息--上传头像

#import <Foundation/Foundation.h>

@interface UploadImageModel : NSObject

- (instancetype)initWithAttributtes:(NSDictionary *)attributes;

+ (void)uploadHeaderImage:(UIImage *)image imageName:(NSString *)imageName
                   parmas:(NSDictionary *)params block:(void(^)(int code, NSString *msg))block;

@end
