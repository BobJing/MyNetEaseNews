//
//  VideoModel.m
//  MyNetEaseNews
//
//  Created by Bob on 17/2/14.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descriptionDe = value;
    }
}
@end
