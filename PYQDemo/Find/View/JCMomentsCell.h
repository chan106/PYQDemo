//
//  JCSocialCell.h
//  Victor
//
//  Created by Guo.JC on 2017/8/29.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCMomentsModel;
@class JCMomentsCell;

#define     kNoticeCancelAllEdit        @"cancelAllEdit"

@protocol JCMomentsCellDelegate <NSObject>

- (void)watchMoreTextAction:(JCMomentsCell *)cell
                      model:(JCMomentsModel *)model
                  indexPath:(NSIndexPath *)indexPath;

- (void)editLikeAction:(JCMomentsCell *)cell
                 model:(JCMomentsModel *)model
             indexPath:(NSIndexPath *)indexPath;

@end

@interface JCMomentsCell : UITableViewCell

/**
 赋予数据
 @params    model           数据模型
 @params    indexPath       索引
 @params    delegate        代理
 */
- (void)setModel:(JCMomentsModel *)model
       indexPath:(NSIndexPath *)indexPath
        delegate:(id<JCMomentsCellDelegate>)delegate;

@end
