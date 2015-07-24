//
//  MyLayer.m
//  CALayer
//
//  Created by henyep on 15/5/14.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "MyLayer.h"

@implementation MyLayer

#pragma mark 绘制一个实心三角形

//重写drawInContext方法 在这里绘图
-(void)drawInContext:(CGContextRef)ctx
{
    //设置为蓝色
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
    //设置起点
    CGContextMoveToPoint(ctx, 50, 0);
    
    //从50，0 连线到0 ，100
    CGContextAddLineToPoint(ctx, 0, 100);
    
    CGContextAddLineToPoint(ctx, 100, 100);
    
    //合并路径
    CGContextClosePath(ctx);
    
    //绘制路径
    CGContextFillPath(ctx);
}
@end
