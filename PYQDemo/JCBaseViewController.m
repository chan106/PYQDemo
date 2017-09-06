//
//  JCBaseViewController.m
//  Victor
//
//  Created by Guo.JC on 17/2/13.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCBaseViewController.h"
#import "NSDate+FormateString.h"
#import "UIImage+ImageFromView.h"
#import "UIButton+JCButton.h"

@interface JCBaseViewController ()

@property (nonatomic, strong) UIButton *scrollTopButton;
@property (nonatomic, copy) void(^showScrollTopTipComplete)(void);
@property (nonatomic, strong) UILabel *emptyDataTipLabel;
@property (nonatomic, strong) UIImageView *netErrorTipImageView;

@end

@implementation JCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([[self.navigationController viewControllers] count] > 1) {
        [self resetBackBarButton];
    }
    
}

-(void)viewWillBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置返回按钮
- (void)resetBackBarButton
{
    _leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBarButton.frame = CGRectMake(0, 0, 30, 40);
    
    [_leftBarButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    
    [_leftBarButton addTarget:self action:@selector(viewWillBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_leftBarButton];
    //用于调整返回按钮的位置
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -15;
    self.navigationItem.leftBarButtonItems = @[space_item, item];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 弹出对话框
 */
- (void)showAlertView:(NSString *)message tapDone:(void(^)(void)) completion{
    
//    JCAlertView *alert = [JCAlertView alertViewWithTitle:LOCATION(@"Notice") message:message];
//    JCActionButton *button = [JCActionButton actionWithTitle:LOCATION(@"OK") actionType:JCActionButtonTypeDefault handle:^(id obj) {
//        if (completion) {
//            completion();
//        }
//    }];
//    JCActionButton *cancelButton = [JCActionButton actionWithTitle:@"下次再说" actionType:JCActionButtonTypeCancel handle:nil];
//    [alert addActionButton:cancelButton];
//    [alert addActionButton:button];
//    [alert showAlertView];
}

- (void)alertMessage:(NSString *)message{
    
//    JCAlertView *alert = [JCAlertView alertViewWithTitle:LOCATION(@"Notice") message:message];
//    [alert showAlertView];
}

- (void)alertMessage:(NSString *)message
           tapButton:(NSString *)buttonTitle
          completion:(void(^)(void)) completion{
//    
//    JCAlertView *alert = [JCAlertView alertViewWithTitle:LOCATION(@"Notice") message:message];
//    JCActionButton *button = [JCActionButton actionWithTitle:LOCATION(@"OK") actionType:JCActionButtonTypeDefault handle:^(id obj) {
//        if (completion) {
//            completion();
//        }
//    }];
//    [alert addActionButton:button];
//    [alert showAlertView];
}

- (void)alertMessage:(NSString *)message
          leftButton:(NSString *)leftTitle
      leftTapHandler:(void (^)(void))leftHandler
         rightButton:(NSString *)rightTitle
     rightTapHandler:(void (^)(void))rightHandler{
    
//    JCAlertView *alert = [JCAlertView alertViewWithTitle:LOCATION(@"Notice") message:message];
//    JCActionButton *leftButton = [JCActionButton actionWithTitle:leftTitle actionType:JCActionButtonTypeCancel handle:^(id obj) {
//        if (leftHandler) {
//            leftHandler();
//        }
//    }];
//    JCActionButton *rightButton = [JCActionButton actionWithTitle:rightTitle actionType:JCActionButtonTypeDefault handle:^(id obj) {
//        if (rightHandler) {
//            rightHandler();
//        }
//    }];
//    [alert addActionButton:leftButton];
//    [alert addActionButton:rightButton];
//    [alert showAlertView];
}

- (void)alertTitle:(NSString *)title
           message:(NSString *)message
        leftButton:(NSString *)leftTitle
    leftTapHandler:(void (^)(void))leftHandler
       rightButton:(NSString *)rightTitle
   rightTapHandler:(void (^)(void))rightHandler {
    
//    JCAlertView *alert = [JCAlertView creatAlertViewWithTitle:title message:message];
//    JCActionButton *cancelButton = [JCActionButton actionWithTitle:leftTitle actionType:JCActionButtonTypeCancel handle:nil];
//    [JCActionButton actionWithTitle:leftTitle actionType:JCActionButtonTypeCancel handle:^(id obj) {
//        if (leftHandler) {
//            leftHandler();
//        }
//    }];
//    
//    JCActionButton *doneButton = [JCActionButton actionWithTitle:rightTitle actionType:JCActionButtonTypeDefault handle:^(id obj) {
//        if (rightHandler) {
//            rightHandler();
//        }
//    }];
//    [alert addActionButton:cancelButton];
//    [alert addActionButton:doneButton];
//    [alert showAlertView];
//    [[UIApplication sharedApplication].keyWindow addSubview:alert];
}

- (NSString *)timeWithTimeIntervalString:(NSInteger)timestamp{
    NSString* dateString = [NSDate timeWithTimeIntervalString:timestamp formatter:@"HH:mm"];
    return dateString;
}

- (NSString *)convertToStringWithIndex:(NSInteger )value{
    
    NSString *string;
    if (value >= 10 && value < 100) {
        if (value == 10) {
            string = @"十";
        }else{
            
            NSString *tenString;
            if (value / 10 == 1) {
                tenString = @"十";
            }else{
                tenString = [self convertToStringWithValue:value/10 unit:@"十"];
            }
            NSString *geString = [self convertToStringWithValue:value%10 unit:@""];
            string = [tenString stringByAppendingString:geString];
        }
    }else{
        string = [self convertToStringWithValue:value unit:@""];
    }
    return string;
}

- (NSString *)convertToStringWithValue:(NSInteger)value unit:(NSString *)unit{
    switch (value) {
        case 0:
            return @"";
            break;
        case 1:
            return [NSString stringWithFormat:@"一%@",unit];
            break;
        case 2:
            return [NSString stringWithFormat:@"二%@",unit];
            break;
        case 3:
            return [NSString stringWithFormat:@"三%@",unit];
            break;
        case 4:
            return [NSString stringWithFormat:@"四%@",unit];
            break;
        case 5:
            return [NSString stringWithFormat:@"五%@",unit];
            break;
        case 6:
            return [NSString stringWithFormat:@"六%@",unit];
            break;
        case 7:
            return [NSString stringWithFormat:@"七%@",unit];
            break;
        case 8:
            return [NSString stringWithFormat:@"八%@",unit];
            break;
        case 9:
            return [NSString stringWithFormat:@"九%@",unit];
            break;
        case 10:
            return @"十";
            break;
        default:
            break;
    }
    return @"";
}

- (CGFloat)calorieCaculate:(Gender) sex
                       age:(NSInteger) age
                    weight:(NSInteger) weight
                      time:(CGFloat) time
                 sportfuel:(CGFloat) sportfuel{
    float x1,x2;
    float kcal;
    float ftime;
    if(sex == GenderFemale)
    {
        if(age < 31)
        {
            x1 = 14.6f;
            x2 = 450;
        }
        else if(age <61)
        {
            x1 = 8.6f;
            x2 = 830;
        }
        else
        {
            x1 = 10.4f;
            x2 = 600;
        }
    }
    else
    {
        if(age < 31)
        {
            x1 = 15.2f;
            x2 = 680;
        }
        else if(age <61)
        {
            x1 = 11.5f;
            x2 = 830;
        }
        else
        {
            x1 = 13.4f;
            x2 = 490;
        }
    }
    if(weight>100)
        weight = 100;
    ftime = time/60;
    kcal = ((x1 * weight + x2) * sportfuel * ftime );
    return kcal;
}

#pragma mark 生成image分享
- (void)makeImageWithView:(UIView *)view withSize:(CGSize)size  complete:(void (^)(UIImage *image))complete{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        UIImage *image = [UIImage imageFromView:view
                                        atFrame:CGRectMake(0, 0, size.width , size.height)];
        NSData *data = UIImagePNGRepresentation(image);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"-shareImage-"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(image);
            }
        });
    });
}


