//
//  NSDate+FormateString.m
//  CoolMove
//
//  Created by CA on 15/4/26.
//  Copyright (c) 2015年 CA. All rights reserved.
//

#import "NSDate+FormateString.h"

@implementation NSDate (FormateString)

#pragma mark - Public Method

// 字符串转时间
+ (NSDate *)formateYearMonthDayString:(NSString *)string
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    return [dateFormatter dateFromString:string];
}

+ (NSString *)formateUnixTimeStampTo24ClockString:(NSTimeInterval)unixTimeStamp
{
    NSDate *date = [NSDate dateWithTimeInterval:unixTimeStamp sinceDate:[self formateString:@"1970-01-01 00:00:00"]];
    return [self formateTo24ClockWithDate:date];
}

+ (NSString *)formateUnixTimeStampTo24ClockString:(NSTimeInterval)unixTimeStamp minutes:(NSUInteger)mintues
{
    NSTimeInterval newUnixTimeStamp = unixTimeStamp - (NSUInteger)unixTimeStamp%(60 * mintues);
    return [self formateUnixTimeStampTo24ClockString:newUnixTimeStamp];
}

+ (NSString *)formateUnixTimeStampTo24ClockNewString:(NSTimeInterval)unixTimeStamp withDateFormatter:(NSDateFormatter *)formatter
{
    NSDate *date = [NSDate dateWithTimeInterval:unixTimeStamp sinceDate:[self formateString:@"1970-01-01 00:00:00"]];
    return [self formateTo24ClockWithNewDate:date dateFormatter:formatter];
}

#pragma mark - Private Method

// 时间转字符串
+ (NSString *)formateDate:(NSDate *)date
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return [formatter stringFromDate:date];
}

// 字符串转时间
+ (NSDate *)formateString:(NSString *)string
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return [dateFormatter dateFromString:string];
}

// 时间转字符串
+ (NSString *)formateTo24ClockWithDate:(NSDate *)date
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
    }
    
    return [formatter stringFromDate:date];
}

// 时间转字符串
+ (NSString *)formateTo24ClockWithNewDate:(NSDate *)date dateFormatter:(NSDateFormatter *)dateFormatter
{
    return [dateFormatter stringFromDate:date];
}

// 时间戳
- (NSTimeInterval)unixTimeStampWithDate
{
    return [self timeIntervalSinceDate:[NSDate formateString:@"1970-01-01 00:00:00"]];
}

- (NSString *)unixTimeStampWithDateStr
{
    NSInteger timeInterval = [self timeIntervalSinceDate:[NSDate formateString:@"1970-01-01 00:00:00"]];
    return [@(timeInterval) stringValue];
}

+ (NSDate *)dateWithUnixTimeStamp:(NSTimeInterval)timeInterval
{
    return [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:[NSDate formateString:@"1970-01-01 00:00:00"]];
}

// 时间转年月日字符串
- (NSString *)year_month_day_dateString
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    });
    return [formatter stringFromDate:self];
}

- (NSString *)formateYearAndMonth {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:self];
}

+ (NSString *)hour_minute_secondStringWithTimeinterval:(NSTimeInterval)seconds {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH: mm: ss"];
    return [NSDate formateUnixTimeStampTo24ClockNewString:seconds withDateFormatter:formatter];
}

+ (NSString *)hour_minuteStringWithTimeinterval:(NSTimeInterval)seconds {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH: mm"];
    return [NSDate formateUnixTimeStampTo24ClockNewString:seconds withDateFormatter:formatter];
}

+ (NSString *)timeWithTimeIntervalString:(NSInteger)timestamp{
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [date year_month_day_dateString];
}

+ (NSString *)timeWithTimeIntervalString:(NSInteger)timestamp formatter:(NSString *)format{
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return [formatter stringFromDate:date];
}

/**
 年-月-日 转 时间戳
 */
+ (NSInteger)yearMouthDayToTimestamp:(NSString *)yearMD{
    if (yearMD.length != 10) {
        return 0;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSInteger pointTime;
    NSDate *pointDate = [formatter dateFromString:yearMD];
    //转换成时间戳
    pointTime = [pointDate timeIntervalSince1970] / 86400;
    return pointTime;
}
@end
