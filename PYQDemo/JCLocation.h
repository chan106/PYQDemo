//
//  JCLocation.h
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(NSString *addrssString);

@interface JCLocation : NSObject

+ (JCLocation *) shared;

/**
 经纬度反编译成地址
 @param     latitude                经度
 @param     longitude               纬度
 @param     completionHandler       编译地址结束回调
 */
- (void)reverseGeocodeLocationWithLatitude:(double) latitude
                                 longitude:(double) longitude
                                  complete:(CompletionHandler) completionHandler;
@end
