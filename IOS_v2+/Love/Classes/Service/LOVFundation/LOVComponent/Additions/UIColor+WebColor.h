//
//  ColorConvert.h
//  Monitor
//
//  Created by 李伟 on 11-6-27.
//  Copyright 2011 中体彩科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_VOID_COLOR  000000


//颜色转换
@interface UIColor(WebColor)

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;
+ (UIColor *)colorRGBWithRed:(CGFloat)a green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;

@end
