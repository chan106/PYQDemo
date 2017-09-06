//
//  JCOtherUserInfo.h
//  Victor
//
//  Created by Guo.JC on 17/3/15.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol JCOtherUserInfo

@end

@interface JCOtherUserInfo : JSONModel

@property (nonatomic, strong) NSURL <Optional>*icon;
@property (nonatomic, strong) NSString <Optional>*address;
@property (nonatomic, strong) NSString <Optional>*userName;
@property (nonatomic, strong) NSNumber <Optional>*sportAge;
@property (nonatomic, strong) NSNumber <Optional>*sportDays;

@end

@protocol JCOtherEveryDay

@end

@interface JCOtherEveryDay :JSONModel

@property (nonatomic, strong) NSNumber <Optional>*week;
@property (nonatomic, strong) NSNumber <Optional>*battingTimes;
@property (nonatomic, strong) NSNumber <Optional>*maxSpeed;

@end

@protocol JCOtherUserWeekData

@end

@interface JCOtherUserWeekData : JSONModel

@property (nonatomic, strong) NSNumber <Optional> *battingTimes;
@property (nonatomic, strong) NSNumber <Optional> *maxSpeed;
@property (nonatomic, strong) NSArray <JCOtherEveryDay> *everyday;

@end

@protocol JCOtherUserTotalData

@end

@interface JCOtherUserTotalData : JSONModel

@property (nonatomic, strong) NSNumber <Optional> *battingTimes;
@property (nonatomic, strong) NSNumber <Optional> *battingTimesRank;
@property (nonatomic, strong) NSNumber <Optional> *maxSpeed;
@property (nonatomic, strong) NSNumber <Optional> *maxSpeedRank;
@property (nonatomic, strong) NSNumber <Optional> *avgTime;
@property (nonatomic, strong) NSNumber <Optional> *avgStrength;

@end

@protocol JCOtherUserData

@end

@interface JCOtherUserData : JSONModel

@property (nonatomic, assign) BOOL relation;
@property (nonatomic, strong) JCOtherUserInfo <Optional> *userInfo;
@property (nonatomic, strong) JCOtherUserWeekData <Optional> *weekData;
@property (nonatomic, strong) JCOtherUserTotalData <Optional> *totalData;
@property (nonatomic, strong) NSArray *badgeList;

@end

