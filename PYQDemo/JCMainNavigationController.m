//
//  JCMainNavigationController.m
//  Victor
//
//  Created by Guo.JC on 17/2/13.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCMainNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface JCMainNavigationController ()

@end

@implementation JCMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.tintColor = UIColorFromHex(0xf0f0f0);//导航栏item颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromHex(0xf0f0f0),NSFontAttributeName:[UIFont systemFontOfSize:18]};//导航栏标题文字
    UINavigationBar *bar = self.navigationBar;
    bar.translucent = NO;
    [self.navigationBar setBackgroundImage:[self imageWithGradientColor:UIColorFromHex(0x312a54) toColor:kThemeBackColor size:CGSizeMake(kWidth, 64)]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
}

//截取图片的某一部分
- (UIImage *)clipImage:(UIImage *)image inRect:(CGRect)rect{
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}

/**
 创建纯色图片
 */
- (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0,0,1,1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(content,[color CGColor]);
    CGContextFillRect(content,rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 创建渐变色图片
 */
- (UIImage*)imageWithGradientColor:(UIColor*)color toColor:(UIColor *)toColor size:(CGSize)size{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)color.CGColor,
                       (id)toColor.CGColor, nil];
    [view.layer addSublayer:gradient];

    UIImage *image = [self makeImageWithView:view withSize:size];
    return image;
}

#pragma mark 生成image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}


@end