- (void)shareTo:(UIButton *)sender{
 
    [sender.superview.superview removeFromSuperview];

//    switch (sender.tag) {
//        case 0:{
//            [self shareImageType:SSDKPlatformSubTypeWechatSession];
//        }
//            break;
//        case 1:{
//            [self shareImageType:SSDKPlatformSubTypeWechatTimeline];
//        }
//            break;
//        case 2:{
//            [self shareImageType:SSDKPlatformSubTypeQQFriend];
//        }
//            break;
//        case 3:{
//            [self shareImageType:SSDKPlatformSubTypeQZone];
//        }
//            break;
//            
//        default:
//            break;
//    }
}

//- (void)shareImageType:(SSDKPlatformType )type{
//    
//    UIImage *image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"-shareImage-"]];
//    //创建分享参数
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:@"VICTOR"
//                                     images:@[image] //传入要分享的图片
//                                        url:nil//[NSURL URLWithString:@"http://www.victorsport.com.cn"]
//                                      title:@"VICTOR"
//                                       type:SSDKContentTypeAuto];
//    
//    //进行分享
//    [ShareSDK share:type //传入分享的平台类型
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
//         switch (state) {
//             case SSDKResponseStateSuccess:{
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                     message:nil
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                 break;
//             }
//             case SSDKResponseStateFail:{
//                 NSString *showString = error.userInfo[@"error_message"];
//                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                 message:showString
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"OK"
//                                                       otherButtonTitles:nil, nil];
//                 [alert show];
//                 break;
//             }
//             default:
//                 break;
//         }
//     }];
//}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    UIView *shareView = sender.view;
    shareView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:.5 animations:^{
        CGRect frame = shareView.frame;
        frame.origin.y = kHeight;
        shareView.frame = frame;
        
    } completion:^(BOOL finished) {
        [shareView removeFromSuperview];
    }];
}

