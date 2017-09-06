//
//  AppDelegate+JCConfigSDK.h
//  Victor
//
//  Created by coollang on 17/3/1.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "AppDelegate.h"
#import "JCLoginViewController.h"

@interface AppDelegate (JCConfigSDK)

/**
 shareSDK配置
 */
- (void)configShareSDK;

/**
 SMSSDK配置
 */
- (void)configSMSSDK;

/**
 数据库升级、迁移
 */
- (void)migrationRealm;

/**
 Window配置
 */
- (void)setupWindow;

/**
 是否登录
 */
- (BOOL)isLogin;


/**
 3D-Touch配置
 */
- (void)touch_3D_config;

/**
 清理异常数据
 */
- (void)clearErrorDB;

/**
 导入地址数据库
 */
- (void)importAddressDB;

/**
 提前获取 相机 、麦克风、相册权限
 */
- (void)getAuthorization;
@end
