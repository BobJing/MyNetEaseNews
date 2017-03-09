//
//  NewsCell.h
//  WYNews
//
//  Created by Bob on 17/2/6.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface NewsCell : UITableViewCell

@property (strong, nonatomic) NewsModel *newsModel;

@end
