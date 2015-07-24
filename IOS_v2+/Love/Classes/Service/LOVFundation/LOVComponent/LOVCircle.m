//
//  LOVCircle.m
//  Love
//
//  Created by lee wei on 14-7-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVCircle.h"
#import "UIImageView+WebCache.h"

@implementation LOVCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/**
 显示圆形图片
 
 @param  frame  imageView frame
 @param  image  需要转换的图片
 
 @return self
 */
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = image;
        
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:0
                                                          endAngle:2*M_PI
                                                         clockwise:YES];
        CAShapeLayer *shape = [CAShapeLayer layer];
        shape.path = path.CGPath;
        imageView.layer.mask = shape;
        [self addSubview:imageView];
    }
    return self;
}

/**
 显示圆形图片
 
 @param  frame  imageView frame
 @param  path   下载路径
 
 @return self
 */
- (id)initWithFrame:(CGRect)frame imageWithPath:(NSString *)path
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView sd_setImageWithURL:[NSURL URLWithString:path]];
        
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:0
                                                          endAngle:2*M_PI
                                                         clockwise:YES];
        CAShapeLayer *shape = [CAShapeLayer layer];
        shape.path = path.CGPath;
        imageView.layer.mask = shape;
        [self addSubview:imageView];
    }
    return self;
}

/**
 显示圆形图片
 
 @param  frame         imageView frame
 @param  path          下载路径
 @param  placeholder   临时图片，服务器图片未下载完时显示
 
 @return self
 */
- (id)initWithFrame:(CGRect)frame imageWithPath:(NSString *)path placeholderImage:(UIImage *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:placeholder];
        
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:0
                                                          endAngle:2*M_PI
                                                         clockwise:YES];
        CAShapeLayer *shape = [CAShapeLayer layer];
        shape.path = path.CGPath;
        imageView.layer.mask = shape;
        [self addSubview:imageView];
    }
    return self;
}

@end
