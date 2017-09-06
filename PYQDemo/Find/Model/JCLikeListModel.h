//
//  JCLikeListModel.h
//  Victor
//
//  Created by Guo.JC on 2017/9/1.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JCLikeListModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *userID;
@property (nonatomic, strong) NSString <Optional> *userName;

/**
 创建点赞人模型
 @param         sourceArray         源数据，网络请求回来的数组
 @return                            解析好的数组模型
 */
+ (NSArray <JCLikeListModel *> *)creatModelWithArray:(NSArray <NSDictionary *> *)sourceArray;

@end
