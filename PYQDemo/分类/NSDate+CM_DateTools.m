//
//  NSDate+CM_DateTools.m
//  CoolMove
//
//  Created by CA on 15/10/30.
//  Copyright © 2015年 CA. All rights reserved.
//

#import "NSDate+CM_DateTools.h"

@implementation NSDate (CM_DateTools)

- (NSDate *)converWeekDateByWeekDay:(WeekDay)weekDay
{
    NSInteger dayNumber = self.weekday;
    if (dayNumber == 1) {
        dayNumber += 7;
    }
    
    NSInteger differDay = dayNumber - 2;
    
    NSDate *mondayDate = [self dateBySubtractingDays:differDay];
    NSDate *convertDayDate = [mondayDate dateByAddingDays:weekDay - 1];
    
    return convertDayDate;
}

- (NSString *)convertMonthDayByWeekDay:(WeekDay)weekDay
{
    NSDate *convertDayDate = [self converWeekDateByWeekDay:weekDay];
    
    NSString *convertDayStr = [convertDayDate formattedDateWithFormat:@"MM/dd"];
    
    return convertDayStr;
}

- (NSString *)convertYearMonthDayByWeekDay:(WeekDay)weekDay
{
    NSDate *convertDayDate = [self converWeekDateByWeekDay:weekDay];
    
    NSString *convertDayStr = [convertDayDate formattedDateWithFormat:@"yyyy-MM-dd"];
    
    return convertDayStr;
}

+ (NSInteger)daysByYear:(NSInteger)year month:(NSInteger)month
{
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        return 31;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
        return 30;
    } else {
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            return 29;
        } else {
            return 28;
        }
    }
}
@end
