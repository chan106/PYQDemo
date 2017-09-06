//
//  JCRankingCell.m
//  Victor
//
//  Created by Guo.JC on 17/3/8.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCRankingCell.h"
#import "JCMyRankingModel.h"
#import "JCRankingModel.h"
#import "JCLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "POP.h"
//#import "UICountingLabel.h"
#import "TYAttributedLabel.h"
#import "RegexKitLite.h"
//#import "JCToolBox.h"
#import "JCWebDataRequst+Find.h"
//#import "CoreSVP.h"
#import "JCUserManager.h"
#import "MBProgressHUD.h"
#import "JCLikeListModel.h"

#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kBottomConstraint   10

@interface JCRankingCell  ()<TYAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UILabel *rankingNumber;
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UIImageView *headerHat;
@property (weak, nonatomic) IBOutlet UIView *line_01;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerWidth;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UIImageView *rankingImage;
@property (weak, nonatomic) IBOutlet UILabel *badgeCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeListArrow;
@property (weak, nonatomic) IBOutlet UIButton *likeListBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

///用于保存数据
@property (nonatomic, strong) JCRankingModel *model;
@property (nonatomic, assign) ListCellType listType;
@property (nonatomic, weak) id <JCRankingDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet TYAttributedLabel *likeListLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likeListLabelHeight;
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation JCRankingCell

- (void)setModel:(JCRankingModel *)model
       indexPath:(NSIndexPath *)indexPath
        listType:(ListCellType)listType
        delegate:(id<JCRankingDelegate>)delegate{
    
    _model = model;
    _listType = listType;
    _delegate = delegate;
    _indexPath = indexPath;
    
    ///UI配置
    if (listType == ListCellTypeMy) {///显示自己的数据
        _headerWidth.constant = 60;
        _header.layer.cornerRadius = 30;
        _line_01.hidden = YES;
    }else if (listType == ListCellTypeOther){///其他用户
        _headerWidth.constant = 45;
        _header.layer.cornerRadius = 22.5;
        _line_01.hidden = NO;
    }
    _header.layer.masksToBounds = YES;
    _header.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    _header.layer.borderWidth = 0.5;
    
    ///显示排名
    if ([model.rangKingNumber integerValue] < 4) {
        _rankingNumber.hidden = YES;
        _rankingImage.hidden = NO;
        _headerHat.hidden = NO;
        _rankingImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)[model.rangKingNumber integerValue]]];
        _headerHat.image = [UIImage imageNamed:[NSString stringWithFormat:@"find_hat_%ld",[model.rangKingNumber integerValue]]];
    }
    else{
        _rankingImage.hidden = YES;
        _rankingNumber.hidden = NO;
        _headerHat.hidden = YES;
    }
    ///用户昵称
    _name.text = model.userName;
    ///排名
    _rankingNumber.text = [model.rangKingNumber stringValue];
    ///头像
    [_header sd_setImageWithURL:model.headerUrl placeholderImage:[UIImage imageNamed:@"placehold_image"]];
    ///地址
    if ([model.addressString isEqualToString:@"  "]) {
        _address.text = @"未知";
    }else{
        NSString *address;
        NSArray *titles = [model.addressString componentsSeparatedByString:@" "];
        if (![model.cityID isEqualToString:@""]) {
            address = [titles[1] stringByAppendingString:[NSString stringWithFormat:@"·%@",titles[2]]];
        }else if (![model.provinceID isEqualToString:@""]){
            address = [titles[0] stringByAppendingString:[NSString stringWithFormat:@"·%@",titles[1]]];
        }else if (![model.countryID isEqualToString:@""]){
            address = titles[0];
        }
        _address.text = address;
    }
    ///显示次数
    _speed.text = model.battingTimes;
    ///徽章数量
    _badgeCountLabel.text = [NSString stringWithFormat:@"x%@",model.badgeCnt];
    ///点赞列表配置
    _likeListBtn.selected = model.isShowLikeList.boolValue;
    _likeListArrow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_likeListBtn.selected?@"find_dismiss_like":@"find_pop_like"]];
    _likeBtn.selected = model.isLiked.boolValue;
    _likeCountLabel.text = model.likes.stringValue;
    
    if (model.likes.integerValue == 0) {
        _likeListBtn.enabled = NO;
        _likeListArrow.hidden = YES;
    }else{
        _likeListBtn.enabled = YES;
        _likeListArrow.hidden = NO;
        if (model.likeListString) {
            _likeListLabel.delegate = self;
            _likeListLabel.verticalAlignment = TYDrawAlignmentTop;
            _likeListLabel.textContainer = _model.likeListString;
        }
    }
    _likeListLabelHeight.constant = _likeListBtn.selected?_model.likeListHeight.integerValue:0;
    if (model.isNeedReCalcul.integerValue == 1) {
        [self configTYAttributedLabel:model.likeListArray];
        model.isNeedReCalcul = @(0);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _likeListLabelHeight.constant = 0;
}

