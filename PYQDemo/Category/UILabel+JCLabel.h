//
//  UILabel+JCLabel.h
//  LabelDemo
//
//  Created by Guo.JC on 17/2/16.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JCLabel)

- (void)setValue:(NSString *)value
       valueFont:(NSInteger)valueFont
      valueColor:(UIColor *)valueColor
            unit:(NSString *)unit
        unitFont:(NSInteger)unitFont
       unitColor:(UIColor *)unitColor;



@end
