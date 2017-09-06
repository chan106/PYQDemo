//
//  JCWebDataRequst+Find.m
//  Victor
//
//  Created by Guo.JC on 2017/8/23.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCWebDataRequst+Find.h"
#import "JCBaseWebUtils.h"
#import "WebRequest.h"
#import "JCRankingModel.h"
#import "JCMyRankingModel.h"
#import "JCOtherUserData.h"
#import "JCLikeListModel.h"
#import "JCMomentsModel.h"

@implementation JCWebDataRequst (Find)

///排行榜数据
+ (void)rankingDataWithParams:(NSDictionary *)params complete:(webRequestCallBack)complete{
    
    NSString *path = [self creatPathWithAPI:kGetRankList];
    
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            if (ret == WebRespondTypeSuccess) {
                NSDictionary *errDesc = obj[@"errDesc"];
                NSArray *rankList = errDesc[@"rankList"];
                NSArray *myRanking = @[errDesc[@"my"]];
                NSMutableArray *models = [JCRankingModel arrayOfModelsFromDictionaries:rankList error:nil];
                NSMutableArray *myModel = [JCRankingModel arrayOfModelsFromDictionaries:myRanking error:nil];
                
                ///打开数据库，查找匹配出所有的地址数据
                /*
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *dbFilePath = [documentsDirectory stringByAppendingPathComponent:@"VICTOR_ADDRESS_DB.sqlite"];
                FMDatabase *database = [FMDatabase databaseWithPath:dbFilePath];
                
                if ([database open]) {
                    
                    for (JCMyRankingModel *model in myModel) {
                        
                        CountryModel *countryModel;
                        ProvinceModel *provinceModel;
                        CityModel *cityModel;
                        
                        ///国家
                        if (model.countryID) {
                            if (![model.countryID isEqualToString:@""]) {
                                FMResultSet *countryRs;
                                countryRs = [database executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE ID = '%@';",LOCATION(kCountryTable),model.countryID]];
                                while ([countryRs next]) {
                                    countryModel = [[CountryModel alloc] init];
                                    [countryModel importFromResultSet:countryRs];
                                }
                            }
                        }
                        
                        ///省份
                        if (model.countryID && model.provinceID) {
                            if (![model.countryID isEqualToString:@""] &&
                                ![model.provinceID isEqualToString:@""]) {
                                FMResultSet *provinceRs;
                                provinceRs = [database executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE CountryID = '%@' AND ID = '%@';",LOCATION(kProvinceTable),model.countryID,model.provinceID]];
                                while ([provinceRs next]) {
                                    provinceModel = [[ProvinceModel alloc] init];
                                    [provinceModel importFromResultSet:provinceRs];
                                }
                            }
                        }
                        
                        ///城市
                        if (model.countryID && model.provinceID && model.cityID) {
                            if (![model.countryID isEqualToString:@""] &&
                                ![model.provinceID isEqualToString:@""] &&
                                ![model.cityID isEqualToString:@""]) {
                                FMResultSet *cityRs;
                                cityRs = [database executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE CountryID = '%@' AND ProvinceID = '%@' AND ID = '%@';",LOCATION(kCityTable),model.countryID,model.provinceID,model.cityID]];
                                while ([cityRs next]) {
                                    cityModel = [[CityModel alloc] init];
                                    [cityModel importFromResultSet:cityRs];
                                }
                                
                            }
                        }
                        model.addressString = [NSString stringWithFormat:@"%@ %@ %@",countryModel?countryModel.name:@"",provinceModel?provinceModel.name:@"",cityModel?cityModel.name:@""];
                    }
                    
                    for (JCRankingModel *model in models) {
                        
                        CountryModel *countryModel;
                        ProvinceModel *provinceModel;
                        CityModel *cityModel;
                        
                        ///国家
                        if (model.countryID) {
                            if (![model.countryID isEqualToString:@""]) {
                                FMResultSet *countryRs;
                                countryRs = [database executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE ID = '%@';",LOCATION(kCountryTable),model.countryID]];
                                while ([countryRs next]) {
                                    countryModel = [[CountryModel alloc] init];
                                    [countryModel importFromResultSet:countryRs];
                                }
                            }
                        }
                        
                        ///省份
                        if (model.countryID && model.provinceID) {
                            if (![model.countryID isEqualToString:@""] &&
                                ![model.provinceID isEqualToString:@""]) {
                                FMResultSet *provinceRs;
                                provinceRs = [database executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE CountryID = '%@' AND ID = '%@';",LOCATION(kProvinceTable),model.countryID,model.provinceID]];
                                while ([provinceRs next]) {
                                    provinceModel = [[ProvinceModel alloc] init];
                                    [provinceModel importFromResultSet:provinceRs];
                                }
                            }
                        }
                        
                        ///城市
                        if (model.countryID && model.provinceID && model.cityID) {
                            if (![model.countryID isEqualToString:@""] &&
                                ![model.provinceID isEqualToString:@""] &&
                                ![model.cityID isEqualToString:@""]) {
                                FMResultSet *cityRs;
                                cityRs = [database executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE CountryID = '%@' AND ProvinceID = '%@' AND ID = '%@';",LOCATION(kCityTable),model.countryID,model.provinceID,model.cityID]];
                                while ([cityRs next]) {
                                    cityModel = [[CityModel alloc] init];
                                    [cityModel importFromResultSet:cityRs];
                                }
                            }
                        }
                        model.addressString = [NSString stringWithFormat:@"%@ %@ %@",countryModel?countryModel.name:@"",provinceModel?provinceModel.name:@"",cityModel?cityModel.name:@""];
                    }
                }else{
                    JCLog(@"数据库打开失败");
                    for (JCRankingModel *model in models) {
                        model.addressString = @"数据库打开失败,刷新重试!";
                    }
                }
                [database close];
                 */
                complete(WebRespondTypeSuccess, @{@"my":[myModel mutableCopy][0],
                                                  @"models":[models mutableCopy]});
                
            }else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }else{
                complete(WebRespondTypeFail, nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}

///查看其它用户数据
+ (void)checkOtherInfo:(NSString *)userID complete:(webRequestCallBack)complete{
    NSString *path = [self creatPathWithAPI:kRankUserInfo];
    NSDictionary *params = @{@"userID":userID};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                
                NSArray *other = @[obj[@"errDesc"]];
                NSMutableArray *models = [JCOtherUserData arrayOfModelsFromDictionaries:other error:nil];
                complete(WebRespondTypeSuccess,[models mutableCopy]);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}

///关注用户
+ (void)addRelation:(NSString *)userID complete:(webRequestCallBack)complete{
    
    NSString *path = [self creatPathWithAPI:kAddFollow];
    NSDictionary *params = @{@"to":userID};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                complete(WebRespondTypeSuccess,@"add");
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}

///取消关注
+ (void)remmoveRelation:(NSString *)userID complete:(webRequestCallBack)complete{
    NSString *path = [self creatPathWithAPI:kRemoveFollow];
    NSDictionary *params = @{@"to":userID};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                complete(WebRespondTypeSuccess,@"remove");
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}

/**
 *点赞
 */
+ (void)addLike:(NSString *)userID complete:(webRequestCallBack)complete{
    NSString *path = [self creatPathWithAPI:kAddLike];
    NSDictionary *params = @{@"userID":userID};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                complete(WebRespondTypeSuccess,@"addLike");
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}

/**
 *取消赞
 */
+ (void)remmoveLike:(NSString *)userID complete:(webRequestCallBack)complete{
    NSString *path = [self creatPathWithAPI:kRemoveLike];
    NSDictionary *params = @{@"userID":userID};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                complete(WebRespondTypeSuccess,@"removeLike");
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}

+(void)getLikeList:(NSString *)userID complete:(webRequestCallBack)complete{
    NSString *path = [self creatPathWithAPI:kGetLikeList];
    NSDictionary *params = @{@"userID":userID};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            
            if (ret == WebRespondTypeSuccess) {
                NSArray *list = @[obj[@"errDesc"]];
                NSMutableArray *models = [JCLikeListModel arrayOfModelsFromDictionaries:list error:nil];
                complete(WebRespondTypeSuccess,[models mutableCopy]);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
}

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
                complete:(webRequestCallBack)complete{
    NSString *path = [self creatPathWithAPI:kPostTopic];
    NSDictionary *params = @{@"position":position,
                             @"imgList":imageArray,
                             @"subject":subject,
                             @"text":text};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            if (ret == WebRespondTypeSuccess) {
                complete(WebRespondTypeSuccess,nil);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(WebRespondTypeNotLogin, nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(WebRespondTypeVerifyCodeWrong,nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(WebRespondTypeMobServerError,nil);
            }
        }
        else{
            complete(WebRespondTypeTimeOut, nil);
        }
    }];
    
}

/**
 获取上传图片的token
 */
+ (void)getQiniuTokenComplete:(void (^)(NSString *token)) complete{
    NSString *path = [self creatPathWithAPI:kPostImageQNToken];
    [JCBaseWebUtils post:path andParams:nil andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            if (ret == WebRespondTypeSuccess) {
                NSString *token = obj[@"errDesc"][@"token"];
                complete(token);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(nil);
            }
        }
        else{
            complete(nil);
        }
    }];
}

