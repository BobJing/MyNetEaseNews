//
//  NewsModel.h
//  MyNetEaseNews
//
//  Created by Bob on 17/2/5.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

/**
 *  新闻标题
 */
@property (nonatomic,copy) NSString *title;

/**
 *  新闻主图片
 */
@property (nonatomic,copy) NSString *imgsrc;

/**
 *  新闻来源
 */
@property (nonatomic,copy) NSString *source;

/**
 *  新闻回复数
 */
@property (nonatomic,copy) NSString *replyCount;

/**
 *  是否是大图新闻
 */
@property (assign, nonatomic) NSInteger imgType;

/**
 *  多图新闻的后2张图片
 */
@property (strong, nonatomic) NSArray<NSDictionary *> *imgextra;


@property (nonatomic,copy) NSString *postid;

@property (nonatomic,copy) NSString *docid;
@property (nonatomic,copy) NSString *photosetID;

@end
