//
//  AppDelegate.m
//  MyNetEaseNews
//
//  Created by Bob on 17/1/13.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "XHLaunchAd.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self customInterFace];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self setUpAdVC];
    return YES;
}


- (void)customInterFace
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    NSDictionary *textAttributes = nil;
    
    NSDictionary *navLeftAndRightItemAtt =nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
        
        navLeftAndRightItemAtt = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor whiteColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];
    
    [navigationBarAppearance setBarTintColor:[UIColor redColor]];
    
    
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
//        [navigationBarAppearance setTranslucent:NO];
}
- (void)showShareActionWithTitle: (NSString *)title ct: (NSString *)ct url:(NSString *) url imageUrl: (id)imageUrl  controller: (UIViewController *)controller
{
    NSLog(@"分享");
}



/**
 *  启动页广告
 */
- (void)setUpAdVC
{
    /**
     *  1.显示启动页广告
     */
    [XHLaunchAd showWithAdFrame:CGRectMake(0, 0,self.window.frame.size.width, self.window.frame.size.height-150) setAdImage:^(XHLaunchAd *launchAd) {
        
        //未检测到广告数据,启动页停留时间,不设置默认为3,(设置4即表示:启动页显示了4s,还未检测到广告数据,就自动进入window根控制器)
        //launchAd.noDataDuration = 4;
        
        //获取广告数据
        [self requestImageData:^(NSString *imgUrl, NSInteger duration, NSString *openUrl) {
            
            /**
             *  2.设置广告数据
             */
            
            //定义一个weakLaunchAd
            __weak __typeof(launchAd) weakLaunchAd = launchAd;
            [launchAd setImageUrl:imgUrl duration:duration skipType:SkipTypeTimeText options:XHWebImageDefault completed:^(UIImage *image, NSURL *url) {
                
                //异步加载图片完成回调(若需根据图片尺寸,刷新广告frame,可在这里操作)
                //weakLaunchAd.adFrame = ...;
                
            } click:^{
                
                //广告点击事件
                
                //1.用浏览器打开
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
                
                //2.在webview中打开
                //                WebViewController *VC = [[WebViewController alloc] init];
                //                VC.URLString = openUrl;
                //                [weakLaunchAd presentViewController:VC animated:YES completion:nil];
                
            }];
            
        }];
        
    } showFinish:^{
        //广告展示完成回调,设置window根控制器
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[MyTabBarViewController new]];
        self.window.rootViewController = nav;
        
    }];
}
/**
 *  向服务器请求广告数据
 *
 *  @param imageData 回调imageUrl,及停留时间,跳转链接
 */
- (void)requestImageData:(void(^)(NSString *imgUrl,NSInteger duration,NSString *openUrl))imageData
{
    imageData(@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488540826689&di=1f3b7928f2b96b184f220920fe31f326&imgtype=0&src=http%3A%2F%2Fimg18.house365.com%2Fnewcms%2F2015%2F10%2F15%2F1444891916561f4d0c4ba07.jpg",3,@"http://www.ijiangyin.com");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
