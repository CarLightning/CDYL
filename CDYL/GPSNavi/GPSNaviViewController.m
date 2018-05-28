//
//  GPSNaviViewController.m
//  AMapNaviKit
//
//  Created by liubo on 7/29/16.
//  Copyright © 2016 AutoNavi. All rights reserved.
//

#import "GPSNaviViewController.h"

#import "SpeechSynthesizer.h"
//#import "MoreMenuView.h"

@interface GPSNaviViewController ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate>

@property (nonatomic, strong) AMapNaviDriveView *driveView;

//@property (nonatomic, strong) MoreMenuView *moreMenu;

@end

@implementation GPSNaviViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [self initProperties];
    
    [self initDriveView];
    
    [self initDriveManager];
    
//    [self initMoreMenu];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self calculateRoute];
}

- (void)viewWillLayoutSubviews
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
      interfaceOrientation = self.interfaceOrientation;
    }
    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        [self.driveView setIsLandscape:NO];
    }
    else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        [self.driveView setIsLandscape:YES];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
    
    [self.driveView removeFromSuperview];
    self.driveView.delegate = nil;
     [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark - Initalization

- (void)initProperties
{
    //为了方便展示,选择了固定的起终点
    self.startPoint = [AMapNaviPoint locationWithLatitude:39.993135 longitude:116.474175];
    self.endPoint   = [AMapNaviPoint locationWithLatitude:39.908791 longitude:116.321257];
}

- (void)initDriveManager
{
    //请在 dealloc 函数中执行 [AMapNaviDriveManager destroyInstance] 来销毁单例
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];
    
    [[AMapNaviDriveManager sharedInstance] setAllowsBackgroundLocationUpdates:YES];
    [[AMapNaviDriveManager sharedInstance] setPausesLocationUpdatesAutomatically:NO];
    
    //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
    [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
}

- (void)initDriveView
{
    if (self.driveView == nil)
    {
        CGRect rect = CGRectZero;
//        if (is_iphoneX) {
//            rect = CGRectMake(0, 44,DEAppWidth, DEAppHeight-44);
//        }else{
            rect = self.view.bounds;
//        }
        
        
        
        
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:rect];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        
        [self.view addSubview:self.driveView];
    }
}

//- (void)initMoreMenu
//{
//    if (self.moreMenu == nil)
//    {
//        self.moreMenu = [[MoreMenuView alloc] init];
//        self.moreMenu.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//
//        [self.moreMenu setDelegate:self];
//    }
//}

#pragma mark - Route Plan

- (void)calculateRoute
{
    //进行路径规划
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:nil
                                          drivingStrategy:AMapNaviDrivingStrategySingleDefault];
}

#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error
{
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    //算路成功后开始GPS导航
    [[AMapNaviDriveManager sharedInstance] startGPSNavi];
    
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}

- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForYaw");
}

- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForTrafficJam");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex
{
    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
{
    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onArrivedDestination");
}

#pragma mark - AMapNaviWalkViewDelegate

- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView
{
    //停止导航
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    
    //停止语音
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)driveViewMoreButtonClicked:(AMapNaviDriveView *)driveView
{
    //配置MoreMenu状态
//    [self.moreMenu setTrackingMode:self.driveView.trackingMode];
//    [self.moreMenu setShowNightType:self.driveView.showStandardNightType];
//
//    [self.moreMenu setFrame:self.view.bounds];
//    [self.view addSubview:self.moreMenu];
}

- (void)driveViewTrunIndicatorViewTapped:(AMapNaviDriveView *)driveView
{
    NSLog(@"TrunIndicatorViewTapped");
}

- (void)driveView:(AMapNaviDriveView *)driveView didChangeShowMode:(AMapNaviDriveViewShowMode)showMode
{
    NSLog(@"didChangeShowMode:%ld", (long)showMode);
}

#pragma mark - MoreMenu Delegate

- (void)moreMenuViewFinishButtonClicked
{
//    [self.moreMenu removeFromSuperview];
}

- (void)moreMenuViewNightTypeChangeTo:(BOOL)isShowNightType
{
    [self.driveView setShowStandardNightType:isShowNightType];
}

- (void)moreMenuViewTrackingModeChangeTo:(AMapNaviViewTrackingMode)trackingMode
{
    [self.driveView setTrackingMode:trackingMode];
}

@end

