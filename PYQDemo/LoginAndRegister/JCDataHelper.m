//
//  JCDataHelper.m
//  Victor
//
//  Created by Guo.JC on 2017/8/9.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCDataHelper.h"
#import "NSDate+FormateString.h"

@implementation JCDataHelper

/**
 是否需要展示引导图
 @return                是否需要引导
 */
+ (BOOL)isNeedWelcome{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    BOOL isShowed = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"-%@-",app_Version]];
    if (isShowed == NO) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"-%@-",app_Version]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return !isShowed;
}

/**
 是否有登录的用户
 @return                是否有登录的用户
 */
+ (BOOL)isLogin{
    
    if (GET_LOGIN_STATE == YES) {
        return YES;
    }
    return NO;
}

/**
 保存模板
 @params    sourceDic   源数据
 @params    classID     课时ID
 */
+ (BOOL)saveCoachModelWithSource:(NSDictionary *)sourceDic andClassID:(NSString *)classID{
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//    NSString *coachModelPath = [documentsPath stringByAppendingPathComponent:@"CoachModel"];
//    BOOL isDir = NO;
//    BOOL existed = [fm fileExistsAtPath:coachModelPath isDirectory:&isDir];
//    if ( !(isDir == YES && existed == YES) ) {
//        [fm createDirectoryAtPath:coachModelPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    NSString *filePath = [coachModelPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@.txt",kCoachModelTitle,classID]];
//    BOOL isSucced = [sourceDic writeToFile:filePath atomically:YES];
//    return isSucced;
    return YES;
}

/**
 获取模板
 @params    classID     课时ID
 @return                字典数据
 */
+ (NSDictionary *)getCoachModelWithClassID:(NSString *)classID{
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
//    NSString *coachModelPath = [documentsPath stringByAppendingPathComponent:@"CoachModel"];
//    NSString *filePath = [coachModelPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@.txt",kCoachModelTitle,classID]];
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    return dic;
    return nil;
}

/**
 计算卡洛里消耗
 @params    sex         性别
 @params    age         年龄
 @params    weight      体重
 @params    time        时间（分钟）
 @params    sportfuel   系数
 @return                消耗的卡洛里
 */
+ (CGFloat)calorieCaculate:(Gender) sex
                       age:(NSInteger) age
                    weight:(NSInteger) weight
                      time:(CGFloat) time
                 sportfuel:(CGFloat) sportfuel{
    float x1,x2;
    float kcal;
    float ftime;
    if(sex == GenderFemale)
    {
        if(age < 31)
        {
            x1 = 14.6f;
            x2 = 450;
        }
        else if(age <61)
        {
            x1 = 8.6f;
            x2 = 830;
        }
        else
        {
            x1 = 10.4f;
            x2 = 600;
        }
    }
    else
    {
        if(age < 31)
        {
            x1 = 15.2f;
            x2 = 680;
        }
        else if(age <61)
        {
            x1 = 11.5f;
            x2 = 830;
        }
        else
        {
            x1 = 13.4f;
            x2 = 490;
        }
    }
    if(weight>100)
        weight = 100;
    ftime = time/60;
    kcal = ((x1 * weight + x2) * sportfuel * ftime );
    return kcal;
}
@end
