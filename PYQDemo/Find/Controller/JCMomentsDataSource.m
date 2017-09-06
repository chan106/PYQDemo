//
//  JCMomentsDataSource.m
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCMomentsDataSource.h"
#import "JCMomentsCell.h"
#import "JCMomentsModel.h"

@interface JCMomentsDataSource ()<JCMomentsCellDelegate>

@end

@implementation JCMomentsDataSource

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allMomentModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCMomentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JCMomentsCell" forIndexPath:indexPath];
    JCMomentsModel *model = _allMomentModel[indexPath.row];
    [cell setModel:model indexPath:indexPath delegate:self];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JCMomentsModel *model = _allMomentModel[indexPath.row];
    return model.showMoreSate == ShowMoreBtnSatePackUp?model.normalCellHeight:model.showMoreCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    CGFloat sectionHeaderHeight = 6;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//
//}

- (void)watchMoreTextAction:(JCMomentsCell *)cell
                      model:(JCMomentsModel *)model
                  indexPath:(NSIndexPath *)indexPath{
    [self.tableview reloadData];
}

- (void)editLikeAction:(JCMomentsCell *)cell
                 model:(JCMomentsModel *)model
             indexPath:(NSIndexPath *)indexPath{
    [self.tableview reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNoticeCancelAllEdit object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
