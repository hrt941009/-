//
//  NSString+Additions.h
//  Love
//
//  Created by 李伟 on 14-8-8.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Additions)

+ (NSString *)myBankCardFormat:(NSString *)bankNo;
+ (NSString *)inputBankCardAndFormat:(NSString *)string;
+ (NSString *)myMobileFormat:(NSString *)mobile;

+ (NSString *)regexHtmlWithContent:(NSString *)content;

@end
