//
//  CDConsumeCth.m
//  CDYL
//
//  Created by admin on 2018/6/11.
//  Copyright © 2018年 admin. All rights reserved.
//  明细-消费账单界面

#import "CDConsumeCth.h"
#import "CDBarView.h"
#import "CDOrderView.h"

@interface CDConsumeCth ()<CDBarViewDelagate>
@property (nonatomic, strong) CDBarView *barView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CDOrderView *orderView;
@property (nonatomic, strong) UIButton *orderBtn;
;
@end

@implementation CDConsumeCth

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
   
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.barView];
    
    self.orderView = [[NSBundle mainBundle]loadNibNamed:@"CDOrderView" owner:self options:nil].lastObject;
    self.orderView.frame = CGRectMake(0, 0, DEAppWidth, 390);
    self.orderView.sourceDic = self.sourceDic;
    [self.scrollView addSubview:self.orderView];
    
    [self.scrollView addSubview:self.orderBtn];
    
    
    NSString *deductState = [NSString stringWithFormat:@"%@",self.sourceDic[@"deductState"]];
   
    if ([deductState isEqualToString:@"2"]) {
        self.orderBtn.hidden = NO;
    }
}
-(UIButton *)orderBtn{
    if (_orderBtn == nil) {
        _orderBtn=[[UIButton alloc]init];
        _orderBtn.frame = CGRectMake(60, 400+18, DEAppWidth-56*2, (DEAppWidth-120)*0.146);
        _orderBtn.hidden = YES;
        _orderBtn.backgroundColor = LHColor(255, 198, 80);
        [_orderBtn addTarget:self action:@selector(clickTheOrderBtn) forControlEvents:UIControlEventTouchUpInside];
        [_orderBtn setTitle:@"确认付款" forState:UIControlStateNormal];
        [_orderBtn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
        [_orderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _orderBtn.layer.cornerRadius = (DEAppWidth-120)*0.146/2;;
        _orderBtn.layer.masksToBounds = YES;
    }
    return _orderBtn;
}

-(CDBarView *)barView{
    if (_barView == nil) {
        CGFloat Height = 64;
        if (is_iphoneX) {
            Height = 88;
        }
        _barView = [[CDBarView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, Height)];
        _barView.delegate = self;
        _barView.title = @"详情";
    }
    return _barView;
}
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        CGFloat Height = 64;
        if (is_iphoneX) {
            Height = 88;
        }
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height, DEAppWidth, DEAppHeight)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _scrollView .bounces=YES;
        _scrollView.alwaysBounceVertical=YES;
    }
    return _scrollView;
}

#pragma mark - CDBarViewDelagate
-(void)popUpViewController{
    
    NSArray *subs = self.navigationController.childViewControllers;
    [self.navigationController popToViewController:[subs objectAtIndex:subs.count-2] animated:YES];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - 自定义
-(void)clickTheOrderBtn{
    
}

@end
