//
//  JCLocation.m
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCLocation.h"
#import <CoreLocation/CoreLocation.h>

static JCLocation *_manager;

@interface JCLocation  ()

@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, copy) CompletionHandler complete;

@end

@implementation JCLocation

+ (JCLocation *)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [JCLocation new];
        _manager.geocoder = [CLGeocoder new];
    });
    return _manager;
}

/**
 经纬度反编译成地址
 @param     latitude                经度
 @param     longitude               纬度
 @param     completionHandler       编译地址结束回调
 */
- (void)reverseGeocodeLocationWithLatitude:(double) latitude
                                 longitude:(double) longitude
                                  complete:(CompletionHandler) completionHandler{
    self.complete = completionHandler;
    // 反地理编码
    self.geocoder = [CLGeocoder new];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSString *address;
        // 错误处理
        if (error || placemarks == nil || [placemarks count] == 0) {
            NSLog(@"反地理编码错误");
            address = @"";
        }else{
            // CLPlacemark 地标对象 包含CLLocation 位置对象 还有 街道 国家 行政区域描述信息
            // name 详细地址 thoroughfare 街道 country 国家 administrativeArea 省份 直辖市
            for (CLPlacemark *placeMark in placemarks) {
                NSDictionary *addressDic = placeMark.addressDictionary;
                NSString *state=[addressDic objectForKey:@"State"];
                NSString *city=[addressDic objectForKey:@"City"];
                NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
                NSString *street=[addressDic objectForKey:@"Street"];
                address = [NSString stringWithFormat:@"%@ %@ %@ %@", state, city, subLocality, street];
            }   
        }
        NSLog(@"经纬度反编译的所在城市====%@", address);
        if (self.complete) {
            self.complete(address);
            self.complete = nil;
        }
    }];
}

@end
