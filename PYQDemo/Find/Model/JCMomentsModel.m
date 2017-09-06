//
//  JCMomentsModel.m
//  PYQDemo
//
//  Created by Guo.JC on 2017/9/2.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCMomentsModel.h"
#import "NSString+CheckIsString.h"
#import "JCLocation.h"
#import "JCLikeListModel.h"
#import <YYKit/YYKit.h>
#import <TYAttributedLabel/TYAttributedLabel.h>
#import "JCUserManager.h"

@implementation JCMomentsModel

/**
 创建帖子数据模型
 @param         sourceArray         源数据，网络请求回来的数组
 @return                            解析好的数组模型
 */
+ (NSArray <JCMomentsModel *> *)creatModelWithArray:(NSArray <NSDictionary *> *)sourceArray{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *sourceDic in sourceArray) {
        JCMomentsModel *model = [JCMomentsModel new];
        model.userName = [NSString checkIfNullWithString:sourceDic[@"UserName"]];
        model.icon = [NSString checkIfNullWithString:sourceDic[@"Icon"]];
        model.userID = [NSString checkIfNullWithString:sourceDic[@"UserID"]];
        model.topicID = [NSString checkIfNullWithString:sourceDic[@"ID"]];
        model.text = [NSString checkIfNullWithString:sourceDic[@"Text"]];
        NSString *position = [NSString checkIfNullWithString:sourceDic[@"Position"]];
        model.longitude = [position componentsSeparatedByString:@","].firstObject.doubleValue;
        model.latitude = [position componentsSeparatedByString:@","].lastObject.doubleValue;
        model.address = arc4random()%100%2?nil:@"广东·深圳";
//        [[JCLocation shared] reverseGeocodeLocationWithLatitude:model.latitude
//                                                      longitude:model.longitude
//                                                       complete:^(NSString *addrssString) {
//            model.address = addrssString;
//        }];
        model.createTime = [NSString checkIfNullWithString:sourceDic[@"CreateTime"]];
        model.images = sourceDic[@"ImgList"];
        model.likeList = [NSMutableArray arrayWithArray:[JCLikeListModel creatModelWithArray:sourceDic[@"LikeList"]]];
        model.responseList = [JCMomentResponseModel creatModelWithArray:sourceDic[@"ResponseList"]];
        ///计算图片高度、文本高度、时间地址高度
        model.imagesHeight = [model caculImageViewHeight];
        model.textLabelHeight = [model caculLabelWithString:model.text width:kTextLabelWidth font:kTextFont];
        model.timeAdressHeight = model.address?kValidAdressHeight:kAvalidAdressHeight;
        ///计算点赞列表的高度及生成点赞字符串
        [model caculLikeHeight];
        ///计算cell高度
        if (model.textLabelHeight > kTextLabelNormalHeight) {
            ///需要显示更多
            model.isNeedShowMoreBtn = YES;
            model.normalCellHeight = kNickNameHeight + kTextLabelNormalHeight + kShowTextBtnHeight + model.imagesHeight + model.timeAdressHeight + (kBottomSpaceHeight + model.likeHeight + 16);
            model.showMoreCellHeight = kNickNameHeight + model.textLabelHeight + kShowTextBtnHeight + model.imagesHeight + model.timeAdressHeight + (kBottomSpaceHeight + model.likeHeight + 16);
        }else{
            ///无需显示更多
            model.isNeedShowMoreBtn = NO;
            model.normalCellHeight = model.showMoreCellHeight = kNickNameHeight + model.textLabelHeight + kHideTextBtnHeight + model.imagesHeight + model.timeAdressHeight + (kBottomSpaceHeight + model.likeHeight + 16);
        }
        model.showMoreSate = ShowMoreBtnSatePackUp;
        [modelArray addObject:model];
    }
    return [modelArray mutableCopy];
}

/**
 计算label显示需要的高度
 */
- (CGFloat)caculLabelWithString:(NSString *)string width:(CGFloat)width font:(CGFloat)font{
//    UILabel *titleLabel = [UILabel new];
//    titleLabel.font = [UIFont systemFontOfSize:font];
//    titleLabel.text = string;
//    titleLabel.numberOfLines = 0;//多行显示，计算高度
//    titleLabel.textColor = [UIColor lightGrayColor];
//    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
//                                       options:NSStringDrawingUsesLineFragmentOrigin
//                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
//    return size.height;
    //计算文本尺寸
    YYTextContainer  *titleContarer = [YYTextContainer new];
    titleContarer.size = CGSizeMake(width,CGFLOAT_MAX);
    NSMutableAttributedString  *titleAttr = [self getAttr:string];
    YYTextLayout *titleLayout = [YYTextLayout layoutWithContainer:titleContarer text:titleAttr];
    CGFloat titleLabelHeight = titleLayout.textBoundingSize.height;
    return titleLabelHeight;
}

