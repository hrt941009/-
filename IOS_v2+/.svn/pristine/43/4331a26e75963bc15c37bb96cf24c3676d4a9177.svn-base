//
//  APPUploadFileDao.m
//  Love
//
//  Created by 李伟 on 14/12/22.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "APPUploadFileDao.h"
#import "APPNetworkClient.h"
#import "UserManager.h"

@implementation APPUploadFileDao

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 生成Boundary
 
 */
- (NSString *)generateBoundaryString
{
    CFUUIDRef       uuid;
    CFStringRef     uuidStr;
    NSString *      result;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSString stringWithFormat:@"Boundary-%@", uuidStr];
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}


/**
 上传图片
 
 @param  image：      需要上传的图片
 @param  imageName：  图片名字，为空则系统自动创建名称
 @param  parmas：     表单中需要加入的参数
 @param  bolck：      返回的结果

 */
+ (void)uploadImage:(UIImage *)image
          imageName:(NSString *)imageName
             parmas:(NSDictionary *)params
             urlStr:(NSString *)urlString
              block:(void (^)(NSDictionary *dic, NSError *error))block
{
    // @"http://112.124.27.233/ht/index.php/home/AppCheck/imgUp";
    // image name
//    NSString *urlString = [NSString stringWithFormat:@"%@AppCheck/imgUp",[APPNetworkClient lovRequestURL]];
    NSString *fileName = nil;
    if ([imageName length] ==  0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        fileName = [NSString stringWithFormat:@"ios_upload_image_%@.jpg", dateString];
    }else{
        fileName = [NSString stringWithFormat:@"%@.jpg", imageName];
    }


    //request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    //Create boundary
    APPUploadFileDao *uploadFileDao = [[APPUploadFileDao alloc] init];
    NSString *boundary = [uploadFileDao generateBoundaryString];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    

    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    
    NSString *fileParamConstant = @"filedata"; //此字段和服务器相对应
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);

    
    // add params  表单中的参数
    if ([params count] > 0) {
        for (int i = 0; i < [params count]; i++) {
            NSString *param = [[params allKeys] objectAtIndex:i];
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }

    //multipart form
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileParamConstant, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // body  the post to the request
    [request setHTTPBody:body];
    
    // 设置 URL
    [request setURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                               if (error == nil) {
                                   NSDictionary *resultDic = (NSDictionary *)jsonObject;
                                   NSLog(@"upload result = %@", resultDic);
                                   if (block) {
                                       block(resultDic, nil);
                                   }
                               }else {
                                   if (block) {
                                       block(@{}, error);
                                       NSLog(@"upload error = %@", error);
                                   }
                               }
                           }];

    
}

@end
