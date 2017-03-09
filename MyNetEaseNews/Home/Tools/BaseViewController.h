//
//  BaseViewController.h
//  MyNetEaseNews
//
//  Created by Bob on 17/2/14.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface BaseViewController : UIViewController
@property (nonatomic,retain) MBProgressHUD* hud;
- (void)addHud;
- (void)addHudWithMessage:(NSString*)message;
- (void)removeHud;
@end
