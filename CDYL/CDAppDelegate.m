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
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>

@interface CDAppDelegate()<WXApiDelegate,JPUSHRegisterDelegate>
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
    [self setWXpay];
    [self setJpushWithOptions:launchOptions];
    [self startNetMonitor];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.tabbarCtl = [[CDTabbarCtl alloc]init];
    self.window.rootViewController=self.tabbarCtl;
    
    
    //    CDViewController *vc = [[CDViewController alloc]init];
    //    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
-(void)setWXpay{
    //向微信注册wx9ceed7678d79c5d4
    [WXApi registerApp:@"wx9ceed7678d79c5d4" enableMTA:YES];
    
}
-(void)setAliMap{
    //  高德地图注册
    [AMapServices sharedServices].apiKey = @"71994ea27b0442210d847cc5c98c7204";
}
- (void)setJpushWithOptions:(NSDictionary *)launchOptions{
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    NSString *appKey = @"cf2cb99878bc5c73f93c936a";
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:@"App Store" apsForProduction:YES];
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

//前面的两个方法被iOS9弃用了，如果是Xcode7.2网上的话会出现无法进入进入微信的onResp回调方法，就是这个原因。本来我是不想写着两个旧方法的，但是一看官方的demo上写的这两个，我就也写了。。。。
//9.0前的方法，为了适配低版本 保留
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}
//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    //跳转支付宝钱包进行支付，处理支付结果
    if ([url.host isEqualToString:@"safepay"]) {
        
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付宝处理结果：%@",resultDic);
        }];
    }else if ([url.host isEqualToString:@"platformapi"]){
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result：%@",resultDic[@"success"]);
        }];
    }
    return  [WXApi handleOpenURL:url delegate:self];
}


//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
- (void)onResp:(BaseResp *)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSDictionary *dicOfResult = @{
                                  @"weixin_pay_result":resp
                                  };
    //将支付结果发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTI_WEI_XIN_PAY_RESULT" object:dicOfResult];
    
    if([resp isKindOfClass:[PayResp class]]){
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功!";
                NSLog(@"%@", payResoult);
                break;
            case -1:
                payResoult = @"支付结果：失败!";
                NSLog(@"%@", payResoult);
                break;
            case -2:
                payResoult = @"用户已经退出支付!";
                NSLog(@"%@", payResoult);
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"%@", payResoult);
                break;
        }
    }
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
