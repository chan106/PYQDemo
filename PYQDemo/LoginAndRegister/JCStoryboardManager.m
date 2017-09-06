//
//  JCStoryboardManager.m
//  Victor
//
//  Created by Guo.JC on 2017/7/14.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCStoryboardManager.h"

static JCStoryboardManager *_manager;

@interface JCStoryboardManager ()

@end

@implementation JCStoryboardManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [JCStoryboardManager new];
    });
    return _manager;
}

- (UIStoryboard *)storyboardWithType:(StoryboardType)type{
    
    NSString *storyboardName;
    
    if (type == StoryboardTypeSport) {
        storyboardName = @"Sport";
    }
    else if (type == StoryboardTypeStudy) {
        storyboardName = @"Study";
    }
    else if (type == StoryboardTypeAnalyse) {
        storyboardName = @"Analyse";
    }
    else if (type == StoryboardTypeFind) {
        storyboardName = @"Find";
    }
    else if (type == StoryboardTypePerson) {
        storyboardName = @"Person";
    }
    else if (type == StoryboardTypeLogin) {
        storyboardName = @"Login";
    }
    else if (type == StoryboardTypeDevice) {
        storyboardName = @"Device";
    }
    
    return [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
}

+ (UIStoryboard *)storyboardForAnalyse{
    return [[self sharedManager] storyboardWithType:StoryboardTypeAnalyse];
}

+ (UIStoryboard *)storyboardForDevice{
    return [[self sharedManager] storyboardWithType:StoryboardTypeDevice];
}

+ (UIStoryboard *)storyboardForFind{
    return [[self sharedManager] storyboardWithType:StoryboardTypeFind];
}

+ (UIStoryboard *)storyboardForLogin{
    return [[self sharedManager] storyboardWithType:StoryboardTypeLogin];
}

+ (UIStoryboard *)storyboardForPerson{
    return [[self sharedManager] storyboardWithType:StoryboardTypePerson];
}

+ (UIStoryboard *)storyboardForSport{
    return [[self sharedManager] storyboardWithType:StoryboardTypeSport];
}

+ (UIStoryboard *)storyboardForStudy{
    return [[self sharedManager] storyboardWithType:StoryboardTypeStudy];
}

+ (IPhoneType)currentIphoneType{
    static IPhoneType type;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (iPhone5) {
            type = IPhoneType5_5s_SE;
        }else if (iPhone6) {
            type = IPhoneType6_6s_7;
        }else if (iPhone6BigMode){
            type = IPhoneType6_6s_7_BigMode;
        }else if (iPhonePlus){
            type = IPhoneType6P_6SP_7P;
        }else if (iPhonePlusBigMode){
            type = IPhoneType6P_6SP_7P_BigMode;
        }else{
            type = IPhoneTypeUnknow;
        }
    });
    return type;
}

@end
