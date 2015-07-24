//
//  PublishProductViewController.h
//  Love
//
//  Created by use on 15-3-27.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h>
@protocol ImageDataDelegate <NSObject>

- (void)imageDataWith:(UIImage *)image andUrl:(NSString *)imgUrl;

@end

@interface PublishProductViewController : LOVBaseViewController

@property (nonatomic, assign) BOOL isAddImage;

@property (nonatomic, assign) BOOL isShare;

@property (nonatomic, weak) id<ImageDataDelegate>delegate;

- (void)allPhotosCollected:(NSArray *)imgArray;

@end
