//
//  JCBaseViewController.h
//  Victor
//
//  Created by Guo.JC on 17/2/13.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCUserManager.h"
@class JCAlertView;

@interface JCBaseViewController : UIViewController
@property (nonatomic, strong) UIButton *leftBarButton;
-(void)viewWillBack;

/**
 弹出对话框
 */
- (void)showAlertView:(NSString *)message tapDone:(void(^)(void)) completion;

/**
 弹出消息
 */
- (void)alertMessage:(NSString *)message;

/**
 弹出消息对话框
 */
- (void)alertMessage:(NSString *)message
           tapButton:(NSString *)buttonTitle
          completion:(void(^)(void)) completion;

/**
 弹出消息对话框(带两个button)
 */
- (void)alertMessage:(NSString *)message
          leftButton:(NSString *)leftTitle
      leftTapHandler:(void (^)(void))leftHandler
         rightButton:(NSString *)rightTitle
     rightTapHandler:(void (^)(void))rightHandler;
/**
 弹出消息对话框(带两个button),不带默认title
 */
- (void)alertTitle:(NSString *)title
           message:(NSString *)message
        leftButton:(NSString *)leftTitle
    leftTapHandler:(void (^)(void))leftHandler
       rightButton:(NSString *)rightTitle
   rightTapHandler:(void (^)(void))rightHandler;
/**
 时间戳转时间（HH:mm 格式）
 */
- (NSString *)timeWithTimeIntervalString:(NSInteger)timestamp;

/**
 阿拉伯数字转大写
 */
- (NSString *)convertToStringWithIndex:(NSInteger )value;

/**
 卡洛里消耗计算
 */
- (CGFloat)calorieCaculate:(Gender) sex
                         age:(NSInteger) age
                      weight:(NSInteger) weight
                        time:(CGFloat) time
                   sportfuel:(CGFloat) sportfuel;

#pragma mark 生成image
- (void)makeImageWithView:(UIView *)view withSize:(CGSize)size  complete:(void (^)(UIImage *image))complete;
- (void)shareImage:(UIImage *)image;

/**
 顶部滚回到顶提示
 */
- (void)showTopScrollTipWithOffset:(CGFloat)offsetY
                             touch:(void(^)(void)) complete;

/**
 空数据提示
 */
- (void)showEmptyDataTip:(BOOL)state;

/**
 断网提示
 */
- (void)showNetErrorTip:(BOOL)state;

@end
