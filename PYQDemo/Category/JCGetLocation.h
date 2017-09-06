//
//  JCGetLocation.h
//  Victor
//
//  Created by coollang on 17/2/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^locationComplete)(NSString *result);


@interface JCGetLocation : NSObject

+(instancetype)locationComplete:(locationComplete) complete;

@end
