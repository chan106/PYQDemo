//
//  JCWebDataRequst+Find.h
//  Victor
//
//  Created by Guo.JC on 2017/8/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCWebDataRequst.h"

@interface JCWebDataRequst (Find)

/**
 *排行榜数据
 */
+ (void)rankingDataWithParams:(NSDictionary *)params complete:(webRequestCallBack)complete;

/**
 *查看其它用户数据
 */
+ (void)checkOtherInfo:(NSString *)userID complete:(webRequestCallBack)complete;

/**
 *关注用户
 */
+ (void)addRelation:(NSString *)userID complete:(webRequestCallBack)complete;

/**
 *取消关注
 */
+ (void)remmoveRelation:(NSString *)userID complete:(webRequestCallBack)complete;
/**
 *点赞
 */
+ (void)addLike:(NSString *)userID complete:(webRequestCallBack)complete;

/**
 *取消赞
 */
+ (void)remmoveLike:(NSString *)userID complete:(webRequestCallBack)complete;

/**
 获取点赞列表
 */
+ (void)getLikeList:(NSString *)userID complete:(webRequestCallBack)complete;

/**
 发新帖子
 @param         subject         主题
 @param         text            内容
 @param         imageArray      图片数组
 @param         position        位置
 */
+ (void)postTopicSubject:(NSString *)subject
                    text:(NSString *)text
              imageArray:(NSArray <NSString *>*)imageArray
                position:(NSString *)position
                complete:(webRequestCallBack)complete;

/**
 获取上传图片的token
 */
+ (void)getQiniuTokenComplete:(void (^)(NSString *token)) complete;

/**
 请求帖子列表数据
 @param         type            1:关注的人,0：全部用户
 @param         page            页码
 @param         complete        请求完成回调
 */
+ (void)getTopicListWithType:(NSInteger)type
                        page:(NSInteger)page
                    complete:(void (^)(NSArray *topicModeList)) complete;

/**
 回复评论、发表评论
 @param         text            1:关注的人,0：全部用户
 @param         postID          帖子的ID
 @param         parentID        评论ID（用于回复他人的评论）
 @param         complete        请求完成回调
 */
+ (void)responseTopicWithText:(NSString *)text
                       postID:(NSString *)postID
                     parentID:(NSString *)parentID
                    complete:(void (^)(BOOL state)) complete;

@end
