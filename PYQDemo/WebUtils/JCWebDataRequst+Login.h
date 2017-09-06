//
//  JCWebDataRequst+Login.h
//  Victor
//
//  Created by Guo.JC on 2017/8/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCWebDataRequst.h"

@interface JCWebDataRequst (Login)

#pragma mark     ------------------------------------
#pragma mark ----------------登录注册---------------------
#pragma mark     ------------------------------------
///刷新登录
+ (void)refreshLoginComplete:(webRequestCallBack)complete;

///第三方登录
+ (void)loginByThirdPlatformParams:(NSDictionary *)params
                          complete:(webRequestCallBack)complete;

///手机注册
+ (void)phoneRgisterWithParams:(NSDictionary *)params
                      complete:(webRequestCallBack)complete;

///账号登录
+(void)accountLoginWithAcount:(NSString *)acount
                     password:(NSString *)password
                     complete:(webRequestCallBack)complete;
///找回密码
+ (void)getPwdByPhoneCodeWithParams:(NSDictionary *)params
                           complete:(webRequestCallBack)complete;

///是否注册？
+ (void)phoneExistWithPhoneNumber:(NSString *)phoneNumber
                         complete:(webRequestCallBack)complete;

///退出登录
+ (void)logOutAcountComplete:(webRequestCallBack)complete;


@end
