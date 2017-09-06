//
//  UIColor+Extension.h
//  CoolMove
//
//  Created by CA on 15/8/10.
//  Copyright (c) 2015年 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor *)colorWithHex:(NSInteger)hexValue;
+ (NSString *)hexFromUIColor:(UIColor *) color;

@end
