//
//  JCUserManager.h
//  Zebra
//
//  Created by Guo.JC on 2016/11/16.
//  Copyright © 2016年 奥赛龙科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

static NSString * const kLocationUserIDKey = @"currentUserID";

@class JCClassInfoModel;
@class JCMyClassSummaryModel;

/**
 *  性别
 */
typedef NS_ENUM(NSInteger, Gender){
    ///女
    GenderFemale      = 0,
    ///男
    GenderMale    = 1,
    ///未知
    GenderUnknown   = 2,
};

/**
 *  账户类型
 */
typedef NS_ENUM(NSInteger, UserType) {
    ///新用户、新安装的APP（无断点、无mac地址、无数据）
    UserTypeNewUserNewApp,
    ///老用户、新安装的APP（无断点、无mac地址、有数据）
    UserTypeOldUserNewApp,
    ///一般状态下的用户（有断点、有mac地址、有数据）
    UserTypeNormal,
    ///错误状态
    UserTypeError
};

/**
 *  用户基本信息
 */
@interface JCUserInfo : RLMObject

@property  NSString *icon;                 //头像URL
@property  NSString *nickName;             //昵称
@property  NSString *signature;            //签名
@property  Gender gender;                  //性别
@property  NSString *email;                //邮件
@property  NSString *weight;               //体重
@property  NSString *height;               //身高
@property  NSString *birthDay;             //生日
@property  NSInteger age;                  //年龄
@property  NSString *phoneNum;             //电话
@property  NSString *address;              //地址
@property  NSString *createTime;           //创建时间
@property  NSInteger createTimestemp;      //创建时间戳
@property  NSString *lastLoginTime;        //最后一次登录时间
@property  NSString *lastLoginVersion;     //最后一次登录版本
@property  NSInteger sportAge;             //球龄
@property  NSString *passWord;             //密码
@property  NSString *userId;               //userID
@property  NSString *countryID;            //国家ID
@property  NSString *provinceID;           //省份ID
@property  NSString *cityID;               //城市ID

- (void)copyValuesTo:(JCUserInfo *)infoParams;
- (void)copyValuesFrom:(JCUserInfo *)userInfo;

+ (JCUserInfo *)userInfoWithPrivateKey:(NSString *)key;
- (void)userInfoWithUserInfoDictionary:(NSDictionary *)dictionary;
- (NSInteger)getAge;

@end
RLM_ARRAY_TYPE(JCUserInfo)





/**
 *  已添加的课程
 */
@interface JCUserCourse : RLMObject

@property  NSString *classID;
@property  NSString *thumbnail;
@property  NSString *title;
@property  NSString *amount;
@property  NSString *detailID;
@property  NSString *lastTrainTime;

+ (JCUserCourse *)courseWithPrivateKey:(NSString *)key;
- (void)updateCourseWithClassDetail:(JCClassInfoModel*)model;
- (void)updateCourseWithClassSummary:(JCMyClassSummaryModel*)model;

@end
RLM_ARRAY_TYPE(JCUserCourse)





/**
 *  用户所有数据
 */
@interface JCUser : RLMObject

@property NSString *identification;

@property NSString *userID;//用户ID
@property NSString *token;
@property JCUserInfo *userInfo;//用户基本信息
@property NSString *syncSwingString;//同步挥拍标记
@property NSString *lastConnectMac;//上一次连接设备的MAC地址
@property BOOL isDownHistoryData;//是否下载过历史数据
//创建用户
+ (JCUser *)userWithPrivateKey:(NSString *)key;
//当前用户ID
+ (NSString *)currentUerID;
//当前用户
+ (JCUser *)currentUer;

//添加课程
- (void)addCourse:(JCUserCourse*)course;
//删除课程
- (void)deleteCourseWithID:(NSString*)courseID;
//更新用户所有课程
- (void)updateCourseWithArray:(NSArray*)courseArray;
//更新用户基本信息
- (void)updateUserInfo:(JCUserInfo*)userInfo;
//更新同步挥拍标记
- (void)updateSyncSwingString:(NSString *)string;
//按课时ID查找练习记录
- (NSArray *)queryCourseTrainingWithCourseID:(NSString *)courseID;
///获取账户类型
- (UserType)userType;

@end
RLM_ARRAY_TYPE(JCUser)

