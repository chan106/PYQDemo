//
//  UIImage+ImageFromView.h
//  CoolMove
//
//  Created by CA on 15/5/6.
//  Copyright (c) 2015年 CA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ThumbnailBlock)(BOOL success, UIImage *image);
@interface UIImage (ImageFromView)
+ (UIImage *)imageFromView:(UIView *)theView;
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;

// 通过传入一张图片的名称,我还给你一张拉伸不变形的图片
+ (UIImage *)resizableImageName:(NSString *)imageName;

// 根据视频地址生成缩略图
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

+ (void)thumbnailImageForVideo:(NSURL *)videoURL withCompletionBlock:(ThumbnailBlock)block;
@end
