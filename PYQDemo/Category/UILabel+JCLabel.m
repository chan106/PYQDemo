//
//  UILabel+JCLabel.m
//  LabelDemo
//
//  Created by Guo.JC on 17/2/16.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "UILabel+JCLabel.h"

@implementation UILabel (JCLabel)

- (void)setValue:(NSString *)value
       valueFont:(NSInteger)valueFont
      valueColor:(UIColor *)valueColor
            unit:(NSString *)unit
        unitFont:(NSInteger)unitFont
       unitColor:(UIColor *)unitColor{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[value stringByAppendingString:unit]];
    
    [str addAttribute:NSForegroundColorAttributeName value:valueColor range:NSMakeRange(0, value.length)];
    [str addAttribute:NSForegroundColorAttributeName value:unitColor range:NSMakeRange(value.length, unit.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:valueFont] range:NSMakeRange(0, value.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:unitFont] range:NSMakeRange(value.length, unit.length)];
//    [str addAttribute:NSBaselineOffsetAttributeName value:@(-15) range:NSMakeRange(0, value.length)];
//    [str addAttribute:NSBaselineOffsetAttributeName value:@(-15) range:NSMakeRange(value.length, unit.length)];
    self.attributedText = str;
}


@end
