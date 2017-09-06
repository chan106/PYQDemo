//
//  YFPhotoBrowser.m
//  PhotoManager
//
//  Created by Coollang on 2017/9/4.
//  Copyright © 2017年 Coollang-YF. All rights reserved.
//

#import "YFPhotoBrowser.h"

@implementation YFPhotoBrowser


+ (YFPhotoBrowser *)browserIDMImages:(NSArray <IDMPhoto *>*)photos fromView:(UIView *)view selectIndex:(NSInteger)index {
    if (photos.count <= 0 ) {
        return nil;
    }
    YFPhotoBrowser *browser = [[YFPhotoBrowser alloc] initWithPhotos:photos animatedFromView:view];
    [browser customizeAppearanceWithIsMutiple:(photos.count > 1)];
    if (index < 0) {
        index = 0;
    }else if (index >= photos.count){
        index = photos.count - 1;
    }
    [browser setInitialPageIndex:index];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:browser animated:YES completion:^{
        [browser setValue:[UIColor whiteColor] forKeyPath:@"_actionButton.tintColor"];
    }];
    
    return browser;
    
}

+ (IDMPhotoBrowser *)browserUrlImages:(NSArray <NSURL *>*)imageUrls fromView:(UIView *)view selectIndex:(NSInteger)index {
    
    if (imageUrls.count <= 0 ) {
        return nil;
    }
    NSArray *photos = [IDMPhoto photosWithURLs:imageUrls];
    return [YFPhotoBrowser browserIDMImages:photos fromView:view selectIndex:index];
}

+ (IDMPhotoBrowser *)browserImages:(NSArray <UIImage *>*)images fromView:(UIView *)view selectIndex:(NSInteger)index {
    if (images.count <= 0 ) {
        return nil;
    }
    NSArray *photos = [IDMPhoto photosWithImages:images];
    return [YFPhotoBrowser browserIDMImages:photos fromView:view selectIndex:index];
}


- (void)customizeAppearanceWithIsMutiple:(BOOL)isMutiplePhotos {
    if (isMutiplePhotos == YES) {
        self.leftArrowImage = [YFPhotoBrowser imageFromYFPhotoBrowserbundleWith:@"btn_common_back_wh"];
        self.rightArrowImage = [YFPhotoBrowser imageFromYFPhotoBrowserbundleWith:@"btn_common_forward_wh"];
        self.displayArrowButton = YES;
        self.displayCounterLabel = YES;
    }
    self.doneButtonRightInset = [UIScreen mainScreen].bounds.size.width - 50;
    self.doneButtonImage = [YFPhotoBrowser imageFromYFPhotoBrowserbundleWith:@"btn_common_close_wh"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setValue:[UIColor whiteColor] forKeyPath:@"_actionButton.tintColor"];
}

+ (UIImage *)imageFromYFPhotoBrowserbundleWith:(NSString *)imageName {
    if ([imageName hasSuffix:@".png"]) {
        imageName = [NSString stringWithFormat:@"YFPhotoBrowser.bundle/images/%@",imageName];
    }else {
        imageName = [NSString stringWithFormat:@"YFPhotoBrowser.bundle/images/%@.png",imageName];
    }
    return  [UIImage imageNamed:imageName];
}

@end
