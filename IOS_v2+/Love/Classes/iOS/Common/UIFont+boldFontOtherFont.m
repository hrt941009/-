//
//  UIFont+boldFontOtherFont.m
//  Love
//
//  Created by use on 15-4-8.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "UIFont+boldFontOtherFont.h"

@implementation UIFont (boldFontOtherFont)

+ (UIFont *)lovFontWithName:(NSString *)foneName Size:(CGFloat)fontSize IsBold:(BOOL)isBold{
    if (isBold) {
        UIFont *myFont = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",foneName] size:fontSize];
        return myFont;
    }else{
        UIFont *myFont = [UIFont fontWithName:foneName size:fontSize];
        return myFont;
    }
}

+ (UIFont *)lovFontWitnSize:(CGFloat)fontSize IsBold:(BOOL)isBold{
    if (isBold) {
        UIFont *myFont = [UIFont fontWithName:@"STHeiTiJ-Medium" size:fontSize];
        return myFont;
    }else{
        UIFont *myFont = [UIFont fontWithName:@"STHeiTiJ-Light" size:fontSize];
        return myFont;
    }
}

@end
