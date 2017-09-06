//
//  JCMomentsDataSource.h
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCBaseViewController.h"

@interface JCMomentsDataSource : JCBaseViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) JCBaseViewController *controller;
@property (nonatomic, weak) UITableView *tableview;
@property (nonatomic, strong) NSArray *allMomentModel;

@end