///配置点赞列表字符串
- (void)configTYAttributedLabel:(NSArray *)models{
    _likeListLabel.delegate = self;
    _likeListLabel.verticalAlignment = TYDrawAlignmentTop;
    _model.likeListString = [self creatTextContainer:models];
    _likeListLabel.textContainer = _model.likeListString;
    
    _likeListArrow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.likeListBtn.selected?@"find_dismiss_like":@"find_pop_like"]];
    _model.isShowLikeList = @(self.likeListBtn.selected);
    if (_delegate && [_delegate respondsToSelector:@selector(watchLikeList:state:indexPath:)]) {
        [_delegate watchLikeList:self
                           state:_likeListBtn.selected
                       indexPath:_indexPath];
    }
    _likeListArrow.alpha = 0;
    if (_rankingImage.hidden == NO) {
        _rankingImage.alpha = 0;
    }else{
        _rankingNumber.alpha = 0;
    }
    [UIView animateWithDuration:2 animations:^{
        self.likeListArrow.alpha = 1;
        if (self.rankingImage.hidden == NO) {
            self.rankingImage.alpha = 1;
        }else{
            self.rankingNumber.alpha = 1;
        }
    }];
}

- (TYTextContainer *)creatTextContainer:(NSArray *)models{
    NSMutableArray *sourceText = [NSMutableArray array];
    NSMutableArray *sourceID = [NSMutableArray array];
    [sourceText addObject:@"    "];
    [sourceID addObject:@""];
    for (JCLikeListModel *model in models) {
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
//    textContainer.font = [UIFont systemFontOfSize:12];
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
    
    if (models && models.count > 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        imageView.image = [UIImage imageNamed:@"find_like_list"];
        [textContainer addView:imageView range:NSMakeRange(0,4)];
    }
    textContainer.linesSpacing = 4;
    textContainer.font = [UIFont boldSystemFontOfSize:13];
    textContainer = [textContainer createTextContainerWithTextWidth:kWidth - 65];
    
    NSInteger placeHeight = _listType == ListCellTypeMy?88:88;
    _model.cellHeight = @(textContainer.textHeight + placeHeight + kBottomConstraint);
    _model.likeListHeight = @(textContainer.textHeight);
    if (models == nil || models.count == 0) {
        _model.cellHeight = @(88);
        _model.likeListHeight = @(0);
    }
    return textContainer;
}

#pragma mark - TYAttributedLabel代理
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point{
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        
        id linkStr = ((TYLinkTextStorage*)TextRun).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(watchInfo:userID:address:)]) {
                NSString *address;
                if ([_model.addressString isEqualToString:@"  "]) {
                    address = @"未知";
                }else{
                    NSArray *titles = [_model.addressString componentsSeparatedByString:@" "];
                    if (![_model.cityID isEqualToString:@""]) {
                        address = [titles[1] stringByAppendingString:[NSString stringWithFormat:@"·%@",titles[2]]];
                    }else if (![_model.provinceID isEqualToString:@""]){
                        address = [titles[0] stringByAppendingString:[NSString stringWithFormat:@"·%@",titles[1]]];
                    }else if (![_model.countryID isEqualToString:@""]){
                        address = titles[0];
                    }
                    _address.text = address;
                }
                [self.delegate watchInfo:self userID:linkStr address:address];
            }
        }
    }else if ([TextRun isKindOfClass:[TYImageStorage class]]) {
        TYImageStorage *imageStorage = (TYImageStorage *)TextRun;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:[NSString stringWithFormat:@"你点击了%@图片",imageStorage.imageName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

///查看点赞列表
- (IBAction)watchLikeList:(UIButton *)sender {
    sender.selected = !sender.selected;
    __weak typeof(self)weakSelf = self;
    if (sender.selected) {
        if (_model.isNeedDownList.integerValue == 0) {
            NSString *currentUserID = [JCUser currentUerID];
            NSString *userID = _model.userID?_model.userID:currentUserID;
            [MBProgressHUD showHUDAddedTo:((UIViewController *)_delegate).view animated:YES];
            [JCWebDataRequst getLikeList:userID complete:^(WebRespondType respondType, id result) {
                weakSelf.model.likeListArray = result;
                [weakSelf configTYAttributedLabel:result];
                weakSelf.model.isNeedDownList = @(1);
                [MBProgressHUD hideHUDForView:((UIViewController *)weakSelf.delegate).view animated:YES];
            }];
        }else{
            _likeListArrow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.likeListBtn.selected?@"find_dismiss_like":@"find_pop_like"]];
            _model.isShowLikeList = @(self.likeListBtn.selected);
            if (_delegate && [_delegate respondsToSelector:@selector(watchLikeList:state:indexPath:)]) {
                [_delegate watchLikeList:self
                                   state:_likeListBtn.selected
                               indexPath:_indexPath];
            }
            _likeListArrow.alpha = 0;
            if (_rankingImage.hidden == NO) {
                _rankingImage.alpha = 0;
            }else{
                _rankingNumber.alpha = 0;
            }
            [UIView animateWithDuration:2 animations:^{
                self.likeListArrow.alpha = 1;
                if (self.rankingImage.hidden == NO) {
                    self.rankingImage.alpha = 1;
                }else{
                    self.rankingNumber.alpha = 1;
                }
            }];
        }
    }else if (!sender.selected){
        _likeListArrow.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.likeListBtn.selected?@"find_dismiss_like":@"find_pop_like"]];
        _model.isShowLikeList = @(self.likeListBtn.selected);
        if (_delegate && [_delegate respondsToSelector:@selector(watchLikeList:state:indexPath:)]) {
            [_delegate watchLikeList:self
                               state:_likeListBtn.selected
                           indexPath:_indexPath];
        }
        _likeListArrow.alpha = 0;
        if (_rankingImage.hidden == NO) {
            _rankingImage.alpha = 0;
        }else{
            _rankingNumber.alpha = 0;
        }
        [UIView animateWithDuration:2 animations:^{
            self.likeListArrow.alpha = 1;
            if (self.rankingImage.hidden == NO) {
                self.rankingImage.alpha = 1;
            }else{
                self.rankingNumber.alpha = 1;
            }
        }];
    }
}

