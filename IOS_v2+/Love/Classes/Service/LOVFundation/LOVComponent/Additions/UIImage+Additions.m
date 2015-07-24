//
//  UIImage+Additions.m
//  Love
//
//  Created by 李伟 on 14/11/14.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage(Additions)

//缩略图  首页、美妆师页
+ (UIImage *)lovThumbImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage;
}


@end
