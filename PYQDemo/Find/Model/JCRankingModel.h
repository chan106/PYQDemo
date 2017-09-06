//
//  JCRankingModel.h
//  Victor
//
//  Created by Guo.JC on 17/3/8.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class TYTextContainer;
@class JCLikeListModel;

@interface JCRankingModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *address;
@property (nonatomic, strong) NSURL <Optional> *headerUrl;
@property (nonatomic, strong) NSString <Optional> *signature;
@property (nonatomic, strong) NSString <Optional> *smashSpeed;
@property (nonatomic, strong) NSString <Optional> *userID;
@property (nonatomic, strong) NSString <Optional> *userName;
@property (nonatomic, strong) NSNumber <Optional>*rangKingNumber;
@property (nonatomic, strong) NSString <Optional> *battingTimes;
@property (nonatomic, strong) NSString <Optional> *badgeCnt;
@property (nonatomic, strong) NSString <Optional> *countryID;
@property (nonatomic, strong) NSString <Optional> *provinceID;
@property (nonatomic, strong) NSString <Optional> *cityID;
@property (nonatomic, strong) NSNumber <Optional> *likes;///点赞数量
@property (nonatomic, strong) NSNumber <Optional> *isLiked;///自己是否点过赞

@property (nonatomic, strong) NSString <Ignore> *addressString;
@property (nonatomic, strong) NSNumber <Ignore> *isShowLikeList;///是否显示点赞列表
@property (nonatomic, strong) NSNumber <Ignore> *isNeedReCalcul;///是否需要重新计算
@property (nonatomic, strong) NSNumber <Ignore> *cellHeight;///cell高度
@property (nonatomic, strong) NSNumber <Ignore> *likeListHeight;///点赞列表高度
@property (nonatomic, strong) TYTextContainer <Ignore> *likeListString;///点赞人列表字符串
@property (nonatomic, strong) NSNumber <Ignore> *isHaveShow;///是否显示过
@property (nonatomic, strong) NSArray <Ignore> *likeListArray;///点赞的人模型数组
@property (nonatomic, strong) NSNumber <Ignore> *isNeedDownList;///是否需要下载点赞人

@end
