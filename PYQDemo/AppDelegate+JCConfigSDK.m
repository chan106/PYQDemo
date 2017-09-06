//
//  AppDelegate+JCConfigSDK.m
//  Victor
//
//  Created by coollang on 17/3/1.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "AppDelegate+JCConfigSDK.h"
#import "AppDelegate.h"
#import "WebRequest.h"
#import "POP.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import "JCDataHelper.h"
#import "JCRankingListViewController.h"
#import "JCStoryboardManager.h"
#import "JCMainNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "JCFindViewController.h"

@implementation AppDelegate (JCConfigSDK)

- (void)configShareSDK{
}

- (void)configSMSSDK{
}

- (void)migrationRealm{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
    config.schemaVersion = kDB_VERSION;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

- (void)setupWindow{
//    BOOL isNeedWelcome = [JCDataHelper isNeedWelcome];
    BOOL isHaveLogin = [JCDataHelper isLogin];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    if (isHaveLogin) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isSaveUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //刷新登录
//        [JCWebDataRequst refreshLoginComplete:^(WebRespondType respondType, id result) {
//            if (respondType == WebRespondTypeSuccess) {
//                //下载徽章配置
//                [JCWebDataRequst getBadgeConfigComplete:^(WebRespondType respondType, id result) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"alreadyRefreshBadge" object:nil];
//                }];
//            }
//        }];
//        JCMainTabBarController *controller = [JCMainTabBarController new];
        UITabBarController *controller = [[[JCStoryboardManager sharedManager] storyboardWithType:StoryboardTypeFind] instantiateViewControllerWithIdentifier:@"tabbar"];
        self.window.rootViewController = controller;
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isSaveUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        JCLoginViewController *loginVC = [[JCStoryboardManager storyboardForLogin] instantiateViewControllerWithIdentifier:SBID_LoginHomeVC];
        loginVC.fd_prefersNavigationBarHidden = YES;
        self.window.rootViewController = [[JCMainNavigationController alloc] initWithRootViewController:loginVC];
    }
    [self.window makeKeyAndVisible];
    /*
    if (isHaveLogin == NO) {
        self.startImageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
        self.startImageView.image = [UIImage imageNamed:@"luanch"];
        WSProgressHUD *hud = [WSProgressHUD showOnView:self.startImageView andString:@""];
        [hud showWithMaskType:WSProgressHUDMaskTypeClear];
        [self.window addSubview:self.startImageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"-LoginHomeShowAnimation-" object:nil];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud dismiss];
            [hud removeFromSuperview];
            [self.startImageView removeFromSuperview];
            self.startImageView = nil;
        });
    }
    
    if (isHaveLogin && isNeedWelcome == NO) {
        self.startImageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
        self.startImageView.image = [UIImage imageNamed:@"luanch"];
        WSProgressHUD *hud = [WSProgressHUD showOnView:self.startImageView andString:@""];
        [hud showWithMaskType:WSProgressHUDMaskTypeClear];
        
        [self.window addSubview:self.startImageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud dismiss];
            [hud removeFromSuperview];
            
            UIBezierPath *endMaskPath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:0.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
            UIBezierPath *startMaskPath =  [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:2*kHeight startAngle:0 endAngle:2*M_PI clockwise:YES];
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.path = endMaskPath.CGPath;
            self.startImageView.layer.mask = maskLayer;
            
            CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            maskLayerAnimation.fromValue = (__bridge id)(startMaskPath.CGPath);
            maskLayerAnimation.toValue = (__bridge id)((endMaskPath.CGPath));
            maskLayerAnimation.duration = 0.8;
            maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
            maskLayerAnimation.delegate = self;
        });
    }
    
    if (isNeedWelcome) {
        __weak typeof(self)weakSelf = self;
        self.welcome = [[[JCStoryboardManager sharedManager] storyboardWithType:StoryboardTypeLogin] instantiateViewControllerWithIdentifier:SBID_LoginWelcomeVC];
        [self.window addSubview:self.welcome.view];
        self.welcome.dismiss = ^{
            weakSelf.welcome = nil;
        };
    }
     */
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self.startImageView removeFromSuperview];
    self.startImageView = nil;
}

- (void)setupUnity3DForApplication:(UIApplication *)application
     didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
//    self.unityController = [[UnityAppController alloc] init];
//    [self.unityController application:application didFinishLaunchingWithOptions:launchOptions];
//    UnityGetMainWindow().hidden = YES;
}

- (void)touch_3D_config{
    
    // 创建标签的ICON图标。
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    // 创建一个标签，并配置相关属性。
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"Test" localizedTitle:@"3D-Touch" localizedSubtitle:@"-Test-" icon:icon userInfo:nil];
    // 将标签添加进Application的shortcutItems中。
    [UIApplication sharedApplication].shortcutItems = @[item];
}

/**
 清理异常数据
 */
- (void)clearErrorDB{

}

- (void)importAddressDB{
}

/**
 提前获取 相机 、麦克风、相册权限
 */
- (void)getAuthorization{
    
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    
    if (videoAuthStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
//                JCLog(@"获得摄像头授权");
            }else{
//                JCLog(@"用户拒绝摄像头");
            }
        }];
    }
    
    if (audioAuthStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted) {
//                JCLog(@"获得麦克风授权");
            }else{
//                JCLog(@"获得拒绝麦克风");
            }
        }];
    }
    
    if (photoAuthStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {///获得授权
//                JCLog(@"获得相册写入授权");
            }else{
//                JCLog(@"用户拒绝相册写入");
            }
        }];
    }
}
@end
