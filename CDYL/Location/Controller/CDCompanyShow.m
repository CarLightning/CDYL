//
//  CDCompanyShow.m
//  CDYL
//
//  Created by admin on 2018/5/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDCompanyShow.h"
#import "LSXView.h"
#import "CDPoleViewController.h"


@interface CDCompanyShow ()<showViewDelegate>

@end

@implementation CDCompanyShow

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initializationSub];
    
   
}


- (void)initializationSub {
    
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    [self.view addSubview:scrollview];
    scrollview.backgroundColor=[UIColor whiteColor];
    scrollview.contentSize=CGSizeMake(DEAppWidth, 600);
    
    LSXView *iv=[[[NSBundle mainBundle]loadNibNamed:@"LSXView" owner:self options:nil]lastObject];
    iv.frame=CGRectMake(0, 0, DEAppWidth, DEAppHeight);
    iv.delegate = self;
    iv.model = self.model;
    [scrollview addSubview:iv];
}
#pragma mark - showViewDelegate
// 点击更多按钮
- (void)clickTheMoreBtnWithStationModel:(CDStation *)model
{
    CDPoleViewController *poleView = [[CDPoleViewController alloc]init];
    poleView.stationModel = self.model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:poleView animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}


@end
