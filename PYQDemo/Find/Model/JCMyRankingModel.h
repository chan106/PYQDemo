//
//  JCMyRankingModel.h
//  Victor
//
//  Created by Guo.JC on 17/3/8.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JCMyRankingModel : JSONModel

@property (nonatomic, strong) NSString <Optional>*address;
@property (nonatomic, strong) NSURL <Optional>*headerUrl;
@property (nonatomic, strong) NSString <Optional>*signature;
@property (nonatomic, strong) NSString <Optional>*smashSpeed;
@property (nonatomic, strong) NSNumber <Optional>*rangKingNumber;
@property (nonatomic, strong) NSString <Optional>*userName;
@property (nonatomic, strong) NSString <Optional>*battingTimes;
@property (nonatomic, strong) NSString <Optional>*badgeCnt;
@property (nonatomic, strong) NSString <Optional>*countryID;
@property (nonatomic, strong) NSString <Optional>*provinceID;
@property (nonatomic, strong) NSString <Optional>*cityID;
@property (nonatomic, strong) NSString <Ignore>*addressString;
@property (nonatomic, strong) NSString <Ignore> *nameWidth;

@end
