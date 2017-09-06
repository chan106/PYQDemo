//
//  JCRankingCell.h
//  Victor
//
//  Created by Guo.JC on 17/3/8.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCMyRankingModel;
@class JCRankingModel;
@class JCRankingListCell;
@class JCRankingCell;

typedef NS_ENUM(NSInteger, ListCellType) {
    ListCellTypeMy,
    ListCellTypeOther
};

@protocol JCRankingDelegate <NSObject>

@optional
///查看用户详情
- (void)watchInfo:(JCRankingCell *)cell
           userID:(NSString *)userID
          address:(NSString *)address;
///查看点赞列表
- (void)watchLikeList:(JCRankingCell *)cell
                state:(BOOL)state
            indexPath:(NSIndexPath *)indexPath;
///查看某位点赞好友详情
- (void)watchLikeInfo:(JCRankingCell *)cell
              likerID:(NSString *)likerID;
///点赞动作
- (void)tapLike:(JCRankingCell *)cell
      likeState:(BOOL)state;
///给自己点赞或者取消赞
- (void)tapLikeSelf:(JCRankingCell *)cell
          isAddLike:(BOOL)isAddLike
           cellType:(ListCellType)cellType;

@end

@interface JCRankingCell : UITableViewCell
/**
 设置数据
 @param     model       数据模型
 @param     indexPath   索引
 @param     listType    cell类型（显示自己或者其他用户）
 @param     delegate    代理
 */
- (void)setModel:(JCRankingModel *)model
       indexPath:(NSIndexPath *)indexPath
        listType:(ListCellType)listType
        delegate:(id<JCRankingDelegate>)delegate;

@end
