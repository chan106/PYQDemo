//
//  NSObject+Language.m
//  CoolMove
//
//  Created by WSL on 15/12/17.
//  Copyright © 2015年 CA. All rights reserved.
//

#import "NSObject+Language.h"

@implementation NSObject (Language)

+ (BOOL)isChineseLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage rangeOfString:@"zh"].location != NSNotFound){
        return YES;
    }
    
    return NO;
}

@end