- (NSMutableAttributedString*)getAttr:(NSString*)attributedString {
    NSMutableAttributedString * resultAttr = [[NSMutableAttributedString alloc] initWithString:attributedString];
    //对齐方式 这里是 两边对齐
    resultAttr.alignment = NSTextAlignmentJustified;
    //设置行间距
    if (iPhone5) {
        resultAttr.lineSpacing = 1.4;
    }else if (iPhone6){
        resultAttr.lineSpacing = 2.48;
    }else if (iPhonePlus){
        resultAttr.lineSpacing = 2;
    }
    //设置字体大小
    resultAttr.font = [UIFont systemFontOfSize:kTextFont];
    //可以设置某段字体的大小
    //[resultAttr yy_setFont:[UIFont boldSystemFontOfSize:CONTENT_FONT_SIZE] range:NSMakeRange(0, 3)];
    //设置字间距
    //resultAttr.yy_kern = [NSNumber numberWithFloat:1.0];
    return resultAttr;
}

/**
 计算图片显示需要的高度
 */
- (CGFloat)caculImageViewHeight{
    NSInteger count = self.images.count;
    NSInteger height = 0;
    self.isLongImage = NO;
    if (count == 1) {///一张图
        NSString *urlString = self.images.firstObject;
        NSString *sizeString = [urlString componentsSeparatedByString:@"-"].lastObject;
        CGSize imageSize = CGSizeMake([sizeString componentsSeparatedByString:@"*"].firstObject.floatValue, [sizeString componentsSeparatedByString:@"*"].lastObject.floatValue);
        CGFloat ratio;
        
        if (imageSize.width > imageSize.height)
        {
            //横图处理
            ratio = (CGFloat)imageSize.width / kImageMaxWidth;
            if (imageSize.width / 3.0 < kImageMaxWidth) {
                ///小于屏宽
                imageSize.width = imageSize.width / 3.0;
                imageSize.height = imageSize.height / 3.0;
            }else{
                ///大于屏宽
                imageSize.width = kImageMaxWidth;//宽为最大
                imageSize.height = imageSize.height / ratio;
            }
        }
        
        else if(imageSize.width < imageSize.height)
        {
            //长图处理
            if (imageSize.height / imageSize.width > 2) {
                ///长图片
                imageSize.width = imageSize.height = kImageMaxWidth;
                self.isLongImage = YES;
            }else{
                ///普通竖直方向图片
                ratio = (CGFloat)imageSize.width / kImageMaxWidth;//宽高比
                if (imageSize.width / 3.0 < kImageMaxWidth) {
                    ///小于屏宽
                    imageSize.width = imageSize.width / 3.0;
                    imageSize.height = imageSize.height / 3.0;
                }else{
                    ///大于屏宽
                    imageSize.width = kImageMaxWidth;//宽为最大
                    imageSize.height = imageSize.height / ratio;
                }
            }
        }
        else
        {
            //相等处理
            imageSize = CGSizeMake(kImageMaxWidth * 0.8, kImageMaxWidth * 0.8);
        }
        
        self.singleImageSize = imageSize;
        height = imageSize.height;
    }else if(count == 2 || count == 3){
        height = kImageHeight;
    }else{
        height = 2*kImageHeight + 4;
    }
    return height;
}

/**
 计算点赞需要的高度
 生成相应的字符串
 */
- (void)caculLikeHeight{
    TYAttributedLabel *label = [TYAttributedLabel new];
    label.verticalAlignment = TYDrawAlignmentTop;
    /**----------------------------------------------------**/
    NSMutableArray *sourceText = [NSMutableArray array];
    NSMutableArray *sourceID = [NSMutableArray array];
    [sourceText addObject:@"    "];
    [sourceID addObject:@""];
    for (JCLikeListModel *model in self.likeList) {
        [sourceText addObject:model.userName?model.userName:@"未知名字"];
        [sourceID addObject:model.userID];
    }
    NSArray *sourceArray = [sourceText mutableCopy];
    NSString *textData;
    BOOL isFirst = YES;
    for (NSString *text in sourceArray) {
        if (textData == nil) {
            textData = text;
        }else{
            if (isFirst) {
                textData = [textData stringByAppendingString:[NSString stringWithFormat:@" %@",text]];
                isFirst = NO;
            }else{
                textData = [textData stringByAppendingString:[NSString stringWithFormat:@"、%@",text]];
            }
        }
    }
    // 属性文本生成器
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
    textContainer.text = textData;
    
    for (NSInteger i = 0 ; i < sourceArray.count; i++) {
        NSRange range;
        NSString *preString;
        NSString *needString = sourceArray[i];
        NSArray *subArray = [sourceArray subarrayWithRange:NSMakeRange(0, i)];
        for (NSString *sub in subArray) {
            if (preString == nil) {
                preString = sub;
            }else{
                preString = [preString stringByAppendingString:[NSString stringWithFormat:@"、%@",sub]];
            }
        }
        NSInteger preStringLength = preString.length;
        if (preStringLength == 0) {
            range = NSMakeRange(preStringLength, needString.length);
        }else{
            range = NSMakeRange(preStringLength+1, needString.length);
        }
        [textContainer addLinkWithLinkData:sourceID[i]
                                 linkColor:UIColorFromHex(0x576b95)
                            underLineStyle:kCTUnderlineStyleNone
                                     range:range];
    }
    
    if (self.likeList && self.likeList.count > 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        imageView.image = [UIImage imageNamed:@"find_like_list"];
        [textContainer addView:imageView range:NSMakeRange(0,4)];
    }
    textContainer.linesSpacing = 4;
    textContainer.font = [UIFont boldSystemFontOfSize:13];
    textContainer = [textContainer createTextContainerWithTextWidth:kTextLabelWidth - 16];
    self.likeString = textContainer;
    self.likeHeight = textContainer.textHeight;
    if (self.likeList.count == 0 || self.likeList == nil) {
        self.likeString = nil;
        self.likeHeight = 0;
    }
}

