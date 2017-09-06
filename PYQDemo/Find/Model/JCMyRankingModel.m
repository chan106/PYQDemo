//
//  JCMyRankingModel.m
//  Victor
//
//  Created by Guo.JC on 17/3/8.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCMyRankingModel.h"

@implementation JCMyRankingModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"address": @"Address",
                                                                  @"headerUrl": @"Icon",
                                                                  @"signature": @"Signature",
                                                                  @"smashSpeed": @"SmashSpeed",
                                                                  @"rangKingNumber": @"No",
                                                                  @"userName": @"UserName",
                                                                  @"battingTimes":@"BattingTimes",
                                                                  @"countryID":@"CountryID",
                                                                  @"provinceID":@"ProvinceID",
                                                                  @"cityID":@"CityID"
                                                                  }];
}

@end
