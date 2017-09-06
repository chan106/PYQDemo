//
//  NSDate+CM_DateTools.h
//  CoolMove
//
//  Created by CA on 15/10/30.
//  Copyright © 2015年 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+DateTools.h"

typedef NS_ENUM(NSInteger, WeekDay) {
    WeekDayMonday = 1,
    WeekDayTuesday,
    WeekDayWednesday,
    WeekDayThursday,
    WeekDayFriday,
    WeekDaySaturday,
    WeekDaySunday
};

@interface NSDate (CM_DateTools)

/**
 *  当前时间对应周里面获取周对应天的日期
 *
 *  @param weekDay 周一至周日
 *
 *  @return 返回对应的月日格式:月/日
 */
- (NSString *)convertMonthDayByWeekDay:(WeekDay)weekDay;

// 格式：年-月-日
- (NSString *)convertYearMonthDayByWeekDay:(WeekDay)weekDay;

/**
 *  返回当前周对应星期几的日期时间
 *
 *  @param weekDay 星期几
 *
 *  @return 星期几的时间
 */
- (NSDate *)converWeekDateByWeekDay:(WeekDay)weekDay;

// 获取本月的天数
+ (NSInteger)daysByYear:(NSInteger)year month:(NSInteger)month;

@end
