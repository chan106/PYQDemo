//
//  NSObject+Until.h
//  CoolMove
//
//  Created by wsl on 16/3/9.
//  Copyright © 2016年 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Until)

- (BOOL)checkIsLastestVersion:(NSString *)currentVersion lastestVersion:(NSString *)version;

// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict;

@end
