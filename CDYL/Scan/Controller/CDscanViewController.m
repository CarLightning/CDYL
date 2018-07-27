//
//  CDscanViewController.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CDscanViewController.h"
#import "LBXAlertAction.h"
#import "LSXPointViewController.h"
#import "CDNav.h"
#import "CDAppDelegate.h"

@interface CDscanViewController ()

@end

@implementation CDscanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor blackColor];
    
    //设置扫码后需要扫码图像
    self.isNeedScanImage = YES;
    
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}







- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [self drawUpItems];
    [self drawBottomItems];
   
    [self drawTitle];
    [self.view bringSubviewToFront:_topTitle];
    
    
}

//绘制扫描区域
- (void)drawTitle
{
    if (!_topTitle)
    {
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetMaxY(self.upItemsView.frame)+70);
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
       
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
    
}
- (void)drawUpItems{
    if (_upItemsView) {        
        return;
    }
    CGFloat height = 0;
    CGFloat block = 0;
    if (is_iphoneX) {
        height = 88;
        block = 44;
    }else{
        block = 20;
        height = 64;
    }
    self.upItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, height)];
    self.upItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:self.upItemsView];
    

    self.backItem = [[UIButton alloc]init];
     self.backItem.frame = CGRectMake(5, block+7, 30, 30);
    [ self.backItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [ self.backItem addTarget:self action:@selector(clicktheBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.upItemsView addSubview:self.backItem];
}
- (void)drawBottomItems
{
    if (_bottomItemsView) {
        
        return;
    }
    CGFloat block = 0;
    CGFloat hight = 0;
    if (is_iphoneX) {
        block = 134;
        hight = 134;
    }else{
        block = 100;
        hight = 100;
    }
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, DEAppHeight-hight, DEAppWidth, hight)];
    self.bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:self.bottomItemsView];
    
    CGSize size = CGSizeMake(65, 87);
    self.btnFlash = [[UIButton alloc]init];
    self.btnFlash .frame = CGRectMake((DEAppWidth - size.width)/2, 6, size.width, size.height);
    
    [self.btnFlash  setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [self.btnFlash  addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomItemsView addSubview:self.btnFlash];
    
}

- (void)showError:(NSString*)str
{
    //    [LBXAlertAction showAlertWithTitle:@"提示" msg:str buttonsStatement:@[@"知道了"] chooseBlock:nil];
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
   
    
    [self showNextVCWithScanResult:scanResult];
    
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
        
        [weakSelf reStartDevice];
    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    NSString *resultStr = strResult.strScanned;
    [self dismissViewControllerAnimated:YES completion:^{
        CDAppDelegate *app=(CDAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        
        LSXPointViewController *pointV = [[LSXPointViewController alloc]init];
        CDNav *selectNavi = app.tabbarCtl.selectedViewController;
        pointV.poldId = resultStr;
        UIViewController *victh = [self visibleViewController];
        victh.hidesBottomBarWhenPushed = YES;
        [selectNavi pushViewController:pointV animated:YES];
       victh.hidesBottomBarWhenPushed = NO;
        
        
        
    }];
    

}


#pragma mark -底部功能项


//开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
    
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}


-(void)clicktheBackBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [self getVisibleViewControllerFrom:rootViewController];
}

- (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}


@end
