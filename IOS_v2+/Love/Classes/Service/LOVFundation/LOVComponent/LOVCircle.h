//
//  LOVCircle.h
//  Love
//
//  Created by lee wei on 14-7-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  将图片变为圆形。例如：圆形头像
//


#import <UIKit/UIKit.h>

@interface LOVCircle : UIView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;
- (id)initWithFrame:(CGRect)frame imageWithPath:(NSString *)path;
- (id)initWithFrame:(CGRect)frame imageWithPath:(NSString *)path placeholderImage:(UIImage *)placeholder;

@end
