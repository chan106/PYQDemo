//
//  NSObject+Until.m
//  CoolMove
//
//  Created by wsl on 16/3/9.
//  Copyright © 2016年 CA. All rights reserved.
//

#import "NSObject+Until.h"

@implementation NSObject (Until)

- (BOOL)checkIsLastestVersion:(NSString *)currentVersion lastestVersion:(NSString *)version {
    
    NSString *tempCVersion = [currentVersion stringByReplacingOccurrencesOfString:@"V" withString:@""];
    NSString *tempLVersion = [version stringByReplacingOccurrencesOfString:@"V" withString:@""];
    
    tempCVersion = [tempCVersion stringByReplacingOccurrencesOfString:@"v" withString:@""];
    tempCVersion = [tempCVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    tempLVersion = [tempLVersion stringByReplacingOccurrencesOfString:@"v" withString:@""];
    tempLVersion = [tempLVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if ([tempCVersion isEqualToString:tempLVersion]) {
        return YES;
    }
    
    return NO;
}


// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

@end
