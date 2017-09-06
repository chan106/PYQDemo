//
//  JCRankingListDataSource.m
//  Victor
//
//  Created by Guo.JC on 2017/9/1.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCRankingListDataSource.h"
#import "JCRankingCell.h"
#import "JCRankingModel.h"

@interface JCRankingListDataSource ()

@end

@implementation JCRankingListDataSource

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.myRankingModel) {
            return 1;
        }
        return 0;
    }
    else{
        if (self.otherRankingModels) {
            return self.otherRankingModels.count;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JCRankingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JCRankingCell" forIndexPath:indexPath];
    JCRankingModel *model = indexPath.section == 0?self.myRankingModel : self.otherRankingModels[indexPath.row];
    if (indexPath.section == 1) {
        model.rangKingNumber = @(indexPath.row+1);
    }
    [cell setModel:model
         indexPath:indexPath
          listType:indexPath.section
          delegate:self.controller];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return _myRankingModel.isShowLikeList.boolValue?_myRankingModel.cellHeight.integerValue:88;
    }
    else{
        JCRankingModel *model = self.otherRankingModels[indexPath.row];
        return model.isShowLikeList.boolValue?model.cellHeight.integerValue:88;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 6)];
    view.backgroundColor = UIColorFromHex(0xf1f0f6);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        JCRankingModel *model = _otherRankingModels[indexPath.row];
        if (model.isHaveShow == nil) {
            // 从锚点位置出发，逆时针绕 Y 和 Z 坐标轴旋转90度
//            CATransform3D transform3D = CATransform3DMakeRotation(M_PI_2, 0.0, 0.5, 0.0);
//            // 定义 cell 的初始状态
////            cell.alpha = 0.0;
//            cell.layer.transform = transform3D;
//            cell.layer.anchorPoint = CGPointMake(0.0, 0.5); // 设置锚点位置；默认为中心点(0.5, 0.5)
//            // 定义 cell 的最终状态，执行动画效果
//            // 方式一：普通操作设置动画
//            [UIView beginAnimations:@"transform" context:NULL];
//            [UIView setAnimationDuration:0.5];
//            cell.alpha = 1.0;
//            cell.layer.transform = CATransform3DIdentity;
//            CGRect rect = cell.frame;
//            rect.origin.x = 0.0;
//            cell.frame = rect;
//            [UIView commitAnimations];
//            model.isHaveShow = @(1);
        }
    }
}

/**
 让分区头不再悬浮
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 6;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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
