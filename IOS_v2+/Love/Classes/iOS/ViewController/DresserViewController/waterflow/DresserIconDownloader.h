//
//  DresserIconDownloader.h
//  Love
//
//  Created by 李伟 on 14/11/15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DresserHomePageModel;
@interface DresserIconDownloader : NSObject

@property (nonatomic, strong) DresserHomePageModel *dresserModel;
@property (nonatomic, copy) void(^completionHandler)(void);

- (instancetype)init;
- (void)startDownload;

@end
