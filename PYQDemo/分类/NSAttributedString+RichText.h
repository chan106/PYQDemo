//
//  NSAttributedString+RichText.h
//  CoolTennisBall
//
//  Created by Coollang on 16/8/9.
//  Copyright © 2016年 CoolLang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (RichText)

+ (NSAttributedString *)attributedString:(NSString *)string subString:(NSArray *)subStrings colors:(NSArray *)colors fonts:(NSArray *)fonts;
+ (NSAttributedString *)attributedString:(NSString *)string subString:(NSArray *)subStrings colors:(NSArray *)colors;
@end
