//
//  JCUserManager.m
//  Zebra
//
//  Created by Guo.JC on 2016/11/16.
//  Copyright © 2016年 奥赛龙科技. All rights reserved.
//

#import "JCUserManager.h"
#import "NSString+Add.h"
#import "NSDate+FormateString.h"
#import "NSString+CheckIsString.h"

@implementation JCUserInfo

+ (NSString *)primaryKey{
    return @"userId";
}

+ (JCUserInfo *)userInfoWithPrivateKey:(NSString *)key
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    JCUserInfo *userInfo = [JCUserInfo objectForPrimaryKey:key];
    
    if (userInfo == nil) {
        userInfo = [[JCUserInfo alloc] init];
        userInfo.userId = key;
        [realm beginWriteTransaction];
        [realm addObject:userInfo];
        [realm commitWriteTransaction];
    }
    return userInfo;
}

+(NSDictionary *)defaultPropertyValues{
    
    return @{   @"address": @"火星",
                @"icon": @"",
                @"nickName": @"",
                @"signature": @"",
                @"gender": @"0",
                @"email": @"",
                @"weight": @"50",
                @"height": @"170",
                @"birthDay": @"1996-06-06",
                @"phoneNum": @"",
                @"createTime": @"2017-01-01",
                @"lastLoginTime": @"2017-01-01",
                @"lastLoginVersion":@"",
                @"handBallType": @"0",
                @"sportAge":@"0",
                @"passWord":@""};
}

-(void)userInfoWithUserInfoDictionary:(NSDictionary *)dictionary{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.nickName = [NSString checkIfNullWithString:dictionary[@"UserName"]];
    self.gender = ([[NSString checkIfNullWithString:dictionary[@"Sex"]] isEqualToString:@"1"]) ? GenderMale : GenderFemale; // 1表示男，0表示女
    if ([[NSString checkIfNullWithString:dictionary[@"Birthday"]] isEqualToString:@""]) {
        self.birthDay = @"1995-01-01";
    } else {
        self.birthDay = dictionary[@"Birthday"];
    }
    
    self.age = [self getAge];
    
    if ([[NSString checkIfNullWithString:dictionary[@"Height"]] isEqualToString:@""]) {
        self.height = @"170";
    } else {
        self.height = dictionary[@"Height"];                // 身高
    }
    
    if ([[NSString checkIfNullWithString:dictionary[@"Weight"]] isEqualToString:@""]) {
        self.weight = @"60";
    } else {
        self.weight = dictionary[@"Weight"];                // 体重
    }
    self.icon = dictionary[@"Icon"];            // 头像url
    self.signature = [NSString checkIfNullWithString:dictionary[@"Signature"]];
    self.phoneNum = [NSString checkIfNullWithString:dictionary[@"Phone"]];
    self.email = dictionary[@"Email"];
    self.createTime = [NSString checkIfNullWithString:dictionary[@"CreateTime"]];         // 账号创建时间
    self.createTimestemp = [NSDate yearMouthDayToTimestamp:self.createTime.length > 10?[self.createTime substringWithRange:NSMakeRange(0, 10)]:@"xx"];
    self.lastLoginTime= [NSString checkIfNullWithString:dictionary[@"LastLoginTime"]];   // 上次登陆时间
    self.lastLoginVersion = [NSString checkIfNullWithString:dictionary[@"LastLoginVersion"]];    // 上次登陆版本号
//    self.handBallType = [[NSString checkIfNullWithString:dictionary[@"Hand"]] integerValue];
    self.sportAge = [NSString currentYear] - [(NSString *)dictionary[@"SportAge"] integerValue];
    self.countryID = [NSString checkIfNullWithString:dictionary[@"CountryID"]];///国家ID
//    self.countryID = [self.countryID isEqualToString:@""]?kDefaultCountryID:self.countryID;
    self.provinceID = [NSString checkIfNullWithString:dictionary[@"ProvinceID"]];///省份ID
//    self.provinceID = [self.provinceID isEqualToString:@""]?kDefaultProvinceID:self.provinceID;
    self.cityID = [NSString checkIfNullWithString:dictionary[@"CityID"]];///城市ID
//    self.cityID = [self.cityID isEqualToString:@""]?kDefaultCityID:self.cityID;
//    CountryModel *countryModel = [CountryModel countryWithID:self.countryID];
//    ProvinceModel *provinceModel = [ProvinceModel provinceWithCountryID:self.countryID provinceID:self.provinceID];
//    CityModel *cityModel = [CityModel provinceWithCountryID:self.countryID provinceID:self.provinceID cityID:self.cityID];
//    NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@",countryModel?countryModel.name:@"",provinceModel?provinceModel.name:@"",cityModel?cityModel.name:@""];
//    self.address = addressString;
    [realm commitWriteTransaction];
}

