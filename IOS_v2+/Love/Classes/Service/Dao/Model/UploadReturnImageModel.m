//
//  UploadReturnImageModel.m
//  Love
//
//  Created by use on 14-12-24.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//上传退款和退货图片
#import "UploadReturnImageModel.h"
#import "APPUploadFileDao.h"
#import "APPNetworkClient.h"
@implementation UploadReturnImageModel
- (instancetype)initWithAttributtes:(NSDictionary *)attributes{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)uploadReturnImage:(UIImage *)image imageName:(NSString *)imageName
                   parmas:(NSDictionary *)params block:(void(^)(int code, NSString *msg))block{
    NSString *urlString = [NSString stringWithFormat:@"%@AppCheck/imgtest",[APPNetworkClient lovRequestURL]];
    [APPUploadFileDao uploadImage:image
                        imageName:imageName
                           parmas:params
                           urlStr:urlString
                            block:^(NSDictionary *dic, NSError *error) {
                                int status = [[dic objectForKey:@"status"] intValue];
                                if (status == 200) {
                                    id postsFromResponse = [dic valueForKeyPath:@"result"];
                                    if ([postsFromResponse isKindOfClass:[NSDictionary class]]) {
                                        if ([postsFromResponse count]) {
                                            int code = [[postsFromResponse objectForKey:@"code"] intValue];
                                            NSString *msg = [postsFromResponse objectForKey:@"msg"];
                                            NSLog(@"msg = %@", msg);
                                            if (block) {
                                                block(code, msg);
                                                
                                            }
                                        }
                                    }
                                }else{
                                    NSLog(@"%@",error);
                                }
                            }];
}

@end
