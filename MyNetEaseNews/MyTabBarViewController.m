//
//  MyTabBarViewController.m
//  MyNetEaseNews
//
//  Created by Bob on 17/2/14.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "ViewController.h"
#import "MyVideoViewController.h"
#import "MyViewController.h"
//#import "MyNetEaseNews-swift.h"
#import "UIImage+color.h"
#import "AnimationBar.h"
@interface MyTabBarViewController ()<UITabBarControllerDelegate>
{
    UIViewController *zhiboVC;
}
@property (nonatomic, retain) AnimationBar *homeLeftBar;

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatChildViewControllers];
}

- (void)creatChildViewControllers
{
    self.tabBar.tintColor = [UIColor redColor];

    self.delegate = self;
    ViewController *vcNews = [ViewController new];
    vcNews.tabBarItem.title = @"新闻";
    vcNews.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_icon_news_highlight"];
    vcNews.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_news_normal"];
    [self addChildViewController:vcNews];
    
    MyVideoViewController *videoVc = [MyVideoViewController new];
    videoVc.tabBarItem.title = @"搞笑";
    videoVc.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_media_normal"];
    videoVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_media_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:videoVc];
    
//    JYPlaylistViewController *zhibo = [JYPlaylistViewController new];
//    zhibo.tabBarItem.title = @"最江阴";
//    zhibo.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_bar_normal"];
//    zhibo.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_icon_bar_highlight"];
//    [self addChildViewController:zhibo];
//    zhiboVC = zhibo;
    
    
    MyViewController *myVc = [MyViewController new];
    myVc.tabBarItem.title = @"我";
    myVc.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_me_normal"];
    myVc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_icon_me_highlight"];
    [self addChildViewController:myVc];
    
    [self tabBarController:self didSelectViewController:vcNews];
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    UIBarButtonItem *leftBar;
    UIBarButtonItem *rightBar;
    if ([viewController isKindOfClass:[ViewController class]]) {
        leftBar = [[UIBarButtonItem alloc]initWithCustomView:self.homeLeftBar];
        leftBar.tintColor = [UIColor whiteColor];
        [self.homeLeftBar animation];
    
    }
    self.navigationItem.leftBarButtonItem = leftBar;
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.navigationController.navigationBarHidden = [viewController isKindOfClass:[MyViewController class]];

    
}

- (void)tapAction
{
//    [self setSelectedViewController:zhiboVC];
//    [self tabBarController:self didSelectViewController:zhiboVC];
}

- (AnimationBar *)homeLeftBar
{
    if (!_homeLeftBar) {
        _homeLeftBar = [[AnimationBar alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
        _homeLeftBar.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_homeLeftBar addGestureRecognizer:tap];
    }
    return _homeLeftBar;
}



@end
