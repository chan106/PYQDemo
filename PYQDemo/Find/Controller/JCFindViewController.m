//
//  JCFindViewController.m
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCFindViewController.h"
#import "JCRankingListViewController.h"

@interface JCFindViewController ()

@property (weak, nonatomic) IBOutlet UIView *rankingListView;
@property (weak, nonatomic) IBOutlet UIView *momentsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankingListViewLeftConstraint;


@end

@implementation JCFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)switchAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _rankingListViewLeftConstraint.constant = 0;
    }else{
        _rankingListViewLeftConstraint.constant = -kWidth;
    }
    [UIView animateKeyframesWithDuration:.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
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
