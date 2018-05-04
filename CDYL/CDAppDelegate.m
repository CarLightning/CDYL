//
//  CDAppDelegate.m
//  CDYL
//
//  Created by admin on 2018/4/18.
//  Copyright © 2018年 admin. All rights reserved.
//
#import "CDViewController.h"
#import "CDAppDelegate.h"
#import "CDNav.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CDTabbarCtl.h"
#import <AFNetworking.h>

@interface CDAppDelegate()
@property (nonatomic, copy) AFNetworkReachabilityManager  * networkMonitorManager;
@end
@implementation CDAppDelegate

- (AFNetworkReachabilityManager *)networkMonitorManager {
    
    if (!_networkMonitorManager) {
        _networkMonitorManager = [AFNetworkReachabilityManager sharedManager];
        [_networkMonitorManager startMonitoring];  //开始监听
    }
    return _networkMonitorManager;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setAliMap];
    [self startNetMonitor];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    CDTabbarCtl *tabbarCtl = [[CDTabbarCtl alloc]init];
    self.window.rootViewController=tabbarCtl;
   
    
//    CDViewController *vc = [[CDViewController alloc]init];
//    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)setAliMap{
    
    [AMapServices sharedServices].apiKey = @"34d1eb538c5c29ebceb7f7e7c9f8d4dc";
}
- (void)startNetMonitor{
    // 开启网络监听
    [self.networkMonitorManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {// 没有网络
            whetherHaveNetwork = NO;
            NSLog(@"没有网络:ifHaveNetwork = %d", whetherHaveNetwork);
        }else{// 有网络
            whetherHaveNetwork = YES;
            NSLog(@"有网络:ifHaveNetwork = %d", whetherHaveNetwork);
        }
    }];
    
    
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
