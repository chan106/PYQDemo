//
//  JCMomentsCell.m
//  Victor
//
//  Created by Guo.JC on 2017/8/29.
//  Copyright © 2017年 coollang. All rights reserved.
//

#import "JCMomentsCell.h"
#import "UIView+JCDrawTool.h"
#import "JCMomentsModel.h"
#import "JCMomentImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <TYAttributedLabel/TYAttributedLabel.h>

#define     kCommentWidth        160

@interface JCMomentsCell ()<TYAttributedLabelDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentPopConstraint;
@property (weak, nonatomic) IBOutlet UIView *popCommentView;
@property (strong, nonatomic) JCMomentsModel *model;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) id<JCMomentsCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *momentTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *watchTextMoreBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *watchMoreHeight;
@property (weak, nonatomic) IBOutlet JCMomentImageView *imagesBoardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressTopConstraint;
/**点赞**/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likeListHeightConstraint;
@property (weak, nonatomic) IBOutlet TYAttributedLabel *likeListLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/**评论**/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentBoardHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *commentBoardView;

@end

@implementation JCMomentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _popCommentView.layer.cornerRadius = 4;
    _popCommentView.layer.masksToBounds = YES;
    [_popCommentView drawLineWithStartPoint:CGPointMake(0.5*kCommentWidth, 8) endPoint:CGPointMake(0.5*kCommentWidth, 32) lineColor:UIColorFromHex(0x333333) lineWidth:0.5];
    _headerImage.layer.cornerRadius = 22.5;
    _headerImage.layer.borderWidth = 0.5;
    _headerImage.layer.borderColor = UIColorFromHex(0x999999).CGColor;
    
    UITapGestureRecognizer *nickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nickTapAction:)];
    [_nameLabel addGestureRecognizer:nickTap];
    
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapAction:)];
    [_headerImage addGestureRecognizer:headerTap];
    [self addNitice];
    _commentPopConstraint.constant = 0;
}

- (void)addNitice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelAllEdit) name:kNoticeCancelAllEdit object:nil];
}

/**
 取消所有控件的响应
 */
- (void)cancelAllEdit{
    if (_commentPopConstraint.constant == kCommentWidth) {
        _commentPopConstraint.constant = 0;
        [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self layoutIfNeeded];
        } completion:nil];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNoticeCancelAllEdit object:nil];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

/**
 赋予数据
 @params    model           数据模型
 @params    indexPath       索引
 @params    delegate        代理
 */
- (void)setModel:(JCMomentsModel *)model
       indexPath:(NSIndexPath *)indexPath
        delegate:(id<JCMomentsCellDelegate>)delegate{
    _model = model;
    _indexPath = indexPath;
    _delegate = delegate;
    _nameLabel.text = model.userName;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.icon]
                    placeholderImage:[UIImage imageNamed:@"placehold_image"]
                           completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    _momentTextLabel.text = model.text;
    _addressLabel.text = model.address;
    _creatTimeLabel.text = model.createTime;
    _imageViewHeight.constant = model.imagesHeight;
    
    if (model.address == nil) {
        _addressTopConstraint.constant = 2;
    }else{
        _addressTopConstraint.constant = 10;
    }
    
    if (model.isNeedShowMoreBtn) {///显示更多模式
        _watchMoreHeight.constant = 30;
        _watchTextMoreBtn.hidden = NO;
        if (model.showMoreSate == ShowMoreBtnSatePackUp) {///收起
            _momentTextLabel.numberOfLines = 5;
            _watchTextMoreBtn.selected = NO;
        }else{///展开
            _momentTextLabel.numberOfLines = 0;
            _watchTextMoreBtn.selected = YES;
        }
    }else{
        _watchMoreHeight.constant = 10;
        _watchTextMoreBtn.hidden = YES;
    }
    
    [_imagesBoardView setModelData:model];
    
    _likeListHeightConstraint.constant = model.likeHeight;
    _likeListLabel.textContainer = model.likeString;
    _likeListLabel.delegate = self;
    if (model.likeHeight == 0) {
         _commentBoardHeightConstraint.constant = 0;
        _commentBoardView.hidden = YES;
    }else{
        _commentBoardHeightConstraint.constant = 8 + model.likeHeight;
        _commentBoardView.hidden = NO;
    }
}

/**
 展开、收起文本详情
 */
- (IBAction)watchMoreText:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        ///查看更多
        _momentTextLabel.numberOfLines = 0;
        _model.showMoreSate = ShowMoreBtnSateShow;
    }else{
        ///收起模式
        _momentTextLabel.numberOfLines = 5;
        _model.showMoreSate = ShowMoreBtnSatePackUp;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(watchMoreTextAction:model:indexPath:)]) {
        [self.delegate watchMoreTextAction:self model:_model indexPath:_indexPath];
    }
}

/**
 点击评论
 */
- (IBAction)commentAction:(UIButton *)sender {
    _likeBtn.selected = _model.isLike;
    if (_commentPopConstraint.constant == kCommentWidth) {
        _commentPopConstraint.constant = 0;
    }else{
        _commentPopConstraint.constant = kCommentWidth;
    }
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}

/**
 编辑评论
 */
- (IBAction)commentEdit:(UIButton *)sender {
    [self cancelAllEdit];
    
}

/**
 点赞
 */
- (IBAction)likeAction:(UIButton *)sender {
    [self cancelAllEdit];
    _model.isLike = !_model.isLike;
    [_model editLikeState:_model.isLike];
    if (self.delegate && [self.delegate respondsToSelector:@selector(editLikeAction:model:indexPath:)]) {
        [self.delegate editLikeAction:self model:_model indexPath:_indexPath];
    }
}

/**
 点击昵称
 */
- (void)nickTapAction:(UITapGestureRecognizer *)sender {
    NSLog(@"点击昵称 - %@",_model.userName);
}

/**
 点击头像
 */
- (void)headerTapAction:(UITapGestureRecognizer *)sender {
    NSLog(@"点击头像 - %@",_model.userName);
}

#pragma mark - TYAttributedLabel代理
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point{
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        id linkStr = ((TYLinkTextStorage*)TextRun).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {
            NSLog(@"%@",linkStr);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
