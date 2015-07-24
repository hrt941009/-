//
//  EditePicureViewController.h
//  Love
//
//  Created by use on 15-3-27.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//图片处理

#import <UIKit/UIKit.h>
#import "PublishMainViewController.h"
@protocol GetImageDataDelegate <NSObject>

- (void)getImageDataWith:(UIImage *)image andUrl:(NSString *)imageUrl;

@end
@interface EditePicureViewController : LOVBaseViewController

@property (nonatomic, assign) BOOL isAddImage;

@property (nonatomic, assign) BOOL isShare;

@property (nonatomic, strong) UIImage *myImage;

@property (nonatomic, weak) id<GetImageDataDelegate>delegate;

@property (nonatomic, weak) id<DismissViewControllerDelegate>dismis;
@end
