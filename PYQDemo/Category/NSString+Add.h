//
//  NSString+Add.h
//  navDemo
//
//  Created by Max on 16/9/20.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Add)


/**
 *  获取给定字符串大小
 */
- (CGSize)sizeWithFont:(UIFont *)font;



/**
 *  判定字符串是否非空
 */
- (BOOL)isEmptyString;



/**
 *  判定字符串是否非空，(若全部为空格，也判定为空字符串，返回YES)
 */
- (BOOL)isEmptyStringNoSpaces;



/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(UITextView *)textView andWidth:(float)width;



/**
 @method 获取指定宽度width,font的字符串的高度
 @param width 限制字符串显示区域的宽度
 @param font  字体大小
 @result CGFloat 返回的高度
 */
- (CGFloat)heightForString:(NSString *)string font:(CGFloat)font width:(CGFloat)width;

//获取当前年份
+ (NSInteger)currentYear;
@end
