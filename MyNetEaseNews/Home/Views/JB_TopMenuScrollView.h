//
//  JB_TopMenuScrollView.h
//  MyNetEaseNews
//
//  Created by Bob on 17/2/5.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JB_TopMenuScrollView;
@protocol JB_TopMenuScrollViewDelegate <NSObject>
- (void)JB_TopMenuScrollView:(JB_TopMenuScrollView *)JB_ScrollView DidTapLabelIndex:(NSIndexPath *)indexPath;


@end
@interface JB_TopMenuScrollView : UIScrollView
@property (nonatomic, retain) NSArray *channelModelArray;

@property (nonatomic, assign) id<JB_TopMenuScrollViewDelegate>delegate2;

- (void)J_ScrollView_MainScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)J_ScrollView_MainScrollViewEndScroll:(UIScrollView *)scrollView;


@end












@class ChannelModel;

@interface ChannelLabel : UILabel

@property (strong, nonatomic) ChannelModel *channelModel;

@property (assign, nonatomic) CGFloat scale;

@end


@interface ChannelModel : NSObject

/**
 *  频道ID
 */
@property (copy, nonatomic) NSString *tid;

/**
 *  频道名称
 */
@property (copy, nonatomic) NSString *tname;

/**
 *  获取频道列表
 *
 *  @return 频道列表
 */
+ (NSArray<ChannelModel *> *)channels;

@end
