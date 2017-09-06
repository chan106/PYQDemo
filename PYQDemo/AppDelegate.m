//
//  AppDelegate.m
//  Victor
//
//  Created by Guo.JC on 17/2/13.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JCConfigSDK.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ///配置数据库
    [self migrationRealm];
    ///配置shareSDK
//    [self configShareSDK];
    ///配置短信验证
//    [self configSMSSDK];
    ///window设置
    [self setupWindow];
    ///3D-Touch配置
    [self touch_3D_config];
    ///清理异常数据
    [self clearErrorDB];
    ///导入地址数据
    [self importAddressDB];
    ///提前获取 相机 、麦克风、相册权限
    [self getAuthorization];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
