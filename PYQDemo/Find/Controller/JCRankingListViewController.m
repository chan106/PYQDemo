//
//  JCRankingListViewController.m
//  Victor
//
//  Created by Guo.JC on 17/3/13.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCRankingListViewController.h"
#import "JCMyRankingModel.h"
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

typedef NS_ENUM(NSInteger, ShowType) {
    
    ShowTypeSpeed = 1,
    ShowTypeTimes = 2
};

typedef NS_ENUM(NSInteger, ShowPeopleType) {
    
    ShowPeopleTypeAll = 0,
    ShowPeopleTypeAttention = 1
};

@interface JCRankingListViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,JCRankingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *rankingtableView;
@property (weak, nonatomic) IBOutlet UITableView *momentsTableview;
@property (nonatomic, strong) IBOutlet UISegmentedControl *switchBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankingViewLeftConstraint;

@property (nonatomic, assign) ShowType showType;
@property (nonatomic, assign) ShowPeopleType showPeopleType;
@property (nonatomic, strong) UIButton *showPeopleBtn;
@property (nonatomic, strong) UIBarButtonItem *rankLeftItem;
@property (nonatomic, strong) UIButton *showFriendBtn;
@property (nonatomic, strong) UIBarButtonItem *friendLeftItem;
@property (nonatomic, strong) UIBarButtonItem *friendRightItem;

@property (nonatomic, strong) JCRankingListDataSource *rankListDataSource;
@property (nonatomic, strong) JCMomentsDataSource *momentsDataSource;

@end

@implementation JCRankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self configNavi];
    [self freshData:ShowTypeTimes attentionType:ShowPeopleTypeAll];
}

- (void)initUI{
    __weak typeof(self)weakSelf = self;
    _rankingtableView.backgroundColor = UIColorFromHex(0xf1f0f6);
    _rankingtableView.tableFooterView = [UIView new];
    _switchBtn.selectedSegmentIndex = 0;
    [_switchBtn addTarget:self
                   action:@selector(switchRanking:)
         forControlEvents:UIControlEventValueChanged];
    
    _rankingtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf dropRefreshData];
    }];
    _rankingtableView.mj_header.automaticallyChangeAlpha = YES;
    ((MJRefreshNormalHeader *)(_rankingtableView.mj_header)).lastUpdatedTimeLabel.hidden = YES;
    
    _rankListDataSource = [[JCRankingListDataSource alloc] init];
    _rankListDataSource.controller = self;
    _rankingtableView.dataSource = _rankListDataSource;
    _rankingtableView.delegate = _rankListDataSource;
    
    _momentsDataSource = [[JCMomentsDataSource alloc] init];
    _momentsDataSource.controller = self;
    _momentsTableview.dataSource = _momentsDataSource;
    _momentsTableview.delegate = _momentsDataSource;
}

- (void)configNavi{
    UIImage *image = [UIImage imageNamed:@"img_selection_arrow_rank"];
    _showPeopleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _showPeopleBtn.frame = CGRectMake(0, 0, 70, 30);
    _showPeopleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _showPeopleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_showPeopleBtn setTitle:@" 所有人" forState:UIControlStateNormal];
//    [_showPeopleBtn setTitleColor:kThemeOrangeColor forState:UIControlStateNormal];
    [_showPeopleBtn setImage:image forState:UIControlStateNormal];
    [_showPeopleBtn addTarget:self action:@selector(addAttention:) forControlEvents:UIControlEventTouchUpInside];
//    [_showPeopleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
//    [_showPeopleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 36, 0, -36)];
    _rankLeftItem = [[UIBarButtonItem alloc] initWithCustomView:_showPeopleBtn];
    [_showPeopleBtn sizeToFit];
    self.navigationItem.leftBarButtonItem = _rankLeftItem;
    
    _showFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _showFriendBtn.frame = CGRectMake(0, 0, 70, 30);
    _showFriendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _showFriendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_showFriendBtn setTitle:@" 推荐" forState:UIControlStateNormal];
//    [_showFriendBtn setTitleColor:kThemeOrangeColor forState:UIControlStateNormal];
    [_showFriendBtn setImage:image forState:UIControlStateNormal];
    [_showFriendBtn addTarget:self action:@selector(friendChoise:) forControlEvents:UIControlEventTouchUpInside];
//    [_showFriendBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
//    [_showFriendBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 24, 0, -24)];
    [_showFriendBtn sizeToFit];
    _friendLeftItem = [[UIBarButtonItem alloc] initWithCustomView:_showFriendBtn];
    _friendRightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(commitNew:)];
}

