//
//  VideoCell.m
//  MyNetEaseNews
//
//  Created by Bob on 17/2/14.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setModel:(VideoModel *)model{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.descriptionDe;
    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
    self.countLabel.text = [NSString stringWithFormat:@"%ld.%ld万",model.playCount/10000,model.playCount/1000-model.playCount/10000];
    self.timeDurationLabel.text = [model.ptime substringWithRange:NSMakeRange(12, 4)];

}
@end
