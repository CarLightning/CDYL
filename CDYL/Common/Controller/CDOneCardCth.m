//
//  CDOneCardCth.m
//  CDYL
//
//  Created by admin on 2018/5/28.
//  Copyright © 2018年 admin. All rights reserved.
//  单张卡界面

#import "CDOneCardCth.h"
#import "CDMoneyCard.h"
#import "CDcell.h"
#import "CDDetailViewController.h"
#import "CDRechangeCth.h"

@interface CDOneCardCth ()<CDcellDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CDOneCardCth

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setItem];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator= NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.scrollView .bounces=YES;
    self.scrollView.alwaysBounceVertical=YES;
    [self.view addSubview:self.scrollView];
    
//  我的卡
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, DEAppWidth, 68)];
    lb.text=@"我的卡";
    lb.font=[UIFont systemFontOfSize:30];
    lb.textAlignment=NSTextAlignmentLeft;
    lb.textColor=LHColor(34, 34, 34);
    [self.scrollView addSubview:lb];
    
//钱包
    CDMoneyCard *card = [[CDMoneyCard alloc]initWithFrame:CGRectMake(0, 68, DEAppWidth, 150)];
    card.model = self.model;
    [self.scrollView addSubview:card];
    
// 充值
//    CDcell *cell = [[CDcell alloc]initWithFrame:CGRectMake(0, 68+150+30, DEAppWidth, 50)];
//    cell.delegate = self;
//    [self.scrollView addSubview:cell];
    
}
- (void)setItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(clickThtDetail)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    
}
// 点击明细
- (void)clickThtDetail {
    CDDetailViewController *detail = [[CDDetailViewController alloc]init];
    detail.model = self.model;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - CDcellDelagate
-(void)jumpToAddmoney{
    CDRechangeCth * recharge = [[CDRechangeCth alloc]init];
    recharge.model = self.model;
    [self.navigationController pushViewController:recharge animated:YES];
}


@end
