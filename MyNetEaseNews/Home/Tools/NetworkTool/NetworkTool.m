//
//  NetworkTool.m
//  WYNews
//
//  Created by yaoshuai on 16/9/3.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

+ (instancetype)sharedTool
{
    static NetworkTool *tool;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        tool = [[self alloc] initWithBaseURL:baseURL];
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/jpeg",nil];
        
    });
    return tool;
}

- (void)ys_Get:(NSString *)urlString success:(void(^)(NSURLSessionDataTask *task, id responseObject))success faile:(void(^)(NSURLSessionDataTask *task, NSError *error))faile
{
    [self GET:urlString parameters:nil progress:nil success:success failure:faile];
    
}

@end
