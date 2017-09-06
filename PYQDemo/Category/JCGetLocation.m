//
//  JCGetLocation.m
//  Victor
//
//  Created by coollang on 17/2/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCGetLocation.h"
#import <CoreLocation/CoreLocation.h>

static JCGetLocation *manager;

@interface JCGetLocation  ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *locationStr;
@property (nonatomic, copy) locationComplete locationBlock;
@end

@implementation JCGetLocation

+(instancetype)locationComplete:(locationComplete)complete{
    manager = [JCGetLocation new];
    [manager startLocation];
    manager.locationBlock = ^(NSString *result){
        complete(result);
        manager = nil;
    };
    return manager;
}

- (void)setLocationStr:(NSString *)locationStr{
    _locationStr = locationStr;
    self.locationBlock(locationStr);
}

- (instancetype)init{
    
    if (self = [super init]) {
        [self startLocation];
    }
    return self;
}

//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"-------->开始定位");
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc]init];
            self.locationManager.delegate = self;
            //控制定位精度,越高耗电量越
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            // 总是授权
            [self.locationManager requestAlwaysAuthorization];
            self.locationManager.distanceFilter = 10.0f;
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager startUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *newLocation = locations[0];
    [self fanbianyi:newLocation];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
                self.locationStr = city;
            }
            NSLog(@"city = %@  %@", city, placemark.administrativeArea);
            self.locationStr = [NSString stringWithFormat:@"%@%@",placemark.administrativeArea,city];
            
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}


- (void)fanbianyi:(CLLocation *)location{
    NSLog(@"latitude === %g  longitude === %g",location.coordinate.latitude, location.coordinate.longitude);
    //反向地理编码
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLLocation *cl = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    [clGeoCoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {
        for (CLPlacemark *placeMark in placemarks) {
            NSDictionary *addressDic = placeMark.addressDictionary;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Street"];
            NSLog(@"经纬度反编译的所在城市====%@ %@ %@ %@", state, city, subLocality, street);
        }
    }];
}

- (void)dealloc{
    
    NSLog(@"释放定位对象");
}

@end
