//
//  JCRankListVC.m
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCRankListVC.h"
#import "JCRankingModel.h"
#import "JCRankingCell.h"
#import "WebRequest.h"
#import "JCUserManager.h"
#import "JCMomentsCell.h"
#import "JCRankingListDataSource.h"
#import "JCLikeListModel.h"
#import "JCWebDataRequst+Find.h"
#import "JCWebDataRequst.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "JCMomentsDataSource.h"

@interface JCRankListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) JCRankingListDataSource *rankListDataSource;

@end

@implementation JCRankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCode];
    [self freshData:2 attentionType:0];
}

- (void)initCode{
    __weak typeof(self)weakSelf = self;
    _tableView.backgroundColor = UIColorFromHex(0xf1f0f6);
    _tableView.tableFooterView = [UIView new];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf dropRefreshData];
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    ((MJRefreshNormalHeader *)(_tableView.mj_header)).lastUpdatedTimeLabel.hidden = YES;
    
    _rankListDataSource = [[JCRankingListDataSource alloc] init];
    _rankListDataSource.controller = self;
    _tableView.dataSource = _rankListDataSource;
    _tableView.delegate = _rankListDataSource;
}

- (void)dropRefreshData{
    [self freshData:2 attentionType:0];
}

- (void)freshData:(NSInteger)type attentionType:(NSInteger)showPeopleType{
    __weak typeof(self) weakSelf = self;
    //    [self.hud showWithString:@"Loading..."];
    NSDictionary *params = @{@"class":[NSString stringWithFormat:@"%d",3],
                             @"type":[NSString stringWithFormat:@"%ld",type],
                             @"from":[NSString stringWithFormat:@"%ld",showPeopleType]};
    [JCWebDataRequst rankingDataWithParams:params complete:^(WebRespondType respondType, id result) {
        [weakSelf showNetErrorTip:NO];
        [weakSelf.tableView.mj_header endRefreshing];
        if (respondType == WebRespondTypeSuccess) {
            
            weakSelf.rankListDataSource.otherRankingModels = [NSArray arrayWithArray:result[@"models"]];
            weakSelf.rankListDataSource.myRankingModel = result[@"my"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                //                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                //                                  withRowAnimation:UITableViewRowAnimationBottom];
            });
            //            [weakSelf.hud dismiss];
        }
        else if (respondType == WebRespondTypeNotLogin){
            //            [weakSelf.hud showString:kMsgNotLogin dimissAfterSecond:1];
        }
        else{
            [weakSelf showNetErrorTip:YES];
            //            [weakSelf.hud showString:kMsgNetError dimissAfterSecond:1];
        }
    }];
}

#pragma mark -- CELL代理回调
///查看点赞列表
- (void)watchLikeList:(JCRankingListCell *)cell state:(BOOL)state indexPath:(NSIndexPath *)indexPath{
    [self.tableView reloadData];
    //    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
    //                          withRowAnimation:UITableViewRowAnimationNone];
}

///查看点赞人的详情
- (void)watchInfo:(JCRankingListCell *)cell
           userID:(NSString *)userID
          address:(NSString *)address{
    //    JCRankInfoViewController *infoVC = [[[JCStoryboardManager sharedManager] storyboardWithType:StoryboardTypeFind] instantiateViewControllerWithIdentifier:SBID_RankInfoVC];
    //    infoVC.hidesBottomBarWhenPushed = YES;
    //    infoVC.userID = userID;
    //    infoVC.addressString = address;
    //    [self.navigationController pushViewController:infoVC animated:YES];
}

///给自己点赞或者取消赞是处理另一个数据
- (void)tapLikeSelf:(JCRankingCell *)cell
          isAddLike:(BOOL)isAddLike
           cellType:(ListCellType)cellType{
    JCRankingModel *model;
    
    if (cellType == ListCellTypeMy) {
        NSInteger row = 0;
        for (NSInteger i = 0; i < _rankListDataSource.otherRankingModels.count; i++) {
            JCRankingModel *otherModel = _rankListDataSource.otherRankingModels[i];
            if ([otherModel.userID isEqualToString:[JCUser currentUerID]]) {
                row = i;
            }
        }
        model = _rankListDataSource.otherRankingModels[row];
        model.isLiked = @(isAddLike);
        NSInteger count = model.likes.integerValue;
        model.likes = isAddLike?@(count+1):@(count-1);
        [self dealData:model isAddLike:isAddLike];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:1]]
                                     withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        model = _rankListDataSource.myRankingModel;
        model.isLiked = @(isAddLike);
        NSInteger count = model.likes.integerValue;
        model.likes = isAddLike?@(count+1):@(count-1);
        [self dealData:model isAddLike:isAddLike];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                                     withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)dealData:(JCRankingModel *)model isAddLike:(BOOL)isAddLike{
    NSMutableArray *likeArray = [NSMutableArray array];
    NSString *currentID = [JCUser currentUerID];
    if (isAddLike) {///点赞
        likeArray = [NSMutableArray arrayWithArray:model.likeListArray];
        JCRankingModel *model = [JCRankingModel new];
        model.userID = currentID;
        model.userName = [JCUser currentUer].userInfo.nickName;
        [likeArray addObject:model];
    }else{///取消赞
        for (JCLikeListModel *m in model.likeListArray) {
            if (![m.userID isEqualToString:currentID]) {
                [likeArray addObject:m];
            }
        }
    }
    model.likeListArray = [likeArray mutableCopy];
    model.isNeedReCalcul = @(1);
    ///重新计算cell高度等
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
