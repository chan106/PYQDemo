//
//  JCWebDataRequst.m
//  Zebra
//
//  Created by Guo.JC on 2016/12/29.
//  Copyright © 2016年 奥赛龙科技. All rights reserved.
//

#import "JCWebDataRequst.h"
#import "JCUserManager.h"
//#import "WSProgressHUD.h"
//#import "JCStudyCourseModel.h"
#import <AFNetworking/AFNetworking.h>
//#import "JCStudyHistoryModel.h"
#import "AESCipher.h"
#import "NSString+JCMD5Encryption.h"
#import "NSDate+FormateString.h"
//#import "JCBadgeConfigItem.h"
#import "JCRankingModel.h"
#import "JCMyRankingModel.h"
#import "JCOtherUserData.h"
//#import "JCMainTrainModel.h"
//#import "JCMyClassSummaryModel.h"
//#import "JCDailyStatistics.h"
//#import "FMDB.h"
//#import "AddressModel.h"
//#import "JCDataHelper.h"
#import "JCLoginViewController.h"
#import "JCStoryboardManager.h"
#import "JCMainNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#define         AES_KEY        @"jWFamrZVTIsZvyiJ"

@implementation JCWebDataRequst

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
                     timeStamp:(NSString *)timeStamp {
    NSString *token = [AESCipher decryptAES:user.token key:AES_KEY];
//    JCLog(@"\n\ntoken :%@\n\n",user.token);
//    JCLog(@"\n解出来的签名：%@",token);
    NSString *sign = [NSString stringWithFormat:@"%@&uid=%@&timestamp=%@&token=%@",api,user.userID,timeStamp,token];
    //    NSLog(@"拼接的sign：%@",sign);
    sign = [sign stringToMD5];
    sign = [sign substringWithRange:NSMakeRange(2, 28)];
    sign = [sign stringToMD5];
    //    NSLog(@"\nMD5加密、截取之后：%@",sign);
    return sign;
}

/**
 *  @brief                   生成带签名path
 *
 *  @param api               接口
 *********************************************/
+ (NSString *)creatPathWithAPI:(NSString *)api{
    
    NSString *path = [BaseAPI stringByAppendingString:api];
    NSString *timeStamp = [[NSDate new] unixTimeStampWithDateStr];
    NSString *sign = [self creatSignWithAPI:api user:[JCUser currentUer] timeStamp:timeStamp];
    path = [NSString stringWithFormat:@"%@?sign=%@&uid=%@&timestamp=%@",path,sign,GET_CURRENT_USER_ID,timeStamp];
    //    NSLog(@"\n得到的path：%@",path);
    return path;
}

///token失效，切换到登录窗口，并弹框提示
+ (void)tokenInvalid{
    JCLoginViewController *loginVC = [[JCStoryboardManager storyboardForLogin] instantiateViewControllerWithIdentifier:SBID_LoginHomeVC];
    loginVC.fd_prefersNavigationBarHidden = YES;
    [UIApplication sharedApplication].keyWindow.rootViewController = [[JCMainNavigationController alloc] initWithRootViewController:loginVC];
//    [loginVC alertMessage:LOCATION(@"TokenInvalid") tapButton:LOCATION(@"OK") completion:nil];
    SAVE_LOGIN_STATE(NO);
}
@end
