//
//  NetworkTool.h
//  WYNews
//
//  Created by yaoshuai on 16/9/3.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "AFNetworking.h"

@interface NetworkTool : AFHTTPSessionManager

+ (instancetype)sharedTool;

- (void)ys_Get:(NSString *)urlString success:(void(^)(NSURLSessionDataTask *task, id responseObject))success faile:(void(^)(NSURLSessionDataTask *task, NSError *error))faile;

@end
