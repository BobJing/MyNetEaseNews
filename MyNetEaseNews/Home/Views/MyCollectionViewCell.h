//
//  MyCollectionViewCell.h
//  MyNetEaseNews
//
//  Created by Bob on 17/2/5.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JB_TopMenuScrollView.h"
@interface MyCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) ChannelModel *channelModel;
@property (nonatomic, weak) UINavigationController *nav;
@end
