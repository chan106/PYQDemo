//
//  JCWebDataRequst.h
//  Zebra
//
//  Created by Guo.JC on 2016/12/29.
//  Copyright © 2016年 奥赛龙科技. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WebRequestSetting.h"
@class JCUser;

typedef void(^webRequestComplete)(id obj);
typedef void(^isExistComplete)(BOOL isExist);
typedef void(^resultCallBack)(BOOL result, id reason);
typedef void(^webRequestCallBack)(WebRespondType respondType, id result);

//static dispatch_queue_t _queue;

@interface JCWebDataRequst : UIViewController

#pragma mark     ------------------------------------
#pragma mark ----------------数据加密---------------------
#pragma mark     ------------------------------------
/**
 *  @brief                   生成签名
 *
 *  @param api               接口
 *  @param user              用户
 *  @param timeStamp         时间戳
 *********************************************/
+ (NSString *)creatSignWithAPI:(NSString *)api
                          user:(JCUser *)user
                     timeStamp:(NSString *)timeStamp;

/**
 *  @brief                   生成带签名path
 *
 *  @param api               接口
 *********************************************/
+ (NSString *)creatPathWithAPI:(NSString *)api;

/**
 *  @brief                   token失效，切换到登录窗口，并弹框提示
 *
 *********************************************/
+ (void)tokenInvalid;

@end
