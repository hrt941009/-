//
//  NSString+AdjustWidth.m
//  Love
//
//  Created by use on 15-4-11.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "NSString+AdjustWidth.h"

@implementation NSString (AdjustWidth)
//返回字符串所占用的尺寸.
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
