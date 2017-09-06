//
//  JCStoryboardManager.h
//  Victor
//
//  Created by Guo.JC on 2017/7/14.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define         iPhone5                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define         iPhone6                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define         iPhone6BigMode          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define         iPhonePlus              ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define         iPhonePlusBigMode       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

typedef NS_ENUM(NSInteger, StoryboardType) {
    StoryboardTypeSport,
    StoryboardTypeStudy,
    StoryboardTypeAnalyse,
    StoryboardTypeFind,
    StoryboardTypePerson,
    StoryboardTypeLogin,
    StoryboardTypeDevice
};

typedef NS_ENUM(NSInteger, IPhoneType) {
    IPhoneTypeUnknow,
    IPhoneType5_5s_SE,
    IPhoneType6_6s_7,
    IPhoneType6_6s_7_BigMode,
    IPhoneType6P_6SP_7P,
    IPhoneType6P_6SP_7P_BigMode
};

static NSString *const SBID_PracticeVC = @"JCPracticeViewController";
static NSString *const SBID_PracticeNavi = @"SportNavi";
static NSString *const SBID_ReportVC = @"JCReportViewController";

static NSString *const SBID_StudyVC = @"JCStudyVC";
static NSString *const SBID_StudyCourseVC = @"JCStudyCourseViewController";
static NSString *const SBID_ClassDetailVC = @"JCClassDetail";
static NSString *const SBID_StudyHistoryVC = @"JCStudyHistoryViewController";
static NSString *const SBID_CoachVC = @"JCCoachViewController";
static NSString *const SBID_MatchVC = @"JCMatchViewController";
static NSString *const SBID_TemplateListVC = @"JCTemplateListViewController";
static NSString *const SBID_StudyVideoVC = @"JCStudyVideoViewController";

static NSString *const SBID_AnalyseNavi = @"analyseNavi";
static NSString *const SBID_AnalyseVC = @"JCAnalyseViewController";
static NSString *const SBID_SessionAnalyseVC = @"JCSessionAnalyseViewController";

static NSString *const SBID_RankNavi = @"RankNavi";
static NSString *const SBID_RankingListVC = @"JCRankingListViewController";
static NSString *const SBID_RankInfoVC = @"JCRankInfoViewController";

static NSString *const SBID_PersonVC = @"JCPersonViewController";
static NSString *const SBID_PersonDetailVC = @"JCPersonDetailViewController";
static NSString *const SBID_HistoryVC = @"JCHistoryViewController";
static NSString *const SBID_DayDetailVC = @"JCDayDetailViewController";
static NSString *const SBID_TotalVC = @"JCTotalViewController";
static NSString *const SBID_AboutUsVC = @"JCAboutUSViewController";

static NSString *const SBID_DeviceNavi = @"JCDeviceViewControllerNavi";
static NSString *const SBID_DeviceVC = @"JCDeviceViewController";
static NSString *const SBID_UpdateVC = @"JCUpdateViewController";

static NSString *const SBID_LoginHomeVC = @"JCLoginViewController";
static NSString *const SBID_LoginAccountVC = @"JCLogAccount";
static NSString *const SBID_LoginRegisterVC = @"JCRegisterAccount";
static NSString *const SBID_LoginChangePSWVC = @"JCChangePassWord";
static NSString *const SBID_LoginWelcomeVC = @"JCWelcomeViewController";

@interface JCStoryboardManager : NSObject

+ (instancetype)sharedManager;

+ (UIStoryboard *)storyboardForAnalyse;
+ (UIStoryboard *)storyboardForDevice;
+ (UIStoryboard *)storyboardForFind;
+ (UIStoryboard *)storyboardForLogin;
+ (UIStoryboard *)storyboardForPerson;
+ (UIStoryboard *)storyboardForSport;
+ (UIStoryboard *)storyboardForStudy;

- (UIStoryboard *)storyboardWithType:(StoryboardType)type;
+ (IPhoneType)currentIphoneType;
@end
