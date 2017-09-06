//
//  JCLabel.h
//  Victor
//
//  Created by Guo.JC on 17/2/21.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCLabel : UILabel

- (void)setValue:(NSString *)value
       valueFont:(NSInteger)valueFont
      valueColor:(UIColor *)valueColor
            unit:(NSString *)unit
        unitFont:(NSInteger)unitFont
       unitColor:(UIColor *)unitColor;

@end
