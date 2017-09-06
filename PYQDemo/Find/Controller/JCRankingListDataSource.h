//
//  JCRankingListDataSource.h
//  Victor
//
//  Created by Guo.JC on 2017/9/1.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCBaseViewController.h"
@class JCRankingModel;

@interface JCRankingListDataSource : JCBaseViewController<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, weak) JCBaseViewController *controller;
@property (nonatomic, strong) NSArray *otherRankingModels;
@property (nonatomic, strong) JCRankingModel *myRankingModel;

@end
