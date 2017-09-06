//
//  JCRankingModel.m
//  Victor
//
//  Created by Guo.JC on 17/3/8.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCRankingModel.h"

@implementation JCRankingModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"address": @"Address",
                                                                  @"headerUrl": @"Icon",
                                                                  @"signature": @"Signature",
                                                                  @"smashSpeed": @"SmashSpeed",
                                                                  @"userID": @"UserID",
                                                                  @"userName": @"UserName",
                                                                  @"battingTimes":@"BattingTimes",
                                                                  @"countryID":@"CountryID",
                                                                  @"provinceID":@"ProvinceID",
                                                                  @"rangKingNumber": @"No",
                                                                  @"cityID":@"CityID",
                                                                  @"likes":@"Likes",
                                                                  @"isLiked":@"IsLiked"
                                                                  }];
}

@end
