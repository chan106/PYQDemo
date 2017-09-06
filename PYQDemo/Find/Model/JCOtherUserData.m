//
//  JCOtherUserInfo.m
//  Victor
//
//  Created by Guo.JC on 17/3/15.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCOtherUserData.h"

@implementation JCOtherUserInfo

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"address": @"Address",
                                                                  @"icon": @"Icon",
                                                                  @"userName": @"UserName",
                                                                  @"sportAge":@"SportAge",
                                                                  @"sportDays":@"SportDays"
                                                                  }];
}

@end

@implementation JCOtherEveryDay

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"week": @"Week",
                                                                  @"battingTimes":@"BattingTimes",
                                                                  @"maxSpeed" : @"MaxSpeed"
                                                                  }];
}

@end

@implementation JCOtherUserWeekData

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"maxSpeed": @"MaxSpeed",
                                                                  @"battingTimes":@"BattingTimes"
                                                                  }];
}

@end

@implementation JCOtherUserTotalData

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"maxSpeedRank": @"MaxSpeedRank",
                                                                  @"maxSpeed": @"MaxSpeed",
                                                                  @"battingTimesRank": @"BattingTimesRank",
                                                                  @"battingTimes":@"BattingTimes"
                                                                  }];
}

@end

@implementation JCOtherUserData

@end
