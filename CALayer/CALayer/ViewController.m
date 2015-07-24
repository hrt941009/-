//
//  ViewController.m
//  CALayer
//
//  Created by henyep on 15/5/14.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyLayer.h"

@interface ViewController ()
{
    UIView *myVIew;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self animation];

}

-(void)animation
{
    myVIew=[[UIView alloc]init];
    myVIew.layer.position=CGPointMake(100, 100);
    myVIew.layer.bounds=CGRectMake(0, 0, 100, 100);
    myVIew.backgroundColor=[UIColor blueColor];
    [self SimpleCalayer];
    [self.view addSubview:myVIew];
 /*
    //实现平移动画
    //说明这个动画对象要对calayer的position属性执行动画
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:@"position"];
    
    //动画持续1.5s
    anim.duration=1.5;
    
    //Position属性值从50,80渐变到300,350
    anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(50, 80)];
    anim.toValue=[NSValue valueWithCGPoint:CGPointMake(300, 350)];
    
    //设置动画的代理
    anim.delegate=self;
    
    //保持动画执行后的状态
    anim.removedOnCompletion=NO;
    anim.fillMode=kCAFillModeBackwards;
    [myVIew.layer addAnimation:anim forKey:@"translate"];
  */
    
    /*
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:@"transform"];
    anim.duration=1;
    CATransform3D form=CATransform3DMakeTranslation(350, 350, 0);
    anim.toValue=[NSValue valueWithCATransform3D:form];
    [myVIew.layer addAnimation:anim forKey:nil];
     */
    //缩放
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    anim.duration = 2;
//    
//    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 30, 30)];
//    
//    [myVIew.layer addAnimation:anim forKey:nil];

    
     CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
     anim.duration = 1.5; // 动画持续1.5s
    
     // CALayer的宽度从0.5倍变为2倍
     // CALayer的高度从0.5倍变为1.5倍
     anim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1)];
     anim.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 1.5, 1)];
    
     [myVIew.layer addAnimation:anim forKey:nil];
}

#pragma mark  动画代理
-(void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"%@",@"动画开始了");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *string=NSStringFromCGPoint(myVIew.layer.position);
    NSLog(@"动画结束了  %@",string);

}

-(void)test
{
    CALayer *layer=[CALayer layer];
    
    layer.delegate=self;
    
    layer.bounds=CGRectMake(0, 0, 100, 100);
    layer.position=CGPointMake(100, 100);
    //开始绘制图层
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

#pragma mark Layer的代理方法实现绘图
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //设置蓝色
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
    //设置边框宽度
    CGContextSetLineWidth(ctx, 10);
    
    //添加一个跟层一样的矩形到路径中
    CGContextAddRect(ctx, layer.bounds);
    
    CGContextStrokePath(ctx);

}

-(void)overRide
{
    MyLayer *layer=[MyLayer layer];
    layer.bounds=CGRectMake(0, 0, 100, 100);
    layer.position=CGPointMake(100, 100);
    //开始绘制图层
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

-(void)addCalyer
{
    CALayer *myLayer=[CALayer layer];
    
    //设置层的宽度和高度
    myLayer.bounds=CGRectMake(0, 0, 100, 100);
    
    //设置层的位置
    myLayer.position=CGPointMake(100, 100);
    
    //默认0.5，0.5
//    myLayer.anchorPoint=CGPointMake(0, 1);
    
    //设置层的背景颜色
    myLayer.backgroundColor=[UIColor redColor].CGColor;
    
    //设置需要显示的图片
    myLayer.contents=(id)[UIImage imageNamed:@"1.png"].CGImage;
    
    //如果设置了图片 需要设置这个属性为yes才有圆角效果
    myLayer.masksToBounds=YES;
    
    //设置层的圆角半径
    myLayer.cornerRadius=10;
    
    //添加到控制器view的layer中
    [self.view.layer addSublayer:myLayer];

}

-(void)SimpleCalayer
{
    UIImage *image=[UIImage imageNamed:@"1.png"];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:image];
    imageView.center=CGPointMake(100, 100);
    
    //设置阴影的颜色为灰色
    imageView.layer.shadowColor=[UIColor grayColor].CGColor;
    
    //设置阴影的偏移大小
    imageView.layer.shadowOffset=CGSizeMake(10, 10);
    
    //设置阴影的不透明度
    imageView.layer.shadowOpacity=0.5;
    
    //设置圆角大小
    imageView.layer.cornerRadius=25;
    
    //强制内部的所有子层支持圆角效果，少了这个设置，UIImageView是不会有圆角效果的
    //如果设置了maskToBounds=YES，那将不会有阴影效果
    imageView.layer.masksToBounds=YES;
    
    //设置边框宽度和颜色
    imageView.layer.borderWidth=1;
    imageView.layer.borderColor=[UIColor redColor].CGColor;
    
    
    //设置旋转
    imageView.layer.transform=CATransform3DMakeRotation(M_1_PI, 0, 0, 1);
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