- (void)copyValuesTo:(JCUserInfo *)infoParams{
    infoParams.nickName = self.nickName;
    infoParams.gender = self.gender;
    infoParams.birthDay = self.birthDay;
    infoParams.height = self.height;
    infoParams.weight = self.weight;
    infoParams.signature = self.signature;
    infoParams.address = self.address;
//    infoParams.handBallType = self.handBallType;
    infoParams.sportAge = self.sportAge;
    infoParams.icon = self.icon;
    infoParams.email = self.email;
    infoParams.phoneNum = self.phoneNum;
    infoParams.createTime = self.createTime;
    infoParams.lastLoginTime = self.lastLoginTime;
    infoParams.lastLoginVersion = self.lastLoginVersion;
    infoParams.passWord = self.passWord;
    infoParams.countryID = self.countryID;
    infoParams.provinceID = self.provinceID;
    infoParams.cityID = self.cityID;
    infoParams.address = self.address;
}

- (void)copyValuesFrom:(JCUserInfo *)userInfo{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        self.nickName = userInfo.nickName;
        self.gender = userInfo.gender;
        self.birthDay = userInfo.birthDay;
        self.height = userInfo.height;
        self.weight = userInfo.weight;
        self.signature = userInfo.signature;
        self.address = userInfo.address;
//        self.handBallType = userInfo.handBallType;
        self.sportAge = userInfo.sportAge;
        self.icon = userInfo.icon;
        self.email = userInfo.email;
        self.phoneNum = userInfo.phoneNum;
        self.createTime = userInfo.createTime;
        self.lastLoginTime = userInfo.lastLoginTime;
        self.lastLoginVersion = userInfo.lastLoginVersion;
        self.passWord = userInfo.passWord;
        self.countryID = userInfo.countryID;
        self.provinceID = userInfo.provinceID;
        self.cityID = userInfo.cityID;
    }];
}

- (NSInteger)getAge{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [dateFormatter dateFromString:self.birthDay];
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSinceDate:date1];
    int years = ((int)time)/(3600*24) / 365;
    return years;
}

@end






@implementation JCUserCourse

+(NSString *)primaryKey{
    
    return @"classID";
}
//获取课程
+ (JCUserCourse *)courseWithPrivateKey:(NSString *)key
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    JCUserCourse *course = [JCUserCourse objectForPrimaryKey:key];
    
    if (course == nil) {
        course = [[JCUserCourse alloc] init];
        course.classID = key;
        [realm beginWriteTransaction];
        [realm addObject:course];
        [realm commitWriteTransaction];
    }
    return course;
}

+(NSDictionary *)defaultPropertyValues{
    
    return @{
             @"thumbnail":@"",
             @"title":@"",
             @"amount":@"",
             @"detailID":@"",
             @"lastTrainTime":@""};
}
- (void)updateCourseWithClassDetail:(JCClassInfoModel*)model{
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        self.thumbnail = model.thumbnail;
//        self.title = model.title;
//        self.amount = model.amount;
//        self.lastTrainTime = @"";
//    }];
}

- (void)updateCourseWithClassSummary:(JCMyClassSummaryModel*)model{
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        self.thumbnail = model.thumbnail;
//        self.title = model.title;
//        self.amount = model.amount;
//        self.lastTrainTime = model.lastTrainTime;
//        self.detailID = model.detailID;
//    }];
}

@end






@implementation JCUser

#define SuportMultiUser 1
#warning 如需支持多用户课程本地保存，只需屏蔽上行

