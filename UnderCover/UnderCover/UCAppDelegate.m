//
//  UCAppDelegate.m
//  UnderCover
//
//  Created by Wayde Sun on 7/16/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCAppDelegate.h"
#import "UCFirstViewController.h"
#import "iHMoreViewController.h"
#import "iHEngine.h"
#import "CustomerNavigationController.h"
#import "MobClick.h"

@implementation UCAppDelegate

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    iHDINFO(@"online config has fininshed and note = %@", note.userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    iHDINFO(@"---===---- %@", userInfo);
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken
{
	NSString *str = [devToken description];
	str = [str substringWithRange:NSMakeRange(1, 71)];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    iHDINFO(@"====== Token: %@", str);
	[[NSUserDefaults standardUserDefaults] setObject:str forKey:IH_DEVICE_TOKEN];
	[[NSUserDefaults standardUserDefaults] synchronize];
    if (self.user) {
        [self.user doUploadToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register push
    if([[NSUserDefaults standardUserDefaults] stringForKey:IH_DEVICE_TOKEN] == nil)	{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound)];
        
    }
    
    // umeng
    [self umengTrack];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    // Engine Start
    if (![iHEngine start]) {
        return NO;
    }
    
    self.cdataManager = [[iHCDataManager alloc] init];
    self.user = [[JUser alloc] init];
    self.customerMessageStatusBar = [[iHStatusBarWindow alloc] initWithColor:iHStatusBarColorBlack];
    UIViewController *viewController1;
    UIViewController *viewController2;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    viewController1 = [[UCFirstViewController alloc] initWithNibName:@"UCFirstViewController" bundle:nil];
        viewController2 = [[iHMoreViewController alloc] initWithNibName:@"iHMoreViewController_iphone" bundle:nil];
        
    } else {
    viewController1 = [[UCFirstViewController alloc] initWithNibName:@"UCFirstViewController_ipad" bundle:nil];
        viewController2 = [[iHMoreViewController alloc] initWithNibName:@"iHMoreViewController_ipad" bundle:nil];
    }
//    UIViewController *viewController1 = [[UCFirstViewController alloc] initWithNibName:@"UCFirstViewController" bundle:nil];
//    UIViewController *viewController2 = [[iHMoreViewController alloc] initWithNibName:@"iHMoreViewController" bundle:nil];
    
    UINavigationController *nav1 = [CustomerNavigationController createSystemNavigationController:viewController1];
    UINavigationController *nav2 = [CustomerNavigationController createSystemNavigationController:viewController2];
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController.tabBar setBackgroundImage:ImageNamed(@"Tabbar_Background.png")];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont systemFontOfSize:13], UITextAttributeFont,
                                                       RGBCOLOR(89, 89, 89), UITextAttributeTextColor,
                                                       [UIColor whiteColor], UITextAttributeTextShadowColor,
                                                       [NSValue valueWithUIOffset:UIOffsetMake(1.0f, 0.5f)], UITextAttributeTextShadowOffset,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBar appearance] setSelectionIndicatorImage:ImageNamed(@"transparentBG.png")];
    
    self.tabBarController.viewControllers = @[nav1, nav2];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Class Methods
+ (UCAppDelegate *)getSharedAppDelegate {
    return (UCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