///点赞动作
- (IBAction)likeAction:(UIButton *)sender {
    __weak typeof(self)weakSelf = self;
    sender.selected = !sender.selected;
    NSString *currentUserID = [JCUser currentUerID];
    NSString *userID = _model.userID?_model.userID:currentUserID;
    if (!sender.selected) {//取消赞
        [JCWebDataRequst remmoveLike:userID complete:^(WebRespondType respondType, id result) {
            if (respondType == WebRespondTypeSuccess) {
                weakSelf.model.likes = @(weakSelf.model.likes.integerValue - 1);
                weakSelf.model.isLiked = @(0);
                weakSelf.likeCountLabel.text = weakSelf.model.likes.stringValue;
                [weakSelf likeActionState:NO userID:userID];
            }else{
                sender.selected = !sender.selected;
//                [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"稍后再试" duration:1 allowEdit:NO beginBlock:nil completeBlock:nil];
            }
        }];
    }else{//点赞
        [JCWebDataRequst addLike:userID complete:^(WebRespondType respondType, id result) {
            if (respondType == WebRespondTypeSuccess) {
                weakSelf.model.likes = @(weakSelf.model.likes.integerValue + 1);
                weakSelf.model.isLiked = @(1);
                weakSelf.likeCountLabel.text = weakSelf.model.likes.stringValue;
                [weakSelf likeActionState:YES userID:userID];
            }else{
                sender.selected = !sender.selected;
//                [CoreSVP showSVPWithType:CoreSVPTypeError Msg:@"稍后再试" duration:1 allowEdit:NO beginBlock:nil completeBlock:nil];
            }
        }];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapLike:likeState:)]) {
        [self.delegate tapLike:self likeState:sender.selected];
    }
    [UIView animateWithDuration:.3 animations:^{
        sender.transform = CGAffineTransformScale(sender.transform, 1.5, 1.5);
        sender.alpha = 0;
    } completion:^(BOOL finished) {
        sender.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:.2 animations:^{
            sender.alpha = 1;
        }];
    }];
}

- (void)likeActionState:(BOOL)isLike userID:(NSString *)userID{
    NSMutableArray *likeArray = [NSMutableArray array];
    NSString *currentID = [JCUser currentUerID];
    if (isLike) {///点赞
        likeArray = [NSMutableArray arrayWithArray:_model.likeListArray];
        JCRankingModel *model = [JCRankingModel new];
        model.userID = currentID;
        model.userName = [JCUser currentUer].userInfo.nickName;
        [likeArray addObject:model];
    }else{///取消赞
        for (JCLikeListModel *model in _model.likeListArray) {
            if (![model.userID isEqualToString:currentID]) {
                [likeArray addObject:model];
            }
        }
    }
    _model.likeListArray = [likeArray mutableCopy];
    [self configTYAttributedLabel:_model.likeListArray];
    ///如果点击的是自己，则还需要处理另外一个数据
    if ([currentID isEqualToString:userID]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tapLikeSelf:isAddLike:cellType:)]) {
            [self.delegate tapLikeSelf:self
                             isAddLike:isLike
                              cellType:self.listType];
        }
    }
}


///查看用户详情
- (IBAction)watchUserInfoAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(watchInfo:userID:address:)]) {
        NSString *userID;
        if (_model.userID) {
            userID = _model.userID;
        }else{
            userID = [JCUser currentUerID];
        }
        NSString *address;
        if ([_model.addressString isEqualToString:@"  "]) {
            address = @"未知";
        }else{
            NSArray *titles = [_model.addressString componentsSeparatedByString:@" "];
            if (![_model.cityID isEqualToString:@""]) {
                address = [titles[1] stringByAppendingString:[NSString stringWithFormat:@"·%@",titles[2]]];
            }else if (![_model.provinceID isEqualToString:@""]){
                address = [titles[0] stringByAppendingString:[NSString stringWithFormat:@"·%@",titles[1]]];
            }else if (![_model.countryID isEqualToString:@""]){
                address = titles[0];
            }
            _address.text = address;
        }
        [self.delegate watchInfo:self userID:userID address:address];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
