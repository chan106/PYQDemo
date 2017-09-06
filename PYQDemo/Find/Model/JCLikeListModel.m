//
//  JCLikeListModel.m
//  Victor
//
//  Created by Guo.JC on 2017/9/1.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCLikeListModel.h"
#import "NSString+CheckIsString.h"

@implementation JCLikeListModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"userID": @"UserID",
                                                                  @"userName": @"UserName"
                                                                  }];
}

/**
 创建点赞人模型
 @param         sourceArray         源数据，网络请求回来的数组
 @return                            解析好的数组模型
 */
+ (NSArray <JCLikeListModel *> *)creatModelWithArray:(NSArray <NSDictionary *> *)sourceArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *sourceDic in sourceArray) {
        JCLikeListModel *model = [JCLikeListModel new];
        model.userID = [NSString checkIfNullWithString:sourceDic[@"UserID"]];
        model.userName = [NSString checkIfNullWithString:sourceDic[@"UserName"]];
        [array addObject:model];
    }
    NSArray *names = @[@"李连杰",@"成龙",@"杰森",@"小炒肉",@"茶叶",
                       @"烧烤",@"白开水",@"我的微博不是我的",@"小仙女",@"湘赣木桶饭",
                       @"N刺客",@"卖火柴的",@"大风大雨",@"不想上学",@"下雨不打雷",
                       @"破风",@"霹雳",@"起名字好难",@"加班加点",@"微信一条虫",
                       @"腐竹",@"萝卜",@"小记者"];
    for (NSInteger i = 0; i < arc4random()%20; i++) {
        JCLikeListModel *model = [JCLikeListModel new];
        model.userID = @(i).stringValue;
        model.userName = names[i];
        [array addObject:model];
    }
    return [array mutableCopy];
}

@end
