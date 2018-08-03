//
//  CDMineViewController.m
//  CDYL
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 admin. All rights reserved.
//  我的界面

#import "CDMineViewController.h"
#import "CDHeadView.h"
#import "CDCellView.h"
#import "CDNav.h"
#import "CDMessage.h"
#import "CDMessageCth.h"

@interface CDMineViewController ()<CDHeadViewDelagate,CDCellViewDelegate>
@property (nonatomic, strong) CDHeadView *headView;
@property (nonatomic, strong) CDCellView *notiView;

@end

@implementation CDMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubviews];
      self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNotifiedImageState:) name:@"CHANGENOTIFITY" object:nil];
}
- (void)initSubviews{
    CGFloat black = 115+64;
    if (is_iphoneX) {
        black = 115+88;
    }
    self.headView = [[CDHeadView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, black)];
    self.headView.delegate = self;
    [self.view addSubview:self.headView];
    
    CDCellView *moneyView = [[CDCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), DEAppWidth, 63) showUpLb:YES showLineLb:NO cellName:@"钱包"];
    moneyView.delegate = self;
    [self.view addSubview:moneyView];
    
    CDCellView *collectView = [[CDCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyView.frame), DEAppWidth, 63) showUpLb:YES showLineLb:YES cellName:@"收藏"];
     collectView.delegate = self;
    [self.view addSubview:collectView];
    
    CDCellView *nitifiView = [[CDCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(collectView.frame), DEAppWidth, 48) showUpLb:NO showLineLb:YES cellName:@"消息"];
    nitifiView.delegate = self;
    [self.view addSubview:nitifiView];
    self.notiView = nitifiView;
    
    CDCellView *setView = [[CDCellView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nitifiView.frame), DEAppWidth, 48) showUpLb:NO showLineLb:NO cellName:@"设置"];
    setView.delegate = self;
    [self.view addSubview:setView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (self.headView) {
        [self.headView reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)changeNotifiedImageState:(NSNotification *)noti{
    if (self.notiView) {
        [self.notiView reloadNotifiImage:@"chatNotifi"];
        NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
        [df setBool:YES forKey:@"HaveNewMsg"];
        [df synchronize];
    }
}
#pragma mark - CDHeadViewDelagate
- (void)didClickTheEditBtn {
    if (![CDXML isLogin]) return;
    CDBaseViewController *basecth  = [[NSClassFromString(@"CDHeaderController") alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:basecth animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark - CDCellViewDelegate
-(void)userTapTheCellIndex:(NSUInteger)index{
    CDBaseViewController *basecth;
    if (index == 0) {
        basecth = [[NSClassFromString(@"CDMoneyCardController") alloc]init];
        
    }else if (index == 1){
       
        basecth = [[NSClassFromString(@"CDLocationViewController") alloc]init];
        basecth.cthType = 1;
        
    }else if (index == 2){
        
        NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
        [df setBool:NO forKey:@"HaveNewMsg"];
        [df synchronize];
        basecth = [[NSClassFromString(@"CDMessageCth") alloc]init];
      
        
    }else{
//        登录界面
//       basecth = [[NSClassFromString(@"CDViewController") alloc]init];
//         CDNav *navi = [[CDNav alloc]initWithRootViewController:basecth];
//        navi.navigationBar.hidden = YES;
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navi animated:YES completion:nil];
//        return ;
        
        basecth = [[NSClassFromString(@"CDSetting") alloc]init];
        
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:basecth animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
    
}





@end
