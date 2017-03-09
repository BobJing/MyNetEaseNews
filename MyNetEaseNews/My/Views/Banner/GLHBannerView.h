//
//  GLHBannerView.h
//  GLHBannerView
//
//  Created by glh on 17/1/11.
//  Copyright © 2017年 glh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommodityDetailsModel;
@interface GLHBannerView : UIView
{
    UIPageControl *_pageCtrl;
    NSMutableArray *_imageUrlArray;
}
//一般接口传的多张图片是一个字符串 需要自己分成数组
- (void)setBannerImageArray:(NSString *)imagerUrl;
@property (nonatomic, strong) UIScrollView *bannerScrollView;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat offSetY;
@end
