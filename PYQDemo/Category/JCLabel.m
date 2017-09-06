//
//  JCLabel.m
//  Victor
//
//  Created by Guo.JC on 17/2/21.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCLabel.h"

@implementation JCLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.adjustsFontSizeToFitWidth = YES;//调整基线位置需将此属性设置为YES
        self.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

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
    
    //    [str addAttribute:NSBaselineOffsetAttributeName value:@(-5) range:NSMakeRange(0, value.length)];
    self.attributedText = str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
