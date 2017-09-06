//
//  JCBaseWebUtils.h
//  Victor
//
//  Created by Guo.JC on 17/3/10.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NetRequestCallback)(BOOL requestState, id obj);

@interface JCBaseWebUtils : NSObject
#pragma mark GET请求
+(void)get:(NSString *)path andParams:(id)params andCallback:(NetRequestCallback)callback;

#pragma mark POST请求
+(void)post:(NSString *)path andParams:(id)params andCallback:(NetRequestCallback)callback;

/*
#pragma mark 上传图片
+(void)uploadImage:(NSString *)path andParams:(NSDictionary *)params andCallback:(MyCallback)callback;

#pragma mark 上传多张图片
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)())success
                             failure:(void (^)(NSError *))failure;
*/
@end
