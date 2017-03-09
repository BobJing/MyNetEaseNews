//
//  GLHBannerView.m
//  GLHBannerView
//
//  Created by glh on 17/1/11.
//  Copyright © 2017年 glh. All rights reserved.
//

#import "GLHBannerView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT [UIScreen mainScreen].bounds.size.height
@interface GLHBannerView()<UIScrollViewDelegate>
@end
@implementation GLHBannerView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
  
        _headerView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_headerView];
        _bannerScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _bannerScrollView.delegate =  self;
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
        _bannerScrollView.bounces = NO;
        [_headerView addSubview:_bannerScrollView];
        _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH - 20, SCREEN_WIDTH, 20)];
        _pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageCtrl.pageIndicatorTintColor = [UIColor orangeColor];
        [_headerView addSubview:_pageCtrl];
    }
    return self;
}
- (void)setBannerImageArray:(NSString *)imagerUrl
{
    NSArray * arr = [imagerUrl componentsSeparatedByString:@","];
    //图片链接数组
    _imageUrlArray = [NSMutableArray arrayWithArray:arr];
    NSInteger imageCount = _imageUrlArray.count;
    if (_imageUrlArray.count > 1) {
        [self startTimer];
        NSString * strFirst = [_imageUrlArray objectAtIndex:0];
        NSString * strLast = [_imageUrlArray objectAtIndex:_imageUrlArray.count - 1];
        [_imageUrlArray insertObject:strLast atIndex:0];
        [_imageUrlArray insertObject:strFirst atIndex:_imageUrlArray.count];
        _pageCtrl.hidden = NO;
        _bannerScrollView.scrollEnabled = YES;
    }
    else
    {
        _pageCtrl.hidden = YES;
    }
    [_pageCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bannerScrollView);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(_bannerScrollView).offset(-20);
    }];
    UIView * container = [UIView new];
    [_bannerScrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(_bannerScrollView);
        make.height.equalTo(_bannerScrollView);
    }];
    if(_imageUrlArray.count)
    {
        UIImageView * lastView = nil;
        for (int i = 0; i<_imageUrlArray.count; i++)
        {
            UIImageView *bannerImageView = [[UIImageView alloc] init];
            [container addSubview:bannerImageView];
            bannerImageView.userInteractionEnabled = YES;
            bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
            //如果需要加点击事件  自己写个代理
            [bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.equalTo(container);
                make.width.mas_equalTo(_headerView);
                if (lastView) {
                    make.left.mas_equalTo(lastView.mas_right);
                }
                else
                {
                    make.left.mas_equalTo(container.mas_left);
                }
            }];
            lastView = bannerImageView;
            NSString *imageURL = _imageUrlArray[i];
            bannerImageView.image = [UIImage imageNamed:imageURL];
            bannerImageView.backgroundColor = [UIColor grayColor];
//            [bannerImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"占位图"]];
            _bannerScrollView.contentSize = CGSizeMake(_bannerScrollView.bounds.size.width * _imageUrlArray.count, _bannerScrollView.bounds.size.height);
            _pageCtrl.numberOfPages = imageCount;
            _pageCtrl.currentPage = 0;
            if (_imageUrlArray.count > 1) {
                [_bannerScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
            }
        }
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(lastView.mas_right);
        }];
    }
}
-(void)setOffSetY:(CGFloat)offSetY{
    if (offSetY == 0) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:4.0]];
    }else{
        [_timer setFireDate:[NSDate distantFuture]];
    }
    CGFloat X =  _index * offSetY;
    CGFloat Y = offSetY;
    CGFloat W = self.frame.size.width - offSetY;
    CGFloat H = self.frame.size.height - offSetY;
    _headerView.frame = CGRectMake(0, Y / 2, W, H);
    if (_imageUrlArray.count > 1) {
        NSInteger  nextIndex  = _pageCtrl.currentPage + 2;
        if (nextIndex == _imageUrlArray.count)
        {
            nextIndex = 2;
        }
        _bannerScrollView.bounds = CGRectMake((nextIndex - 1) * W, 0, W, H);
        _pageCtrl.currentPage = _index;
    }else{
        _bannerScrollView.bounds = CGRectMake(0, 0, W, H);
    }
}
-(void)startTimer{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}
-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}
- (void)timerAction:(id)sender
{
    NSInteger nextIndex = _pageCtrl.currentPage + 2;
    if (nextIndex == _imageUrlArray.count)
    {
        nextIndex = 2;
    }
    [_bannerScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * nextIndex, 0) animated:YES];
    _pageCtrl.currentPage = nextIndex - 1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (index == 0) {
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * (_imageUrlArray.count - 2), 0)];
        index = _imageUrlArray.count - 2;
    }else if(index == _imageUrlArray.count - 1)
    {
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        index = 0;
    }
    else
    {
        index = index - 1;
    }
    _pageCtrl.currentPage = index;
    _index = index;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5.0]];
}
@end
