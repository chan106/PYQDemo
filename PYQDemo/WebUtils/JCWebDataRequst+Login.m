//
//  JCWebDataRequst+Login.m
//  Victor
//
//  Created by Guo.JC on 2017/8/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCWebDataRequst+Login.h"
#import "JCBaseWebUtils.h"
#import "WebRequest.h"
#import "JCUserManager.h"
#import "NSDate+FormateString.h"
#import "NSString+CheckIsString.h"
//#import "JCBadgeConfigItem.h"

@implementation JCWebDataRequst (Login)

#pragma mark     ------------------------------------
#pragma mark ----------------登录注册---------------------
#pragma mark     ------------------------------------
///刷新登录
+ (void)refreshLoginComplete:(webRequestCallBack)complete{
    NSString *path = [self creatPathWithAPI:kRefreshLogin];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [JCBaseWebUtils post:path andParams:@{@"device":@"2",@"version":app_Version} andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            if (ret == WebRespondTypeSuccess) {
                JCUser *user = [JCUser currentUer];
//                JCLog(@"\n\n刷新之前的token：%@",user.token);
                [[RLMRealm defaultRealm] beginWriteTransaction];
                user.token = [NSString checkIfNullWithString:obj[@"errDesc"][@"Token"]];
                [[RLMRealm defaultRealm] commitWriteTransaction];
//                JCLog(@"刷新之后的token：%@\n\n",user.token);
                complete(WebRespondTypeSuccess,nil);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){///token失效
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }else{
                complete(WebRespondTypeFail, nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}
///第三方登录
+(void)loginByThirdPlatformParams:(NSDictionary *)params complete:(webRequestCallBack)complete{
    
    NSString *path = [BaseAPI stringByAppendingString:kLoginThrid];
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState) {
            
            NSInteger ret = [obj[@"ret"] integerValue];
            if (ret == WebRespondTypeSuccess) {
                NSDictionary *err = obj[@"errDesc"];
                JCUser *user = [JCUser userWithPrivateKey:err[@"ID"]];
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    user.token = err[@"Token"];
                }];
                SAVE_CURRENT_USER_ID(user.userID)
                SAVE_LOGIN_STATE(YES);
                complete(WebRespondTypeSuccess, obj[@"errDesc"]);
                ///下载徽章配置数据
//                [JCWebDataRequst getBadgeConfigComplete:^(WebRespondType respondType, id result) {
//                    
//                }];
            }
            else{
                complete(WebRespondTypeFail, nil);
            }
        }else{
            complete(WebRespondTypeTimeOut,obj);
        }
    }];
}
///手机号注册号
+(void)phoneRgisterWithParams:(NSDictionary *)params complete:(webRequestCallBack)complete{
    
    NSString *path = [BaseAPI stringByAppendingString:@"Login/phoneRegister"];
    
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                
                NSDictionary *errDesc = obj[@"errDesc"];
                JCUser *user = [JCUser userWithPrivateKey:errDesc[@"ID"]];
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    user.token = errDesc[@"Token"];
                }];
                SAVE_CURRENT_USER_ID(errDesc[@"ID"])
                complete(WebRespondTypeSuccess,nil);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                complete(WebRespondTypeInvalidToken,nil);
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }else if (ret == WebRespondTypeChangePassVerifyCodeError){
                complete(WebRespondTypeChangePassVerifyCodeError, nil);
            }
            else{
                complete(WebRespondTypeFail, nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}
///账号登录
+(void)accountLoginWithAcount:(NSString *)acount
                     password:(NSString *)password
                     complete:(webRequestCallBack)complete{
    NSString *path = [BaseAPI stringByAppendingString:kAcountLogin];
    NSString *timeStamp = [[NSDate new] unixTimeStampWithDateStr];
    NSDictionary *params = @{
                             @"account":acount,
                             @"pwd":password,
                             @"type":@"0",
                             @"device":@"2",
                             @"version":@"1.0.0",
                             @"timestamp":timeStamp};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                NSDictionary *errDic = obj[@"errDesc"];
                JCUser *user = [JCUser userWithPrivateKey:[NSString checkIfNullWithString:errDic[@"ID"]]];
                [[RLMRealm defaultRealm] transactionWithBlock:^{
                    user.token = [NSString checkIfNullWithString:errDic[@"Token"]];
                }];
                SAVE_CURRENT_USER_ID(user.userID)
                SAVE_LOGIN_STATE(YES);
                complete(WebRespondTypeSuccess,errDic);
                ///下载徽章配置数据
//                [JCWebDataRequst getBadgeConfigComplete:^(WebRespondType respondType, id result) {
//                    
//                }];
            }
            else if (ret == WebRespondTypeDataIsNil){
                complete(WebRespondTypeDataIsNil,nil);
            }
            else if (ret == WebRespondTypeNoUser){
                complete(WebRespondTypeNoUser, nil);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                complete(WebRespondTypeInvalidToken,nil);
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }else{
                complete(WebRespondTypeFail,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}
///找回密码
+(void)getPwdByPhoneCodeWithParams:(NSDictionary *)params complete:(webRequestCallBack)complete{
    
    NSString *path = [BaseAPI stringByAppendingString:@"Login/getPwdByPhoneCode"];
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                NSDictionary *errDic = obj[@"errDesc"];
                complete(WebRespondTypeSuccess,errDic);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                complete(WebRespondTypeInvalidToken,nil);
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeChangePassVerifyCodeError){
                complete(WebRespondTypeChangePassVerifyCodeError, nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }else{
                complete(WebRespondTypeFail, nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}
///检测手机是否注册过
+(void)phoneExistWithPhoneNumber:(NSString *)phoneNumber complete:(webRequestCallBack)complete{
    
    NSString *path = [BaseAPI stringByAppendingString:@"login/phoneExist"];
    NSDictionary *params = @{@"phone":phoneNumber};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                NSString *isExist = ((NSDictionary *)obj[@"errDesc"])[@"exist"];
                complete(WebRespondTypeSuccess,isExist);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                complete(WebRespondTypeInvalidToken,nil);
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}
///退出登录
+(void)logOutAcountComplete:(webRequestCallBack)complete{
    
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    
    for (id obj in tmpArray) {
        [cookieJar deleteCookie:obj];
    }
    
//    RLMResults *results = [JCBadgeConfigItem allObjects];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        ///取消已下载数据标记
        [JCUser currentUer].isDownHistoryData = NO;
//        for (JCBadgeConfigItem *item in results) {
//            item.isGet = NO;
//        }
    }];
    
    SAVE_LOGIN_STATE(NO);
}


@end
