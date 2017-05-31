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
#import "PYSearch.h"
@interface MyTabBarViewController ()<UITabBarControllerDelegate,PYSearchViewControllerDelegate>
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
        
        rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchAction"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoSearchAction)];
         rightBar.tintColor = [UIColor whiteColor];
     
    }
    self.navigationItem.leftBarButtonItem = leftBar;
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.navigationController.navigationBarHidden = [viewController isKindOfClass:[MyViewController class]];

    
}

- (void)gotoSearchAction
{
      NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    PYSearchViewController *searchVC = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
       
        
    }];
    searchVC.delegate = self;
    //搜索风格
    searchVC.searchHistoryStyle = PYHotSearchStyleDefault;
    [self.navigationController pushViewController:searchVC animated:YES];
    
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

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


@end
