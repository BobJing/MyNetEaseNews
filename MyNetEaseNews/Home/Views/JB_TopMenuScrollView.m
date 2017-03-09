//
//  JB_TopMenuScrollView.m
//  MyNetEaseNews
//
//  Created by Bob on 17/2/5.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "JB_TopMenuScrollView.h"
#import "YYModel.h"

#define channelLabelWidth 80
#define channelLabelHeight self.frame.size.height
@interface JB_TopMenuScrollView()
{
    NSMutableArray<ChannelLabel*> *_channelLabelArray;
}

@end
@implementation JB_TopMenuScrollView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setUpUI];
//    
//    }
//    return self;
//}
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self setUpUI];
//}

- (void)setChannelModelArray:(NSArray *)channelModelArray
{
    _channelModelArray = channelModelArray;
    [self setUpUI];
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.95];
    _channelLabelArray = [NSMutableArray array];
    // 频道列表
    [_channelModelArray enumerateObjectsUsingBlock:^(ChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = channelLabelWidth * idx;
        
        ChannelLabel *label = [[ChannelLabel alloc] initWithFrame:CGRectMake(x, 0, channelLabelWidth, channelLabelHeight)];
        [self addSubview:label];
        [_channelLabelArray addObject:label];
        
        // 设置label属性
        label.channelModel = obj;
        label.tag = idx;
        
        // 设置label点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelLabelTap:)];
        [label addGestureRecognizer:tap];
        
        // 第1个label，默认选中，缩放比最大
        if(!idx)
        {
            label.scale = 1.0;
        }
    }];
    self.contentSize = CGSizeMake(channelLabelWidth * _channelModelArray.count, 0);
//    UIView *line = [UIView new];
//    line.frame = CGRectMake(0, self.frame.size.height-0.5, self.contentSize.width, 0.5);
//    line.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:line];
}

- (void)channelLabelTap:(UITapGestureRecognizer *)recognizer
{
    ChannelLabel *label = (ChannelLabel *)recognizer.view;
    NSInteger labelIdx = label.tag;
    
    // 改变label的颜色及字号，缩放比为0
    [_channelLabelArray enumerateObjectsUsingBlock:^(ChannelLabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.scale = 0;
    }];
    label.scale = 1.0;// 当前选中label的缩放比为1
    
    // 改变频道滚动视图的偏移量
    CGFloat offsetX = label.center.x - self.center.x;
    CGFloat minimumOffsetX = 0;
    CGFloat maximunOffsetX = self.contentSize.width - self.frame.size.width;
    if(offsetX < minimumOffsetX)
        offsetX = minimumOffsetX;
    else if(offsetX > maximunOffsetX)
        offsetX = maximunOffsetX;
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    // 改变新闻视图对应的偏移量
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:labelIdx inSection:0];
//    [_newsCV scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    if ([_delegate2 respondsToSelector:@selector(JB_TopMenuScrollView:DidTapLabelIndex:)]) {
        {
            [_delegate2 JB_TopMenuScrollView:self DidTapLabelIndex:indexPath];
        }
    }
}


- (void)J_ScrollView_MainScrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;// 偏移量
    NSInteger idx = offsetX / scrollView.frame.size.width;// 浮点索引
    CGFloat idx_float = offsetX / scrollView.frame.size.width;// 整形索引
    CGFloat percent = idx_float - idx;// 百分比
    
    NSInteger left_idx = idx;// 左边索引
    NSInteger right_idx = idx + 1;// 右边索引
    
    CGFloat right_scale = percent;// 右边缩放比
    CGFloat left_scale = 1 - percent;// 左边缩放比
    
    ChannelLabel *leftLabel = _channelLabelArray[left_idx];
    leftLabel.scale = left_scale;
    if(right_idx < _channelLabelArray.count)
    {
        ChannelLabel *rightLabel = _channelLabelArray[right_idx];
        rightLabel.scale = right_scale;
    }

}
- (void)J_ScrollView_MainScrollViewEndScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [_channelLabelArray enumerateObjectsUsingBlock:^(ChannelLabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.scale = index == idx;
    }];
    
    // 改变频道滚动视图的偏移量
    ChannelLabel *label = _channelLabelArray[index];
    CGFloat offsetX = label.center.x - self.center.x;
    CGFloat minimumOffsetX = 0;
    CGFloat maximunOffsetX = self.contentSize.width - self.frame.size.width;
    if(offsetX < minimumOffsetX)
        offsetX = minimumOffsetX;
    else if(offsetX > maximunOffsetX)
        offsetX = maximunOffsetX;
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation ChannelLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor darkGrayColor];
        self.font = [UIFont systemFontOfSize:15.0f];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setChannelModel:(ChannelModel *)channelModel
{
    _channelModel = channelModel;
    
    self.text = channelModel.tname;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale*0.7+0.3 green:0.3 blue:0.3 alpha:1];
    
    CGFloat minimumScale = 1.0;
    CGFloat maximumScale = 1.2;
    
    scale = minimumScale + (maximumScale - minimumScale) * scale;
    
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

@end

@implementation ChannelModel

+ (NSArray<ChannelModel *> *)channels
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    NSArray<NSDictionary *> *arr = rootDict[@"tList"];
    
    // 使用YYModel将字典数组转换为模型数组
    NSArray<ChannelModel *> *modelArr = [NSArray yy_modelArrayWithClass:[ChannelModel class] json:arr];
    
    [modelArr sortedArrayUsingComparator:^NSComparisonResult(ChannelModel *  _Nonnull obj1, ChannelModel *  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    return modelArr;
}

@end
