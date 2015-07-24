//
//  APPReleaseNoteDownload.m
//  Love
//
//  Created by lee wei on 14/12/26.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "APPReleaseNoteDownload.h"

//@"https://itunes.apple.com/cn/app/qq/id444934666?mt=8"

static NSString * const kDownloadOperationSearchURL = @"http://itunes.apple.com/lookup";

@implementation APPReleaseNoteDownload

/**
 app 升级提示, app store上的app version和本地的version对比，如果不同，就提示升级。
 
 @param  appIdentifier：app id，app创建发布后能够获得
 @param  block：获取到的数据
 
 @block  update = YES：升级，NO：不升级；releaseNotes = 新版说明
 */
+ (void)extractReleaseNoteWithIdentifier:(NSString *)appIdentifier
                                   block:(void(^)(BOOL update, NSString *releaseNotes))block
{
    NSString *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
    
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@&country=%@", kDownloadOperationSearchURL, appIdentifier, countryCode]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.f];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               //NSLog(@"APPReleaseNoteDownload data = %@", data);
                               NSError *error = nil;
                               if (data != NULL) {
                                   id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                   if (error != NULL) {
                                       //NSLog(@"jsonObject = %@", jsonObject);
                                       NSString *releaseNotesText = nil;
                                       NSString *releaseVersionText = nil;
                                       BOOL update;
                                       
                                       if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                                           id resultArray = jsonObject[@"results"];
                                           if ([resultArray count] > 0) {
                                               if ([resultArray isKindOfClass:[NSArray class]]) {
                                                   id resultDic = resultArray[0];
                                                   if ([resultDic isKindOfClass:[NSDictionary class]]) {
                                                       if (resultDic != nil) {
                                                           id releaseNotes = resultDic[@"releaseNotes"];
                                                           id releaseVersion = resultDic[@"version"];
                                                           if ([releaseNotes isKindOfClass:[NSString class]]) {
                                                               releaseNotesText = (NSString *)releaseNotes;
                                                           }
                                                           if ([releaseVersion isKindOfClass:[NSString class]]) {
                                                               releaseVersionText = (NSString *)releaseVersion;
                                                           }
                                                           NSLog(@"APPReleaseNoteDownload appVersion = %@ | releaseVersionText = %@", appVersion, releaseVersionText);
                                                           if ([appVersion isEqualToString:releaseVersionText]) {
                                                               update = NO;
                                                           }else{
                                                               update = YES;
                                                           }
                                                           if (block) {
                                                               block(update, releaseNotesText);
                                                           }
                                                       }
                                                       
                                                   }
                                               }
                                           }
                                       }
                                       
                                   }else {
                                       NSLog(@"APPReleaseNoteDownload NSJSONSerialization error = %@", error);
                                   }
                               }else {
                                   NSLog(@"获取数据失败 = %@", data);
                                   if (block) {
                                       block(NO, @"000");
                                   }
                               }
                            }];
}

@end
