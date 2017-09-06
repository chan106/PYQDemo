//
//  NSDate+FormateString.h
//  CoolMove
//
//  Created by CA on 15/4/26.
//  Copyright (c) 2015年 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FormateString)

+ (NSDate *)formateYearMonthDayString:(NSString *)string;
+ (NSString *)formateUnixTimeStampTo24ClockString:(NSTimeInterval)unixTimeStamp;
+ (NSString *)formateUnixTimeStampTo24ClockString:(NSTimeInterval)unixTimeStamp minutes:(NSUInteger)mintues;
+ (NSDate *)formateString:(NSString *)string;
+ (NSString *)formateUnixTimeStampTo24ClockNewString:(NSTimeInterval)unixTimeStamp withDateFormatter:(NSDateFormatter *)formatter;

- (NSString *)formateYearAndMonth;


- (NSString *)year_month_day_dateString;
//将持续时间转为格式化时间
+ (NSString *)hour_minute_secondStringWithTimeinterval:(NSTimeInterval)seconds;
+ (NSString *)hour_minuteStringWithTimeinterval:(NSTimeInterval)seconds;
// 时间戳
- (NSTimeInterval)unixTimeStampWithDate;
- (NSString *)unixTimeStampWithDateStr;
+ (NSDate *)dateWithUnixTimeStamp:(NSTimeInterval)timeInterval;

/**
 时间戳转年月日
 */
+ (NSString *)timeWithTimeIntervalString:(NSInteger)timestamp;
/**
 转指定格式
 */
+ (NSString *)timeWithTimeIntervalString:(NSInteger)timestamp formatter:(NSString *)format;
/**
 年-月-日 转 时间戳
 */
+ (NSInteger)yearMouthDayToTimestamp:(NSString *)yearMD;
@end
