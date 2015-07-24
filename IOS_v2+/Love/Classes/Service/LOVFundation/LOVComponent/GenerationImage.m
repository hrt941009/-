//
//  GenerationImage.m
//  Editor Universal HD
//
//  Created by Li Wei on 12-7-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GenerationImage.h"

static NSString *space1 = @"(";

@implementation GenerationImage

// 图片缩放
+ (UIImage *)scaleImage:(UIImage *)image  size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//两张图片合并
+ (UIImage *)addImage1:(UIImage *)img1 image2:(UIImage *)img2
{
    CGSize size = CGSizeMake(img1.size.width, img1.size.height);
    
    UIGraphicsBeginImageContext(size);
    
    [img1 drawInRect:CGRectMake(0, 0, img1.size.width, img1.size.height)];
    
    if (img1.size.height > 390) {
        [img2 drawInRect:CGRectMake(20, img1.size.height-img2.size.height, img2.size.width, img2.size.height)];
    }else{
        [img2 drawInRect:CGRectMake(img1.size.width - img2.size.width-10, img1.size.height-img2.size.height, img2.size.width, img2.size.height)];
    }
    
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}

//文字生成图片
+ (void)textViewContent:(NSString *)text
        backgroundImage:(UIImage *)bgImage
              textColor:(UIColor *)tColor
               fontName:(NSString *)fontName
          isPhotosAlbum:(BOOL)isPhotosAlbum
{
    float fw = 2.0;
    float ff = 2.0;
    
    NSString *space2 = nil;
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *signStr = [userDefaults objectForKey:SignTextKey];
//    NSLog(@"signStr: %@", signStr);
//    if ([signStr length]>0) {
//        space2 = [signStr stringByAppendingString:NSLocalizedString(@"Detail Send", @"")];
//    }else{
//        space2 = NSLocalizedString(@"Detail", @"");
//    }
    //NSString *str = [NSString stringWithFormat:@"%@%@%@",eTextView.text,space1,space2];
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendString:text];
    [str appendString:space1];
    [str appendString:space2];
    
    CGSize textSize = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 8000) lineBreakMode:NSLineBreakByCharWrapping];
    
    NSLog(@"width:%f ; height:%f",textSize.width, textSize.height);
    
    int ww = textSize.width;
    int hh = textSize.height;
    
    NSLog(@"%@",str);
    
    if ([text length]<=0) {
        //                alert = [[UIAlertView alloc] initWithTitle:nil
        //                                                   message:NSLocalizedString(@"Ｗords less", @"")
        //                                                  delegate:self
        //                                         cancelButtonTitle:NSLocalizedString(@"OK", @"")
        //                                         otherButtonTitles: nil];
        //                [alert show];
        //                [alert release];
    }
    
    else{
        UIImage *img = [[UIImage alloc] init];
        img = bgImage;
        
        
        //下面的这些方法其实应该都是OpenGL中方法 只是封装了下 相同的机制（状态机机制）
        //设置颜色模式
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //创建一个画图的上下文
        CGContextRef context = CGBitmapContextCreate(NULL, ww*fw, hh*ff, 8, 4 * ww*fw, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        
        //在画图上下文中指定的区域画给定的图片
        CGContextDrawImage(context, CGRectMake(0, 0, ww*fw, hh*ff),img.CGImage);
        
        CGContextGetClipBoundingBox(context);
        
        CGContextTranslateCTM(context, 10,hh*ff);
        CGContextScaleCTM(context, 1.0, -1.0);
         
        UIGraphicsPushContext(context);
        
        UIFont *font = [UIFont fontWithName:fontName size:14.f];
        
        UIColor *txColor = tColor;
        [txColor set];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
//        [str drawInRect:CGRectMake(0, 2, ww*fw-20, hh*ff) withFont:font];
        [str drawInRect:CGRectMake(0, 2, ww*fw-20, hh*ff) withAttributes:dic];
        
        UIGraphicsPopContext();
        
        //最后生成图片
        CGImageRef imgCombined = CGBitmapContextCreateImage(context);
        
        //释放画图上下文
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        
        //图文
        UIImage *retImage = [UIImage imageWithCGImage:imgCombined];
        
        //签名图
        NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *signPath = [paths stringByAppendingPathComponent:@"my-sign.png"];
        NSLog(@"imagePath %@",signPath);
        
        UIImage *resultImage = nil;
        if ([signPath length]>0) {
            resultImage = [GenerationImage addImage1:retImage image2:[UIImage imageWithContentsOfFile:signPath]];
        }else{
            resultImage = retImage;
        }
        
        //保存相册
        UIImageWriteToSavedPhotosAlbum(resultImage, nil, nil, nil);
        CGImageRelease(imgCombined);
        
        //---------- save -------------//
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        //NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        
        //---------- create images-------------//
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imageName = [path stringByAppendingPathComponent:@"longer.png"];
        NSLog(@"path %@",path);
        NSData *imgData = UIImagePNGRepresentation(resultImage);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:imageName contents:imgData attributes:nil];
        
        
        //--------
        if (isPhotosAlbum == YES) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"Create Success", @"")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles: nil];
            [alert show];
        }
        
    }
}


//裁剪图片
+ (UIImage *)cutImage:(UIImage *)image
{
    if (image) {
        CGFloat imgWidth = 0;
//        CGFloat minSize = MIN(image.size.width, image.size.height);
//        if (minSize > kScreenWidth) {
//            imgWidth = kScreenWidth;
//        }else{
//            imgWidth = minSize;
//        }
        CGRect imageRect = CGRectMake(0, 0, imgWidth, imgWidth);

        if (image.size.width >= image.size.height) {
            imageRect = CGRectMake((image.size.width - (image.size.height * (kScreenWidth - 30) / 305))/2, 0, image.size.height * (kScreenWidth - 30) / 305, image.size.height);
        }else{
            imageRect = CGRectMake(0, (image.size.height - image.size.width * (kScreenWidth - 30) / 305)/2, image.size.width, image.size.width * (kScreenWidth - 30) / 305);
        }
        
        
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, imageRect);
        
        UIGraphicsBeginImageContext(imageRect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, CGRectMake(0, 0, imgWidth, imgWidth), subImageRef);
        UIImage *viewImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        CGImageRelease(subImageRef);
        return viewImage;
    }
    return nil;
}

@end
