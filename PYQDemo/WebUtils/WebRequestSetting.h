//
//  WebRequestSetting.h
//  Victor
//
//  Created by Guo.JC on 17/3/10.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef WebRequestSetting
#define WebRequestSetting

/******************************/
/*************服务器API*********/
/******************************/

#define     kAcountLogin                    @"Login/accountLogin"
#define     kLoginThrid                     @"Login/qqLoginCallBack"
#define     kRefreshLogin                   @"Login/refreshLogin"

#define     kGetUserInfo                    @"Member/getUserInfo"
#define     kSaveUserInfo                   @"Member/saveUserInfo"
#define     kGetHeaderToken                 @"Member/getUpToken"
#define     kUploadMacVersion               @"Device/addDeviceMacRelation"

#define     kGetRankList                    @"sport/getRankList"
#define     kRankUserInfo                   @"sport/rankUserInfo"
#define     kAddFollow                      @"follow/add"
#define     kRemoveFollow                   @"follow/remove"
#define     kAddLike                        @"Sport/addRankLike"
#define     kRemoveLike                     @"Sport/delRankLike"
#define     kGetLikeList                    @"Sport/getLikeUserList"
#define     kPostTopic                      @"Sns/post"
#define     kPostImageQNToken               @"Sns/getUpToken"
#define     kGetTopicList                   @"Sns/getPostList"
#define     kResponseTopic                  @"Sns/response"

#define     kAddSportRecordDailyTotal       @"sport/addSportRecordDailyTotal"
#define     kAddSportDetailTotal            @"sport/addSportDetailTotal"
#define     kGetSportTotalData              @"sport/getData"
#define     kGetSportDaySwingDetail         @"sport/getSportDayDetail"
#define     kGetLastUpdateTime              @"sport/getLastUpdateTime"
#define     kClearCache                     @"Sport/deleteDateData"
#define     kGetBadgeConfig                 @"Config/badgeConfig"
#define     kGetOwnBadge                    @"Member/badgeList"

#define     kGetMyClass                     @"Train/getMyClass"
#define     kGetPersonalTatolData           @"Train/getPersonalTatolData"
#define     kGetMainCourse                  @"Train/getMainTrain"
#define     kAddClass                       @"Train/addUserClass"
#define     kCancelClass                    @"Train/removeUserClass"
#define     kGetRootCate                    @"Train/getTrainRootCate"
#define     kGetSubjectClass                @"Train/getTrainSubject"
#define     kGetSubjectDetail               @"Train/getSubjectDetail"
#define     kGetClassDetail                 @"Train/getClass"
#define     kUploadTrainReport              @"Train/addTarinDetail"
#define     kGetTrainHistory                @"Train/getTrainSportHistory"
#define     kGetTrainReport                 @"Train/getTrainSportDataDetail"

#define     kGetVideoList                   @"train/getHighlightVideos"

#define     kGetFirmwareVersion             @"Version/getFirmwareVersion"

/**--------挥拍详情--------**/
#define kUploadSwingInfoForce  @"Force"
#define kUploadSwingInfoBatTime  @"BatTime"
#define kUploadSwingInfoSpeed  @"Speed"
#define kUploadSwingInfoSubscript  @"Subscript"
#define kUploadSwingInfoTime  @"Time"
#define kUploadSwingInfoType  @"Type"
#define kUploadSwingInfoIsSweetBat  @"IsSweetBat"
#define kUploadSwingInfoIsEmptyBat  @"IsEmptyBat"
#define kUploadSwingInfoHitArea  @"HitArea"
#define kUploadSwingInfoCoordinateX  @"CoordinateX"
#define kUploadSwingInfoCoordinateY  @"CoordinateY"
#define kUploadSwingInfoZhengFan  @"ZhengFan" //0正 1反
#define kUploadSwingInfoShangXia  @"ShangXia" //0上 1下
#define kUploadSwingInfoSwingTime  @"SwingTime"
#define kUploadSwingInfoNumIndex  @"NumIndex"

typedef NS_ENUM(NSInteger,WebRespondType) {
    WebRespondTypeFail = -1,//数据获取失败
    WebRespondTypeSuccess = 0,//数据请求成功
    WebRespondTypeNoUser = -10002,//该账号不存在
    WebRespondTypeNotLogin = -10003,//未登录
    WebRespondTypeDataIsNil = -10006,//数据为空
    WebRespondTypeDataIsNull = -10007,//缺少参数
    WebRespondTypeInvalidToken = -10009,//签名不一致
    WebRespondTypeParamsError = -20001,//参数错误
    WebRespondTypeVerifyCodeWrong = -50007,//验证码错误
    WebRespondTypeChangePassVerifyCodeError = -468,//验证码错误
    WebRespondTypeMobServerError = -50009,//mob服务器请求失败
    WebRespondTypeTimeOut = 10086,//网络超时、网络错误
} ;

#define         kMsgLoginSuccess        @"登录成功,正在加载..."
#define         kMsgFail                @"数据获取失败,请稍后重试"
#define         kMsgNoUser              @"该账号不存在"
#define         kMsgNotLogin            @"您还未登录"
#define         kMsgDataIsNil           @"数据为空"
#define         kMsgNetError            @"网络错误"
#define         kMsgVerifyCodeError     @"验证码错误"
#define         kMsgSendCodeSuccess     @"验证码发送成功"
#define         kMsgSendCodeFail        @"验证码发送失败"
#define         kMsgUpLoadingSuccess    @"数据上传成功"

#endif
