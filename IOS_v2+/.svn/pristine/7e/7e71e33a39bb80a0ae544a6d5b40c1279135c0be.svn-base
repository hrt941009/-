//
//  UIComponents.m
//  CSLCLottery
//
//  Created by 李伟 on 13-3-12.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import "UIComponents.h"

@implementation UIComponents

+ (UILabel *)labelWithFrame:(CGRect)frame
        backgroundColor:(UIColor *)bgColor
                   fontSize:(CGFloat)fontSize
              textColor:(UIColor *)textColor
          textAlignment:(NSInteger)textAlignment
adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = bgColor;
    label.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    
    return  label;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                backgroundColor:(UIColor *)bgColor
                        fontSize:(CGFloat)fontSize
                      textColor:(UIColor *)textColor
                    placeholder:(NSString *)placeholder
                    borderColor:(CGColorRef)borderColor
                    borderWidth:(CGFloat)borderWidth
                   cornerRadius:(CGFloat)cornerRadius
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.textColor = textColor;
    textField.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    textField.backgroundColor = bgColor;
    textField.placeholder = placeholder;
    textField.layer.borderColor = borderColor;
    textField.layer.borderWidth = borderWidth;
    textField.layer.cornerRadius = cornerRadius;
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    return textField;
}


+ (UIButton *)buttonWithFrame:(CGRect)frame
              backgroundImage:(UIImage *)img
                        title:(NSString *)title
                   titleColor:(UIColor *)tcolor
                titleFontSize:(CGFloat)size
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button setTitleColor:tcolor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:size];
    return button;
}

@end