/**
 点赞、取消赞
 @param         state        YES:点赞 NO:取消赞
 */
- (void)editLikeState:(BOOL)state{
    JCUser *user = [JCUser currentUer];
    if (state) {
        ///点赞
        JCLikeListModel *model = [JCLikeListModel new];
        model.userID = user.userID;
        model.userName = user.userInfo.nickName;
        [self.likeList addObject:model];
    }else{
        ///取消赞
        JCLikeListModel *remove;
        for (JCLikeListModel *model in self.likeList) {
            if ([model.userID isEqualToString:user.userID]) {
                remove = model;
            }
        }
        [self.likeList removeObject:remove];
    }
    ///重新计算高度、生成点赞列表字符串
    [self caculLikeHeight];
    ///计算cell高度
    if (self.textLabelHeight > kTextLabelNormalHeight) {
        ///需要显示更多
        self.isNeedShowMoreBtn = YES;
        self.normalCellHeight = kNickNameHeight + kTextLabelNormalHeight + kShowTextBtnHeight + self.imagesHeight + self.timeAdressHeight + (kBottomSpaceHeight + self.likeHeight + 16);
        self.showMoreCellHeight = kNickNameHeight + self.textLabelHeight + kShowTextBtnHeight + self.imagesHeight + self.timeAdressHeight + (kBottomSpaceHeight + self.likeHeight + 16);
    }else{
        ///无需显示更多
        self.isNeedShowMoreBtn = NO;
        self.normalCellHeight = self.showMoreCellHeight = kNickNameHeight + self.textLabelHeight + kHideTextBtnHeight + self.imagesHeight + self.timeAdressHeight + (kBottomSpaceHeight + self.likeHeight + 16);
    }
}

@end











@implementation JCMomentResponseModel

/**
 创建回复列表模型
 @param         sourceArray         源数据，网络请求回来的数组
 @return                            解析好的数组模型
 */
+ (NSArray <JCMomentResponseModel *> *)creatModelWithArray:(NSArray <NSDictionary *> *)sourceArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *sourceDic in sourceArray) {
        JCMomentResponseModel *model = [JCMomentResponseModel new];
        model.responseID = [NSString checkIfNullWithString:sourceDic[@"RID"]];
        model.creatTime = [NSString checkIfNullWithString:sourceDic[@"CreateTime"]];
        model.text = [NSString checkIfNullWithString:sourceDic[@"Text"]];
        model.parentID = [NSString checkIfNullWithString:sourceDic[@"ParentID"]];
        model.rUserID = [NSString checkIfNullWithString:sourceDic[@"RUserID"]];
        model.rUserName = [NSString checkIfNullWithString:sourceDic[@"RUserName"]];
        model.quote = [JCMomentQuotoModel creatModelWithDictionary:sourceDic[@"Quote"]];
        [array addObject:model];
    }
    return [array mutableCopy];
}

@end











@implementation JCMomentQuotoModel

/**
 创建回复谁的评论
 @param         sourceDic           源数据
 @return                            解析好的模型
 */
+ (instancetype)creatModelWithDictionary:(NSDictionary *)sourceDic{
    if (sourceDic.count == 0 || sourceDic == nil) {
        return nil;
    }
    JCMomentQuotoModel *quote = [JCMomentQuotoModel new];
    quote.userID = [NSString checkIfNullWithString:sourceDic[@"UserID"]];
    quote.userID = [NSString checkIfNullWithString:sourceDic[@"UserName"]];
    return quote;
}

@end
