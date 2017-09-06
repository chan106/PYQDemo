//
//  AppDelegate.h
//  Victor
//
//  Created by Guo.JC on 17/2/13.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

#define kDB_VERSION 1

static NSString * const kStatusBarTappedNotification = @"statusBarTappedNotification";

@interface AppDelegate : UIResponder <UIApplicationDelegate,CAAnimationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIImageView *startImageView;

@end

