//
//  NSAttributedString+RichText.m
//  CoolTennisBall
//
//  Created by Coollang on 16/8/9.
//  Copyright © 2016年 CoolLang. All rights reserved.
//

#import "NSAttributedString+RichText.h"
#import "NSString+Add.h"

@implementation NSAttributedString (RichText)


+ (NSAttributedString *)attributedString:(NSString *)string subString:(NSArray *)subStrings colors:(NSArray *)colors fonts:(NSArray *)fonts {
    
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:string];
    
    for (NSInteger i = 0; i <subStrings.count; i++) {
        
        [attrStrM addAttributes:@{NSFontAttributeName:fonts[i],NSForegroundColorAttributeName:colors[i]} range:[string rangeOfString:subStrings[i]]];
    }
    
    return attrStrM.copy;
}

+ (NSAttributedString *)attributedString:(NSString *)string subString:(NSArray *)subStrings colors:(NSArray *)colors  {
    
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:string];
    for (NSInteger i = 0; i <subStrings.count; i++) {
        [attrStrM addAttributes:@{NSForegroundColorAttributeName:colors[i]} range:[string rangeOfString:subStrings[i]]];
    }
    return attrStrM.copy;
}

@end
