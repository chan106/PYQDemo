//
//  JCMomentsVC.m
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCMomentsVC.h"
#import "JCMomentsDataSource.h"
#import "MJRefresh.h"
#import "JCMomentsModel.h"
#import "JCGetLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "JCLocation.h"
#import "JCWebDataRequst+Find.h"
#import <Qiniu/QiniuSDK.h>

@interface JCMomentsVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) JCMomentsDataSource *momentsDataSource;
@property (nonatomic, strong) CLGeocoder *clGeoCoder;
@property (nonatomic, strong) CLGeocoder *coder2;

@end

@implementation JCMomentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//       
//        [JCWebDataRequst getQiniuTokenComplete:^(NSString *token) {
//            if (token) {
//                //华南
//                QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
//                    builder.zone = [QNZone zone2];
//                }];
//                QNUploadOption *option = [[QNUploadOption alloc] initWithProgressHandler:^(NSString *key, float percent) {
//                    NSLog(@"------>%f",percent);
//                }];
//                QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
//                [self uploadImages:@[@"001",@"002",@"003",@"004",@"005",@"006",@"长图"]
//                           atIndex:0
//                             token:token
//                     uploadManager:upManager
//                            option:option
//                              keys:[NSMutableArray array]];
//            }
//        }];
//        
//    });

//    NSArray *images = @[@"http://staticvictor.coollang.com/topicImage_4397_1504582775_0-400*300.jpg",
//                        @"http://staticvictor.coollang.com/topicImage_4397_1504582775_1-313*313.jpg",
//                        @"http://staticvictor.coollang.com/topicImage_4397_1504582775_2-293*220.jpg",
//                        @"http://staticvictor.coollang.com/topicImage_4397_1504582775_3-1024*640.jpg"];
//    NSString *text = @"人生若只如初见，何事秋风悲画扇。\n等闲变却故人心，却道故人心易变。\n骊山语罢清宵半，泪雨零铃终不怨。\n何如薄幸锦衣郎，比翼连枝当日愿。";
//    [JCWebDataRequst postTopicSubject:@"4图测试主题"
//                                 text:text
//                           imageArray:images
//                             position:@"位置"
//                             complete:^(WebRespondType respondType, id result) {
//                                 if (respondType == WebRespondTypeSuccess) {
//                                     NSLog(@"帖子发送成功！！！！");
//                                 }
//                             }];
    [self initCode];
    __weak typeof(self)weakSelf = self;
    [JCWebDataRequst getTopicListWithType:0 page:1 complete:^(NSArray *topicModeList) {
        weakSelf.momentsDataSource.allMomentModel = topicModeList;
        [weakSelf.tableview reloadData];
    }];
//    [[JCLocation shared] reverseGeocodeLocationWithLatitude:22.33 longitude:113.0159 complete:^(NSString *addrssString) {
//        
//    }];
    
    
}

/**
 批量上传图片至七牛服务器
 @param         images          图片数组
 @param         index           开始下标：传0即可
 @param         token           七牛token，服务器请求回来的
 @param         uploadManager   七牛manager
 @param         option          七牛option
 @param         keys            创建一个NSMutableArray传进来
 */
-(void)uploadImages:(NSArray <UIImage *>*)images
            atIndex:(NSInteger)index
              token:(NSString *)token
      uploadManager:(QNUploadManager *)uploadManager
             option:(QNUploadOption *)option
               keys:(NSMutableArray *)keys{
    
    UIImage *image = images[index];
    __block NSInteger imageIndex = index;
    NSData *data = UIImageJPEGRepresentation(image, 0.1);
    NSTimeInterval time= [[NSDate new] timeIntervalSince1970];
    NSString *filename = [NSString stringWithFormat:@"%@_%@_%.f_%ld-%d*%d.%@",@"topicImage",[JCUser currentUerID],time,imageIndex,(int)image.size.width,(int)image.size.height,@"jpg"];
    NSLog(@"\n\n======>>>>%@\n\n",filename);
    [uploadManager putData:data
                       key:filename
                     token:token
                  complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      if (info.isOK) {
                          [keys addObject:key];
                          NSLog(@"idInex %ld,OK",index);
                          imageIndex++;
                          if (imageIndex >= images.count) {
                              NSLog(@"上传完成,%@",filename);
                              for (NSString *imgKey in keys) {
                                  NSLog(@"%@",imgKey);
                              }
                              return ;
                          }
                          [self uploadImages:images atIndex:imageIndex token:token uploadManager:uploadManager option:option keys:keys];
                      }else{
                          NSLog(@"上传失败,%@",filename);
                      }
                  } option:option];
}

- (void)initCode{
    __weak typeof(self)weakSelf = self;
    _momentsDataSource = [[JCMomentsDataSource alloc] init];
    _momentsDataSource.controller = self;
    _momentsDataSource.tableview = _tableview;
    _tableview.dataSource = _momentsDataSource;
    _tableview.delegate = _momentsDataSource;
    
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf dropRefreshData];
    }];
    _tableview.mj_header.automaticallyChangeAlpha = YES;
    ((MJRefreshNormalHeader *)(_tableview.mj_header)).lastUpdatedTimeLabel.hidden = YES;
    
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMore];
    }];
}

/**
 下拉刷新数据
 */
- (void)dropRefreshData{
    [JCWebDataRequst responseTopicWithText:@"人生若只如初见，何事秋风悲画扇。\n等闲变却故人心，却道故人心易变。\n骊山语罢清宵半，泪雨零铃终不怨。\n何如薄幸锦衣郎，比翼连枝当日愿。" postID:@"20170905140815_504_20330" parentID:nil complete:^(BOOL state) {
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableview reloadData];
        [_tableview.mj_header endRefreshing];
    });
}

/**
 上拉加载更多数据
 */
- (void)loadMore{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableview.mj_footer endRefreshing];
    });
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
