//
//  JCMomentsModel.h
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>
@class JCLikeListModel;
@class JCMomentResponseModel;
@class JCMomentQuotoModel;
@class TYTextContainer;
@class JCUser;

#define     kTextLabelWidth                 (kWidth - 85)
#define     kTextLabelNormalHeight          84
#define     kWatchMoreBtnHeight             30
#define     kImageHeight                    (kAutoWid(85))
#define     kImageMaxWidth                  (kWidth - 85)
#define     kTextFont                       14

#define     kNickNameHeight                 46
#define     kShowTextBtnHeight              30
#define     kHideTextBtnHeight              10
#define     kValidAdressHeight              45
#define     kAvalidAdressHeight             22
#define     kBottomSpaceHeight              6
#define     kBottomHeight                   56 ///底部点赞+评论+间隙高度（临时用）

typedef NS_ENUM(NSInteger, ShowMoreBtnSate) {
    ///收起
    ShowMoreBtnSatePackUp,
    ///全文
    ShowMoreBtnSateShow
};

/**
 帖子数据模型
 */
@interface JCMomentsModel : NSObject

@property (nonatomic, strong) NSString *userName;           //用户名
@property (nonatomic, strong) NSString *userID;             //用户ID
@property (nonatomic, strong) NSString *topicID;            //帖子ID
@property (nonatomic, strong) NSString *icon;               //头像
@property (nonatomic, strong) NSString *text;               //文本内容
@property (nonatomic, strong) NSArray *images;              //图片url数组
@property (nonatomic, assign) double longitude;             //经度
@property (nonatomic, assign) double latitude;              //纬度
@property (nonatomic, strong) NSString *address;            //地址
@property (nonatomic, strong) NSString *createTime;         //创建时间
@property (nonatomic, assign) BOOL isLike;                  //自己是否点过赞
@property (nonatomic, strong) NSMutableArray <JCLikeListModel *> *likeList;    //点赞人数
@property (nonatomic, strong) TYTextContainer *likeString;
@property (nonatomic, strong) NSArray <JCMomentResponseModel *> *responseList;    //回复列表
/**--------------------------------------------------------------------------------------**/
@property (nonatomic, assign) CGSize singleImageSize;             //单张图片时的size
@property (nonatomic, assign) BOOL isLongImage;
@property (nonatomic, assign) NSInteger normalCellHeight;   //cell高度
@property (nonatomic, assign) NSInteger showMoreCellHeight; //cell高度
@property (nonatomic, assign) NSInteger textLabelHeight;    //文本高度
@property (nonatomic, assign) BOOL isNeedShowMoreBtn;       //是否需要显示更多
@property (nonatomic, assign) ShowMoreBtnSate showMoreSate; //[显示更多]button的状态
@property (nonatomic, assign) NSInteger imagesHeight;       //图片高度
@property (nonatomic, assign) NSInteger timeAdressHeight;   //时间地址高度
@property (nonatomic, assign) NSInteger likeHeight;         //点赞高度
@property (nonatomic, assign) NSInteger commentHeigh;       //评论高度

/**
 创建帖子数据模型
 @param         sourceArray         源数据，网络请求回来的数组
 @return                            解析好的数组模型
 */
+ (NSArray <JCMomentsModel *> *)creatModelWithArray:(NSArray <NSDictionary *> *)sourceArray;

/**
 计算label显示需要的高度
 */
- (CGFloat)caculLabelWithString:(NSString *)string
                          width:(CGFloat)width
                           font:(CGFloat)font;

/**
 计算图片显示需要的高度
 */
- (CGFloat)caculImageViewHeight;

/**
 点赞、取消赞
 @param         state        YES:点赞 NO:取消赞
 */
- (void)editLikeState:(BOOL)state;

@end









/**
 回复列表数据模型
 */
@interface JCMomentResponseModel : NSObject

@property (nonatomic, strong) NSString *responseID;                 //回复ID
@property (nonatomic, strong) NSString *creatTime;
@property (nonatomic, strong) NSString *text;                       //回复内容
@property (nonatomic, strong) NSString *parentID;
@property (nonatomic, strong) NSString *rUserID;
@property (nonatomic, strong) NSString *rUserName;
@property (nonatomic, strong) JCMomentQuotoModel *quote;

/**
 创建回复列表模型
 @param         sourceArray         源数据，网络请求回来的数组
 @return                            解析好的数组模型
 */
+ (NSArray <JCMomentResponseModel *> *)creatModelWithArray:(NSArray <NSDictionary *> *)sourceArray;

@end










@interface JCMomentQuotoModel : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;

/**
 创建回复谁的评论
 @param         sourceDic           源数据
 @return                            解析好的模型
 */
+ (instancetype)creatModelWithDictionary:(NSDictionary *)sourceDic;

@end
