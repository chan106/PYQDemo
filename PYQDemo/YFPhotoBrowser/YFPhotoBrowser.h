//
//  YFPhotoBrowser.h
//  PhotoManager
//
//  Created by Coollang on 2017/9/4.
//  Copyright © 2017年 Coollang-YF. All rights reserved.
//

#import <IDMPhotoBrowser/IDMPhotoBrowser.h>

@interface YFPhotoBrowser : IDMPhotoBrowser

- (void)customizeAppearanceWithIsMutiple:(BOOL)isMutiplePhotos;

// 快速展示图片方法
+ (IDMPhotoBrowser *)browserIDMImages:(NSArray <IDMPhoto *>*)photos fromView:(UIView *)view selectIndex:(NSInteger)index;

+ (IDMPhotoBrowser *)browserUrlImages:(NSArray <NSURL *>*)imageUrls fromView:(UIView *)view selectIndex:(NSInteger)index;

+ (IDMPhotoBrowser *)browserImages:(NSArray <UIImage *>*)images fromView:(UIView *)view selectIndex:(NSInteger)index;

@end