- (void)shareImage:(UIImage *)image{
    //
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *blackView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    [blackView addGestureRecognizer:tapGesture];
    [keyWindow addSubview:blackView];
    
    CGFloat width = kWidth / 4.0;
    CGFloat height = 0.2 * kHeight;
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - height, kWidth, height)];
    toolView.backgroundColor = [UIColor whiteColor];
    [blackView addSubview:toolView];
    
    NSArray *imageName = @[@"微信",@"朋友圈",@"QQ",@"空间"];
    NSMutableArray *btns = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, height, width, height);
        [btn setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
        [btn setTitle:imageName[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
        [btn imageUpTitleDown];
        btn.tag = i;
        [toolView addSubview:btn];
        [btn addTarget:self action:@selector(shareTo:) forControlEvents:UIControlEventTouchUpInside];
        [btns addObject:btn];
    }
    for (UIButton *btn in btns) {
        CGRect frame = btn.frame;
        frame.origin.y = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(arc4random()%30*0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btn.frame = frame;
            } completion:nil];
        });
    }
}

/**
 顶部滚回到顶提示
 */
- (void)showTopScrollTipWithOffset:(CGFloat)offsetY
                             touch:(void(^)(void)) complete{
    
    if (_scrollTopButton == nil) {
        _scrollTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scrollTopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_scrollTopButton setBackgroundColor:[UIColor blackColor]];
        _scrollTopButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [_scrollTopButton setTitle:@"点击回滚到顶部" forState:UIControlStateNormal];
        [_scrollTopButton addTarget:self action:@selector(tapScrollTop:) forControlEvents:UIControlEventTouchUpInside];
        _scrollTopButton.frame = CGRectMake(0, 0, kWidth, 20);
    }
    
    if (offsetY > kHeight) {
        [[UIApplication sharedApplication].keyWindow addSubview:_scrollTopButton];
        [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelAlert;
    }else{
        [_scrollTopButton removeFromSuperview];
        [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelNormal;
    }
    _showScrollTopTipComplete = complete? complete : _showScrollTopTipComplete;
}

- (void)tapScrollTop:(UIButton *)sender{
    [sender removeFromSuperview];
    if (_showScrollTopTipComplete) {
        _showScrollTopTipComplete();
    }
}

/**
 空数据提示
 */
- (void)showEmptyDataTip:(BOOL)state{

    if (_emptyDataTipLabel == nil) {
        _emptyDataTipLabel = [UILabel new];
        _emptyDataTipLabel.textColor = UIColorFromHex(0x999999);
        _emptyDataTipLabel.font = [UIFont systemFontOfSize:32];
//        _emptyDataTipLabel.text = LOCATION(@"EmptyDataTipText");
        [_emptyDataTipLabel sizeToFit];
        _emptyDataTipLabel.center = self.view.center;
        _emptyDataTipLabel.hidden = YES;
        [self.view addSubview:_emptyDataTipLabel];
    }
    
    if (state) {
        _emptyDataTipLabel.hidden = NO;
    }else{
        _emptyDataTipLabel.hidden = YES;
    }
}

/**
 断网提示
 */
- (void)showNetErrorTip:(BOOL)state{
    if (_netErrorTipImageView == nil) {
        _netErrorTipImageView = [UIImageView new];
        _netErrorTipImageView.image = [UIImage imageNamed:@"netError"];
        [_netErrorTipImageView sizeToFit];
        _netErrorTipImageView.center = self.view.center;
        _netErrorTipImageView.hidden = YES;
        [self.view addSubview:_netErrorTipImageView];
    }
    
    if (state) {
        _netErrorTipImageView.hidden = NO;
    }else{
        _netErrorTipImageView.hidden = YES;
    }
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
