//
//  NSString+Additions.m
//  Love
//
//  Created by 李伟 on 14-8-8.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "NSString+Additions.h"
#import "RegexKitLite.h"

@implementation NSString(Additions)

/**
 银行卡格式化 0000 1111 0000 2222 33
 @param  string   获取到的银行卡信息
 @return 格式化后的字符串
 */
+ (NSString *)myBankCardFormat:(NSString *)bankNo
{
    
    NSString *result = nil;
    
    NSString *space = @" ";
    
    if ([bankNo length] >= 16) {
        NSMutableString *bankNoString = [NSMutableString stringWithString:bankNo];
        [bankNoString insertString:space atIndex:4];
        [bankNoString insertString:space atIndex:5+4];
        [bankNoString insertString:space atIndex:10+4];
        [bankNoString insertString:space atIndex:15+4];
        result = bankNoString;
    }
    if ([bankNo length] == 0) {
        result = bankNo;
    }
    
    return result;
}

+ (NSString *)inputBankCardAndFormat:(NSString *)string
{
    NSString *result = nil;
    NSString *space = @"-";
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    [mutableString appendString:string];
    
    int stringLength = (unsigned int)[mutableString length];
    
    if (stringLength >= 4) {
        if (stringLength%5 == 0) {
            [mutableString insertString:space atIndex:stringLength-1];
        }
        result = mutableString;
        
    }else{
        result = mutableString;
    }
    return result;
}

/**
 手机号格式化 133-8888-6666
 @param  string   获取到的银行卡信息
 @return 格式化后的字符串
 */
+ (NSString *)myMobileFormat:(NSString *)mobile
{
    NSString *result = nil;
    
    NSString *space = @"-";
    
    if ([mobile length] >= 8) {
        NSMutableString *mobileString = [NSMutableString stringWithString:mobile];
        [mobileString insertString:space atIndex:3];
        [mobileString insertString:space atIndex:4+4];
        
        result = mobileString;
    }else{
        result = mobile;
    }
    
    return result;
}

/**
 去掉内容中的html标签
 @param  string   内容
 @return 去掉标签后的字符串
 */
+ (NSString *)regexHtmlWithContent:(NSString *)content
{
    NSString *result = nil;
    
    NSString *regexStr =  @"<([^>]*)>";
    NSString *contentWithoutHtml = [content stringByReplacingOccurrencesOfRegex:regexStr withString:@""];
    
    result = contentWithoutHtml;
    
    return result;
}


@end