- (void)addAttention:(UIButton *)sender{
//
//    __weak __typeof(self) weakSelf = self;
//    JXPopoverView *popoverView = [JXPopoverView popoverView];
//    JXPopoverAction *all = [JXPopoverAction actionWithTitle:@"所有人" handler:^(JXPopoverAction *action) {
//        JCLog(@"所有人");
//        weakSelf.showPeopleType = ShowPeopleTypeAll;
//        [weakSelf.showPeopleBtn setTitle:@" 所有人" forState:UIControlStateNormal];
//        [weakSelf.showPeopleBtn sizeToFit];
//        [weakSelf freshData:weakSelf.showType attentionType:weakSelf.showPeopleType];
//    }];
//    JXPopoverAction *watch = [JXPopoverAction actionWithTitle:@"关注的人" handler:^(JXPopoverAction *action) {
//        JCLog(@"关注的人");
//        weakSelf.showPeopleType = ShowPeopleTypeAttention;
//        [weakSelf.showPeopleBtn setTitle:@" 关注的人" forState:UIControlStateNormal];
//        [weakSelf.showPeopleBtn sizeToFit];
//        [weakSelf freshData:weakSelf.showType attentionType:weakSelf.showPeopleType];
//    }];
//    [popoverView showToView:sender withActions:@[all,watch]];
}
//
- (void)friendChoise:(UIButton *)sender{
//
//    __weak __typeof(self) weakSelf = self;
//    JXPopoverView *popoverView = [JXPopoverView popoverView];
//    JXPopoverAction *all = [JXPopoverAction actionWithTitle:@"推荐" handler:^(JXPopoverAction *action) {
//        [weakSelf.showFriendBtn setTitle:@" 推荐" forState:UIControlStateNormal];
//        [weakSelf.showFriendBtn sizeToFit];
//    }];
//    JXPopoverAction *watch = [JXPopoverAction actionWithTitle:@"全部" handler:^(JXPopoverAction *action) {
//        [weakSelf.showFriendBtn setTitle:@" 全部" forState:UIControlStateNormal];
//        [weakSelf.showFriendBtn sizeToFit];
//    }];
//    [popoverView showToView:sender withActions:@[all,watch]];
}

- (void)commitNew:(UIBarButtonItem *)item{
    
}

- (void)dropRefreshData{
    if (self.showType == ShowTypeSpeed) {
        
    }else if (self.showType == ShowTypeTimes){
    }
    [self freshData:self.showType attentionType:self.showPeopleType];
}

- (void) switchRanking:(UISegmentedControl*)sender {
    ///显示速度排行榜
    if (sender.selectedSegmentIndex == 0) {
        _rankingViewLeftConstraint.constant = 0;
        self.navigationItem.leftBarButtonItem = _rankLeftItem;
        self.navigationItem.rightBarButtonItem = nil;
    }
    ///显示朋友圈
    else{
        _rankingViewLeftConstraint.constant = -kWidth;
        self.navigationItem.leftBarButtonItem = _friendLeftItem;
        self.navigationItem.rightBarButtonItem = _friendRightItem;
    }
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)freshData:(ShowType)type attentionType:(ShowPeopleType)showPeopleType{
    self.showType = type;
    __weak typeof(self) weakSelf = self;
//    [self.hud showWithString:@"Loading..."];
    NSDictionary *params = @{@"class":[NSString stringWithFormat:@"%d",3],
                             @"type":[NSString stringWithFormat:@"%ld",type],
                             @"from":[NSString stringWithFormat:@"%ld",showPeopleType]};
    [JCWebDataRequst rankingDataWithParams:params complete:^(WebRespondType respondType, id result) {
        [weakSelf showNetErrorTip:NO];
        [weakSelf.rankingtableView.mj_header endRefreshing];
        if (respondType == WebRespondTypeSuccess) {
            
            weakSelf.rankListDataSource.otherRankingModels = [NSArray arrayWithArray:result[@"models"]];
            weakSelf.rankListDataSource.myRankingModel = result[@"my"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.rankingtableView reloadData];
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
    [self.rankingtableView reloadData];
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
        [self.rankingtableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:1]]
                              withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        model = _rankListDataSource.myRankingModel;
        model.isLiked = @(isAddLike);
        NSInteger count = model.likes.integerValue;
        model.likes = isAddLike?@(count+1):@(count-1);
        [self dealData:model isAddLike:isAddLike];
        [self.rankingtableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
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

//- (WSProgressHUD *)hud{
//    if (_hud == nil) {
//        _hud = [WSProgressHUD showOnView:self.view andString:@"Loading..."];
//        [_hud dismiss];
//    }
//    return _hud;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
