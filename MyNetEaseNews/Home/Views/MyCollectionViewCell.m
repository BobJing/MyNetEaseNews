//
//  MyCollectionViewCell.m
//  MyNetEaseNews
//
//  Created by Bob on 17/2/5.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "MyTableViewController.h"
@interface MyCollectionViewCell()
{
    MyTableViewController *_newsVC;
}
@end
@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MyTableViewController" bundle:nil];
        _newsVC = [sb instantiateInitialViewController];
        _newsVC.tableView.frame = self.contentView.bounds;
        [self.contentView addSubview:_newsVC.tableView];
    }
    return self;
}

- (void)setChannelModel:(ChannelModel *)channelModel
{
    _channelModel = channelModel;
    
    _newsVC.tid = channelModel.tid;
    _newsVC.nav = self.nav;
}

@end
