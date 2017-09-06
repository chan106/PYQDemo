//
//  UIImage+ImageFromView.m
//  CoolMove
//
//  Created by CA on 15/5/6.
//  Copyright (c) 2015年 CA. All rights reserved.
//

#import "UIImage+ImageFromView.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (ImageFromView)

+ (UIImage *)imageFromView:(UIView *)theView{
    
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, [UIScreen mainScreen].scale);
    [theView drawViewHierarchyInRect:theView.bounds afterScreenUpdates:YES];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r{
    
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, 4.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;
}

// 通过传入一张图片的名称,我还给你一张拉伸不变形的图片
+ (UIImage *)resizableImageName:(NSString *)imageName {
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    // 拉伸图片不变形
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef]: nil;
    
    return thumbnailImage;
}

+ (void)thumbnailImageForVideo:(NSURL *)videoURL withCompletionBlock:(ThumbnailBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        NSParameterAssert(asset);
        AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetImageGenerator.appliesPreferredTrackTransform = YES;
        assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGImageRef thumbnailImageRef = NULL;
            CFTimeInterval thumbnailImageTime = 0;
            NSError *thumbnailImageGenerationError = nil;
            thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
            
            if (!thumbnailImageRef) {
                
                NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
                
                if (block) {
                    block(NO, nil);
                }
                
            } else {
                UIImage *thumbnailImage = [[UIImage alloc] initWithCGImage:thumbnailImageRef];
                
                if (block) {
                    block(YES, thumbnailImage);
                }
            }
            
        });
    });
}
@end
