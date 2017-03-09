//
//  AppDelegate.h
//  MyNetEaseNews
//
//  Created by Bob on 17/1/13.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)showShareActionWithTitle: (NSString *)title ct: (NSString *)ct url:(NSString *) url imageUrl: (id)imageUrl  controller: (UIViewController *)controller;
@end

