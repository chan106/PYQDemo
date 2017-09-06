//
//  JCDataHelper.h
//  Victor
//
//  Created by Guo.JC on 2017/8/9.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCUserManager.h"

@interface JCDataHelper : NSObject

/**
 是否需要展示引导图
 @return                是否需要引导
 */
+ (BOOL)isNeedWelcome;

/**
 是否有登录的用户
 @return                是否有登录的用户
 */
+ (BOOL)isLogin;

/**
 保存模板
 @params    sourceDic   源数据
 @params    classID     课时ID
 */
+ (BOOL)saveCoachModelWithSource:(NSDictionary *)sourceDic andClassID:(NSString *)classID;

/**
 获取模板
 @params    classID     课时ID
 @return                字典数据
 */
+ (NSDictionary *)getCoachModelWithClassID:(NSString *)classID;

/**
 计算卡洛里消耗
 @params    sex         性别
 @params    age         年龄
 @params    weight      体重
 @params    time        时间（分钟）
 @params    sportfuel   系数（暂取0.4）
 @return                消耗的卡洛里
 */
+ (CGFloat)calorieCaculate:(Gender) sex
                       age:(NSInteger) age
                    weight:(NSInteger) weight
                      time:(CGFloat) time
                 sportfuel:(CGFloat) sportfuel;
@end