+(NSString *)primaryKey{
    
    return @"identification";
}
///获取用户
+ (JCUser *)userWithPrivateKey:(NSString *)key
{
    JCUser *user = [JCUser objectForPrimaryKey:key];
    if (user == nil) {
        user = [[JCUser alloc] init];
        user.identification = key;
        user.userID = key;
        user.isDownHistoryData = NO;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:user];
        [realm commitWriteTransaction];
    }
    return user;
}
///当前用户ID
+ (NSString *)currentUerID{
    NSString *userID = GET_CURRENT_USER_ID;
    return userID;
}
///当前用户
+ (JCUser *)currentUer{
    NSString *userID = GET_CURRENT_USER_ID;
    JCUser *user = [JCUser userWithPrivateKey:userID];
    return user;
}

///更新用户所有课程
- (void)updateCourseWithArray:(NSArray *)courseArray{
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    NSMutableArray *classID = [NSMutableArray arrayWithCapacity:self.courseArray.count];
//    for (NSInteger i = 0; i < self.courseArray.count; i++) {
//        JCUserCourse *userCourse = self.courseArray[i];
//        [classID addObject:userCourse.classID];
//    }
//    //清除用户本地保存的所有课程
//    [realm transactionWithBlock:^{
//        for (NSInteger i = 0; i < classID.count; i++) {
//            JCUserCourse *deleteCourse = [JCUserCourse courseWithPrivateKey:classID[i]];
//            [realm deleteObject:deleteCourse];//直接删数据库数据源
//        }
//    }];
//    //写入服务器请求回来的课程数据
//    for (NSInteger i = 0; i < courseArray.count; i++) {
//        JCMyClassSummaryModel *model = courseArray[i];
//        JCUserCourse *course = [JCUserCourse courseWithPrivateKey:model.classID];
//        [course updateCourseWithClassSummary:model];
//        [self addCourse:course];
//    }
}
///添加课程
- (void)addCourse:(JCUserCourse *)course{
    
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    [self.courseArray addObject:course];
//    [realm commitWriteTransaction];
}
///删除课程
- (void)deleteCourseWithID:(NSString *)courseID{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
#ifdef SuportMultiUser
        JCUserCourse *deleteCourse = [JCUserCourse courseWithPrivateKey:courseID];
        [realm deleteObject:deleteCourse];//直接删数据库数据源
#else
        for (NSInteger i = 0; i < self.courseArray.count; i++) {
            JCUserCourse *needDelete = self.courseArray[i];
            if ([needDelete.classID isEqualToString:courseID]) {
                [self.courseArray removeObjectAtIndex:i];//只删除对应关系
                continue;
            }
        }
#endif
    }];
}

///更新用户个人信息数据
- (void)updateUserInfo:(JCUserInfo *)userInfo{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.userInfo = userInfo;
    [realm commitWriteTransaction];
}

///添加模板
//- (void)addThreeDTemplate:(JCThreeDTemplate *)threeDTemplate{

//    for (JCThreeDTemplate *item in self.threeDTemplateArray) {
//        if ([item.identification isEqualToString:threeDTemplate.identification]) {
//            return;
//        }
//    }
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    [self.threeDTemplateArray addObject:threeDTemplate];
//    [realm commitWriteTransaction];
//}

///保存同步断点
- (void)updateSyncSwingString:(NSString *)string{
//    JCLog(@"保存断点：%@",string);
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    self.syncSwingString = string;
    [realm commitWriteTransaction];
    
}

///获取账户类型
- (UserType)userType{
    
    BOOL isHavePoint = YES;
    BOOL isHaveMac = YES;
    BOOL isHaveData = YES;
    UserType type;
    
//    NSString *pointString = self.syncSwingString;
//    NSString *lastConnectMac = self.lastConnectMac;
//    if ([JCDailyStatistics allObjects].count == 0) {
//        isHaveData = NO;
//    }
//    if ([pointString isEqualToString:@""] || pointString == nil) {
//        isHavePoint = NO;
//    }
//    if ([lastConnectMac isEqualToString:@""] || lastConnectMac == nil) {
//        isHaveMac = NO;
//    }
//    
//    if (isHaveMac == NO && isHavePoint == NO && isHaveData == NO) {
//        type = UserTypeNewUserNewApp;
//    }else if (isHaveMac == NO && isHavePoint == NO && isHaveData == YES){
//        type = UserTypeOldUserNewApp;
//    }else if (isHaveMac == YES && isHavePoint == YES && isHaveData == YES){
//        type = UserTypeNormal;
//    }else{
//        type = UserTypeError;
//    }
    return type;
}
@end
