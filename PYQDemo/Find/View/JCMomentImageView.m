//
//  JCMomentImageView.m
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/4.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCMomentImageView.h"
#import "JCMomentsModel.h"
#import "Masonry.h"
#import "YFPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JCMomentImageView ()

@property (nonatomic , strong) JCMomentsModel *model;
@property (nonatomic , strong) NSMutableArray *imageViewArray;

@end

@implementation JCMomentImageView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)setModelData:(JCMomentsModel *)model{
    _model = model;
    for (UIImageView *view in self.imageViewArray) {
        [view removeFromSuperview];
    }
    self.imageViewArray = [NSMutableArray array];
    NSInteger count = model.images.count;
    ///一张图
    if (count == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, model.singleImageSize.width, _model.singleImageSize.height)];
        NSString *urlString = _model.images.firstObject;
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                     placeholderImage:[UIImage imageNamed:@"placehold_image"]
                            completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                
                            }];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        [self.imageViewArray addObject:imageView];
        
        if (model.isLongImage) {
            UILabel *tipLabel = [UILabel new];
            tipLabel.backgroundColor = UIColorFromHex(0x8599C5);
            tipLabel.textColor = [UIColor whiteColor];
            tipLabel.font = [UIFont systemFontOfSize:12];
            tipLabel.textAlignment = NSTextAlignmentRight;
            tipLabel.text = @"长图";
            [tipLabel sizeToFit];
            CGRect frame = tipLabel.frame;
            frame.origin = CGPointMake(imageView.bounds.size.width - frame.size.width, imageView.bounds.size.height - frame.size.height);
            tipLabel.frame = frame;
            [imageView addSubview:tipLabel];
        }
    }
    ///2、3、5、6张图
    else if (count == 2 || count == 3 ||  count == 5 || count == 6 || count > 6){
        if (count > 6) {
            count = 6;
        }
        for (NSInteger i = 0; i < count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i>=3?i-3:i%3)*(kImageHeight+4), 0+(i/3 * (kImageHeight+4)), kImageHeight, kImageHeight)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.images[i]]
                         placeholderImage:[UIImage imageNamed:@"placehold_image"]
                                completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            [self addSubview:imageView];
            [self.imageViewArray addObject:imageView];
        }
    }
    ///4张图
    else if (count == 4){///四张图
        for (NSInteger i = 0; i < 4; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%2)*(kImageHeight+4), 0+((i/2) * (kImageHeight+4)), kImageHeight, kImageHeight)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.images[i]]
                         placeholderImage:[UIImage imageNamed:@"placehold_image"]
                                completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageView addGestureRecognizer:tap];
            [self addSubview:imageView];
            [self.imageViewArray addObject:imageView];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    sender.view.contentMode = UIViewContentModeScaleAspectFit;
    sender.view.clipsToBounds = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.view.contentMode = UIViewContentModeScaleAspectFill;
        sender.view.clipsToBounds = YES;
    });
    [YFPhotoBrowser browserUrlImages:_model.images fromView:sender.view selectIndex:sender.view.tag];
}

@end
