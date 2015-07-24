//
//  NSDate+ConvertString.m
//  CSLCLottery
//
//  Created by 李伟 on 13-5-8.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

/**
 将日期格式化 yyyyMMddHHmmss 格式化为 yyyy-MM-dd HH:mm
 @return 格式化后的字符串
 */
+ (NSString *)dateConvertString:(NSString *)string
{
    NSString *result = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *tempDate = [dateFormatter dateFromString:string];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    result = [dateFormatter stringFromDate:tempDate];
    
    return result;
}

/**
 将日期转换为 hh:MM:ss
 @return 格式化后的字符串
 */
+ (NSString *)timeIntervalSince1970ConvertString:(NSString *)string
{
    NSString *result = nil;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string longLongValue]/1000];
    NSDateFormatter *foramtter = [[NSDateFormatter alloc] init];
    [foramtter setDateFormat:@"hh:MM:ss"];
    result = [foramtter stringFromDate:date];
    
    return result;
}

/**
 将日期格式化为倒计时  00:00:00
 @return 格式化后的字符串
 */
+ (NSString *)countTimeFormat:(int)times
{
    if (times > 0) {
        int getSeconds = (int)times;
        int houers = getSeconds/3600;
        int minutes = (getSeconds - houers*3600)/60;
        int seconds = getSeconds - houers*3600 - minutes*60;
        NSString *cuntdownTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d", houers, minutes, seconds];
        return cuntdownTime;
    }else{
        return @"00:00:00";
    }
}


/**
 获取自1970年以来的毫秒数,输出会显示为10位整数
 @return 格式化后的字符串
 */
+ (NSString *)formatDateSince1970:(NSDate *)date
{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSNumber *timeNumber = [NSNumber numberWithDouble:timeInterval];
    long long dateTime = [timeNumber longLongValue];
    NSString *dateStr = [NSString stringWithFormat:@"%llu", dateTime];
    
    return dateStr;
}

/**
 获取自指定年以来的毫秒数,输出会显示为10位整数
 @return 格式化后的字符串
 */
+ (NSString *)formatDateSinceDate:(NSDate *)date
{
    NSString *sinceDateStr = @"1949-10-01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *sinceDate = [dateFormatter dateFromString:sinceDateStr];
    
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:sinceDate];
    NSNumber *timeNumber = [NSNumber numberWithDouble:timeInterval];
    long long dateTime = [timeNumber longLongValue];
    NSString *dateStr = [NSString stringWithFormat:@"%llu", dateTime];
    
    return dateStr;
}

@end