/**
 请求帖子列表数据
 @param         type            1:关注的人,0：全部用户
 @param         page            页码
 @param         complete        请求完成回调
 */
+ (void)getTopicListWithType:(NSInteger)type
                        page:(NSInteger)page
                    complete:(void (^)(NSArray *topicModeList)) complete{
    NSString *path = [self creatPathWithAPI:kGetTopicList];
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%ld",page],
                             @"from":[NSString stringWithFormat:@"%ld",type]};
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            if (ret == WebRespondTypeSuccess) {
                NSArray *models = [JCMomentsModel creatModelWithArray:obj[@"errDesc"]];
                complete(models);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(nil);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(nil);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(nil);
            }
        }
        else{
            complete(nil);
        }
    }];
}

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
                     complete:(void (^)(BOOL state)) complete{
    NSString *path = [self creatPathWithAPI:kResponseTopic];
    NSDictionary *params;
    if (parentID) {
        params = @{@"text":text,
                   @"postID":postID,
                   @"parentID":parentID};
    }else{
        params = @{@"text":text,
                   @"postID":postID};
    }
    [JCBaseWebUtils post:path andParams:params andCallback:^(BOOL requestState, id obj) {
        if (requestState == YES) {
            NSInteger ret = [obj[@"ret"] integerValue];
            if (ret == WebRespondTypeSuccess) {
                complete(YES);
            }
            else if (ret == WebRespondTypeNotLogin){
                complete(NO);
            }
            else if (ret == WebRespondTypeInvalidToken){
                [self tokenInvalid];
            }
            else if (ret == WebRespondTypeVerifyCodeWrong){
                complete(NO);
            }
            else if (ret == WebRespondTypeMobServerError){
                complete(NO);
            }
        }
        else{
            complete(NO);
        }
    }];
}

@end
