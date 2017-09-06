//
//  JCLogAccount.m
//  Victor
//
//  Created by coollang on 17/2/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCLogAccount.h"
//#import "JCChangePassWord.h"
//#import "JCMainTabBarController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
//#import "WSProgressHUD.h"
#import "JCWebDataRequst.h"
#import "NSDate+FormateString.h"
//#import "JCStoryboardManager.h"
//#import "LSLoginHelper.h"
#import <AudioToolbox/AudioToolbox.h>
#import <pop/pop.h>
#import "MBProgressHUD.h"
#import "JCWebDataRequst.h"
#import "JCWebDataRequst+Find.h"
#import "JCWebDataRequst+Login.h"
#import "JCStoryboardManager.h"
#import "JCRankingListViewController.h"
#import "JCMainNavigationController.h"


#define kPasswordLength  3

@interface JCLogAccount ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UIButton *watchPass;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//@property (strong, nonatomic) WSProgressHUD *hud;

@end

@implementation JCLogAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL isPassTF = textField == _passwordInput ? YES : NO;
    NSInteger location = range.location;
    
    if (isPassTF) {///密码输入
        if ((location >= kPasswordLength - 1 && ![string isEqualToString:@""] && _phoneInput.text.length == 11) || (location > kPasswordLength - 1 && _phoneInput.text.length == 11)) {
            _loginBtn.enabled = YES;
        }else{
            _loginBtn.enabled = NO;
        }
//        JCLog(@"%ld , %ld ----- %@",range.location,range.length,string);
        return YES;
    }else{///手机号输入
     
        if ((location == 10 && ![string isEqualToString:@""] && _passwordInput.text.length >= kPasswordLength) || (location == 11 && _passwordInput.text.length >= kPasswordLength)) {
            _loginBtn.enabled = YES;
        }else{
            _loginBtn.enabled = NO;
        }
     
//        JCLog(@"%ld , %ld ----- %@",range.location,range.length,string);
        if (range.location <= 10) {
            return YES;
        }
        return NO;
    }
}

/**
 *  手机注册
 */
- (IBAction)phoneRegister:(UIButton *)sender {
    
//    JCRegisterAccount *registerVC = [[JCStoryboardManager storyboardForLogin] instantiateViewControllerWithIdentifier:SBID_LoginRegisterVC];
//    registerVC.isPresent = _isPresent;
//    registerVC.fd_prefersNavigationBarHidden = YES;
//    [self.navigationController pushViewController:registerVC animated:YES];
}

/**
 *  忘记密码
 */
- (IBAction)forgetPass:(UIButton *)sender {
//    JCChangePassWord *changePass = [[JCStoryboardManager storyboardForLogin] instantiateViewControllerWithIdentifier:SBID_LoginChangePSWVC];
//    changePass.isPresent = _isPresent;
//    changePass.fd_prefersNavigationBarHidden = YES;
//    [self.navigationController pushViewController:changePass animated:YES];
}


/**
 *  查看密码
 */
- (IBAction)watchPassAction:(UIButton *)sender {
    self.passwordInput.secureTextEntry = !self.passwordInput.secureTextEntry;
    sender.selected = !sender.selected;
}

/**
 *  登录
 */
- (IBAction)loginAcount:(UIButton *)sender {
    
    [_phoneInput resignFirstResponder];
    [_passwordInput resignFirstResponder];
    
//    if (![LSLoginHelper validatePhone:_phoneInput.text]) {
//        [self.hud showString:@"请输入正确格式的手机号码" dimissAfterSecond:1];
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        return;
//    }
    
    __weak __typeof(self)weakSelf = self;
//    [self.hud showWithMaskType:WSProgressHUDMaskTypeClear];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    
    [JCWebDataRequst accountLoginWithAcount:self.phoneInput.text
                                   password:self.passwordInput.text
                                   complete:^(WebRespondType respondType, id result) {
        
        if (respondType == WebRespondTypeSuccess) {
//            [weakSelf.hud showWithString:kMsgLoginSuccess];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            ///登录成功，刷新个人信息数据
//            [JCWebDataRequst getUserInfo:^(WebRespondType respondType, id result) {
//                if (respondType == WebRespondTypeSuccess) {
//                    [weakSelf.hud dismiss];
//                    if (_isPresent) {
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                    }
//                    else{
//                        [UIApplication sharedApplication].keyWindow.rootViewController = [JCMainTabBarController new];
//                    }
//                }
//                else{
//                    [weakSelf.hud showString:kMsgNetError dimissAfterSecond:1];
//                }
//            }];
            UITabBarController *controller = [[[JCStoryboardManager sharedManager] storyboardWithType:StoryboardTypeFind] instantiateViewControllerWithIdentifier:@"tabbar"];
            [UIApplication sharedApplication].keyWindow.rootViewController = controller;
        }
        else if (respondType == WebRespondTypeDataIsNil){
//            [weakSelf.hud dismiss];
//            [weakSelf.hud showErrorWithString:@"密码错误" dimissAfterSecond:1];
            [weakSelf loginBtnShake];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        else if (respondType == WebRespondTypeNoUser){
//            [weakSelf.hud showString:kMsgNoUser dimissAfterSecond:1];
        }
        else if (respondType == WebRespondTypeNotLogin){
//            [weakSelf.hud showString:kMsgNoUser dimissAfterSecond:1];
        }
        else if (respondType == WebRespondTypeTimeOut){
//            [weakSelf.hud showString:kMsgNetError dimissAfterSecond:1];
        }
        else if (respondType == WebRespondTypeVerifyCodeWrong){
//            [weakSelf.hud showString:kMsgVerifyCodeError dimissAfterSecond:1];
        }
        else if (respondType == WebRespondTypeInvalidToken){
//            [weakSelf.hud showString:@"非法设备!" dimissAfterSecond:1];
        }
        else if (respondType == WebRespondTypeMobServerError){
//            [weakSelf.hud showString:kMsgFail dimissAfterSecond:1];
        }else{
//            [weakSelf.hud showString:@"网络错误" dimissAfterSecond:1];
        }
    }];
}

- (void)loginBtnShake{
    _loginBtn.userInteractionEnabled = NO;
    [_loginBtn setTitle:@"密码错误!" forState:UIControlStateNormal];
    // 初始化弹簧动画
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    springAnimation.velocity = @(800);
    springAnimation.springSpeed         = 30;                    // 设置动画速度(常用)
    springAnimation.springBounciness    = 30;                   // 设置弹性大小(常用)
    // springAnimation.dynamicsFriction    = 10;                // 设置阻止弹性的阻力(选用)
    // springAnimation.dynamicsTension     = 100;               // 设置弹性的张力(可以理解为每次变大的程度, 选用)
    
    // 添加动画
    [self.loginBtn.layer pop_addAnimation:springAnimation forKey:nil];
    [springAnimation setCompletionBlock:^(POPAnimation *animation, BOOL state){
        _loginBtn.userInteractionEnabled = YES;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }];
}

/**
 *  返回上级页面
 */
- (IBAction)dismissAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  取消所有键盘响应
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj resignFirstResponder];
    }];
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
