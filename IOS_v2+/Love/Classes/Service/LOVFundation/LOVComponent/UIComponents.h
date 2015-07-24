//
//  UIComponents.h
//  CSLCLottery
//
//  Created by 李伟 on 13-3-12.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define MyLocalizedString(S)  NSLocalizedString(S, @"")

@interface UIComponents : NSObject

+ (UILabel *)labelWithFrame:(CGRect)frame
        backgroundColor:(UIColor *)bgColor
               fontSize:(CGFloat)fontSize
              textColor:(UIColor *)textColor
          textAlignment:(NSInteger)textAlignment
adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth;

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                backgroundColor:(UIColor *)bgColor
                        fontSize:(CGFloat)fontSize
                      textColor:(UIColor *)textColor
                    placeholder:(NSString *)placeholder
                    borderColor:(CGColorRef)borderColor
                    borderWidth:(CGFloat)borderWidth
                   cornerRadius:(CGFloat)cornerRadius;



+ (UIButton *)buttonWithFrame:(CGRect)frame
              backgroundImage:(UIImage *)img
                        title:(NSString *)title
                   titleColor:(UIColor *)tcolor
                titleFontSize:(CGFloat)size;


@end
