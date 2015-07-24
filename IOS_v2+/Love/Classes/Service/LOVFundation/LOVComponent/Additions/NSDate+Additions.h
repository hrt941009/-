//
//  NSDate+ConvertString.h
//  CSLCLottery
//
//  Created by 李伟 on 13-5-8.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+ (NSString *)dateConvertString:(NSString *)string;
+ (NSString *)timeIntervalSince1970ConvertString:(NSString *)string;
+ (NSString *)countTimeFormat:(int)times;
+ (NSString *)formatDateSince1970:(NSDate *)date;
+ (NSString *)formatDateSinceDate:(NSDate *)date;

@end
