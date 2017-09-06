//
//  JCLoginViewController.m
//  Victor
//
//  Created by coollang on 17/2/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCLoginViewController.h"
#import "JCLogAccount.h"
//#import "UIImageView+WebCache.h"
//#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "JCUserManager.h"
//#import "JCMainTabBarController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import <QuartzCore/QuartzCore.h>
#import "JCStoryboardManager.h"
//#import "JCStoryboardManager.h"

@interface JCLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *wechatLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherLoginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnTopConstraint;
@property (strong, nonatomic) CALayer *layer;
//@property (strong, nonatomic) WSProgressHUD *hud;

@end

@implementation JCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAnimationAfter) name:@"-LoginHomeShowAnimation-" object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showAnimation:0.1];
}

- (void)showAnimationAfter{
    [self showAnimation:0.6];
}

- (void)showAnimation:(CGFloat)after{
    _logoBottomConstraint.constant = 500;
    _loginBtnTopConstraint.constant = 500;
    if (_layer) {
        [_layer removeFromSuperlayer];
        _layer = nil;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _logoBottomConstraint.constant = 110;
        _loginBtnTopConstraint.constant = 120;
        [UIView animateWithDuration: 0.5
                              delay: 0
             usingSpringWithDamping: 0.5
              initialSpringVelocity: 10
                            options: UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations: ^{
                                [self.view layoutIfNeeded];
                            } completion:^(BOOL finished) {
                                CGFloat width = 281;
                                CGFloat height = 48;
                                CGFloat radius = 0.5*height;
                                UIBezierPath *path = [UIBezierPath bezierPath];
                                [path moveToPoint:CGPointMake(radius, 0)];
                                [path addLineToPoint:CGPointMake(width - radius, 0)];
                                [path addArcWithCenter:CGPointMake(width - radius, radius) radius:radius startAngle:- M_PI_2 endAngle:M_PI_2 clockwise:YES];
                                [path addLineToPoint:CGPointMake(radius, height)];
                                [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
                                CAShapeLayer *layer = [CAShapeLayer new];
                                _layer = layer;
                                layer.fillColor = [UIColor clearColor].CGColor;
                                layer.strokeColor = UIColorFromHex(0x999999).CGColor;
                                layer.lineCap = kCALineCapSquare;
                                layer.lineWidth = 2;
                                layer.frame = _otherLoginBtn.bounds;
                                [_otherLoginBtn.layer addSublayer:layer];
                                layer.path = path.CGPath;
                                
                                CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                                pathAnimation.duration = 0.8;
                                pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
                                pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
                                [layer addAnimation:pathAnimation forKey:nil];
                                
                                //                                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
                                //                                view.layer.cornerRadius = 2;
                                //                                view.layer.masksToBounds = YES;
                                //                                view.backgroundColor = [UIColor whiteColor];
                                //                                [_otherLoginBtn addSubview:view];
                                
                                //                                CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
                                //                                animation.calculationMode = kCAAnimationPaced;
                                //                                animation.fillMode = kCAFillModeForwards;
                                //                                animation.removedOnCompletion = NO;
                                //                                animation.duration = .8;
                                //                                animation.repeatCount = 1;
                                //                                animation.path = path.CGPath;
                                //                                [view.layer addAnimation:animation
                                //                                                  forKey:@"moveTheSquare"];
                            }];
    });
}

- (void)initUI{
    _wechatLoginBtn.layer.cornerRadius = 24;
    _wechatLoginBtn.layer.masksToBounds = YES;
}

//第三方登录
//- (void)loginByThirdPlatform:(SSDKPlatformType)type {
//    
//    __weak typeof(self) weakSelf = self;
////    [self.hud showWithMaskType:WSProgressHUDMaskTypeClear];
//    
//    [ShareSDK getUserInfo:type
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
//               
//         if (state == SSDKResponseStateSuccess){
//             NSDictionary *params = @{@"openId":user.credential.uid,
//                                      @"token":user.credential.token,
//                                      @"type":@"2",
//                                      @"device":@"ios",
//                                      @"version":@"1"};
//             ///第三方登录请求
//             [JCWebDataRequst loginByThirdPlatformParams:params
//                                                complete:^(WebRespondType respondType, id result) {
//                                                    
//                 if (respondType == WebRespondTypeSuccess) {
//                     ///刷新个人数据
//                     [JCWebDataRequst getUserInfo:^(WebRespondType respondTypeUserInfo, id resultOfUserInfo) {
//                         if (respondTypeUserInfo == WebRespondTypeSuccess) {
//                             [weakSelf.hud dismiss];
////                             JCUser *user = [JCUser currentUer];
////                             JCLog(@" \n\n *********>>>>>>>> %@",user);
//                             [UIApplication sharedApplication].keyWindow.rootViewController = [JCMainTabBarController new];
//                         }
//                         else{
//                             [weakSelf.hud showErrorWithString:@"请稍后再试" dimissAfterSecond:1];
//                         }
//                     }];
//                 }
//                 else{
//                     [weakSelf.hud showErrorWithString:@"请稍后再试" dimissAfterSecond:1];
//                 }
//             }];
//         }
//         
//         else if(state == SSDKResponseStateFail){
//             [weakSelf.hud showErrorWithString:@"登录失败" dimissAfterSecond:1];
//         }
//         
//         else if(state == SSDKResponseStateCancel){
//             [weakSelf.hud showErrorWithString:@"取消登录" dimissAfterSecond:1];
//         }
//     }];
//}

- (void)pushRootViewControllerLosinSuccess:(BOOL)success {
    if (success) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kYFLoginStatusChangeNotification object:@"登录成功"];
    }
} 

/**
 *  微信登录
 */
//- (IBAction)wechatLogin:(UIButton *)sender {
//    
//    [self loginByThirdPlatform:SSDKPlatformTypeWechat];
//}


/**
 *  其他登录方式
 */
- (IBAction)otherLogin:(UIButton *)sender {
    JCLogAccount *acountLogin = [[JCStoryboardManager storyboardForLogin] instantiateViewControllerWithIdentifier:SBID_LoginAccountVC];
//    acountLogin.fd_prefersNavigationBarHidden = YES;
    [self.navigationController pushViewController:acountLogin animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"-LoginHomeShowAnimation-" object:nil];
//    JCLog(@"释放登录界面");
}

//- (WSProgressHUD *)hud{
//    
//    if (_hud == nil) {
//        _hud = [WSProgressHUD showOnView:self.view andString:@""];
//        [_hud dismiss];
//    }
//    return _hud;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
