//
//  VideoCell.h
//  MyNetEaseNews
//
//  Created by Bob on 17/2/14.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;
@interface VideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UILabel *timeDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic, retain)VideoModel *model;



@end
