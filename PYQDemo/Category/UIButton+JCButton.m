//
//  UIButton+JCButton.m
//  Victor
//
//  Created by Guo.JC on 17/2/21.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "UIButton+JCButton.h"

@implementation UIButton (JCButton)
- (void)imageUpTitleDown{
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [self setTitleEdgeInsets:UIEdgeInsetsMake(1.5*self.imageView.frame.size.height ,-self.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(-0.5*self.imageView.frame.size.height, 0.0,0.0, -self.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    
}
@end
