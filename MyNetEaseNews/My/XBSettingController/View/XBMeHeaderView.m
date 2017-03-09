//
//  XBMeHeaderView.m
//  xiu8iOS
//
//  Created by Scarecrow on 15/9/19.
//  Copyright (c) 2015年 xiu8. All rights reserved.
//

#import "XBMeHeaderView.h"
@interface XBMeHeaderView()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *circleBg;
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIView *alreadyLoginView;

@property (weak, nonatomic) IBOutlet UIView *noLoginView;

@end
@implementation XBMeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupHeaderCircle];

}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.imgView.frame = self.bounds;
}

- (void)loginStateChanged:(BOOL)loginState
{
    self.noLoginView.hidden = loginState;
    self.alreadyLoginView.hidden = !loginState;
}

- (IBAction)loginBtnDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(XBMeHeaderViewBtnClicked:)]) {
        [self.delegate XBMeHeaderViewBtnClicked:XBMeHeaderViewButtonTypeLogin];
    }
}

- (IBAction)registerBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(XBMeHeaderViewBtnClicked:)]) {
        [self.delegate XBMeHeaderViewBtnClicked:XBMeHeaderViewButtonTypeRegister];
    }
}

- (IBAction)attentionBtnDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(XBMeHeaderViewBtnClicked:)]) {
        [self.delegate XBMeHeaderViewBtnClicked:XBMeHeaderViewButtonTypeAttention];
    }
}

- (IBAction)historyBtnDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(XBMeHeaderViewBtnClicked:)]) {
        [self.delegate XBMeHeaderViewBtnClicked:XBMeHeaderViewButtonTypeHistory];
    }
}

- (IBAction)guardBtnDidClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(XBMeHeaderViewBtnClicked:)]) {
        [self.delegate XBMeHeaderViewBtnClicked:XBMeHeaderViewButtonTypeGuard];
    }
}


- (void)setOffSet:(CGFloat) offset
{
    CGFloat X =  offset/2.0;
    CGFloat Y = offset;
    CGFloat W = self.frame.size.width - offset;
    CGFloat H = 200 - offset;
    self.imgView.frame = CGRectMake(X, Y, W, H);

}
- (void)setupHeaderCircle
{
//    self.circleBg.layer.cornerRadius = self.circleBg.height * 0.5;
//    self.header.layer.cornerRadius = self.header.width * 0.5;
//    self.header.clipsToBounds = YES;
//    self.circleBg.clipsToBounds = YES;
}

@end
