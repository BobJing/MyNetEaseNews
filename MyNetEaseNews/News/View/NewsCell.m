//
//  NewsCell.m
//  WYNews
//
//  Created by Bob on 17/2/6.
//  Copyright © 2016年 Bob. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"

@interface NewsCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imagesView;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setNewsModel:(NewsModel *)newsModel
{
    _newsModel = newsModel;
    
    _titleLabel.text = newsModel.title;
    _sourceLabel.text = newsModel.source;
    _replyCountLabel.text = newsModel.replyCount;
    
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
    // 多图
    if(newsModel.imgextra)
    {
        [newsModel.imgextra enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_imagesView[idx] sd_setImageWithURL:[NSURL URLWithString:obj[obj.keyEnumerator.nextObject]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        }];
    }
}

@end
