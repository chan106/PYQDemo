//
//  NSString+Add.m
//  navDemo
//
//  Created by Max on 16/9/20.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import "NSString+Add.h"

@implementation NSString (Add)


- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:nil].size;
}



- (BOOL)isEmptyString
{
    if ([self isKindOfClass:[NSNull class]] || !self || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}



- (BOOL)isEmptyStringNoSpaces
{
    if ([self isKindOfClass:[NSNull class]] || !self || [self isEqualToString:@""]) {
        return YES;
    }
    else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}



/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}



- (CGFloat)heightForString:(NSString *)string font:(CGFloat)font width:(CGFloat)width{
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    tv.font = [UIFont systemFontOfSize:font];
    tv.text = string;
    [tv sizeToFit];
    CGFloat height = tv.bounds.size.height;
    return height;
}


//获取当前年份
+ (NSInteger)currentYear{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY"];
    return [[formatter stringFromDate:date] integerValue];
}

@end
