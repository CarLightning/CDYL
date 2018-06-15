//
//  CDConsumeCth.m
//  CDYL
//
//  Created by admin on 2018/6/11.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDConsumeCth.h"
#import "CDBarView.h"

@interface CDConsumeCth ()<CDBarViewDelagate>
@property (nonatomic, strong) CDBarView *barView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *upView;
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, strong) UILabel *startLb;
@property (nonatomic, strong) UILabel *endLb;
@property (nonatomic, strong) UILabel *accountLb;
@property (nonatomic, strong) UILabel *locationLb;
@property (nonatomic, strong) NSArray *array;
@end

@implementation CDConsumeCth

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.array = @[@"开始时间:",@"结束时间:",@"消费账户:",@"消费地点:"];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.barView];
    [self.scrollView addSubview:self.upView];
    [self.scrollView addSubview:self.detailView];
    [self showUpViews];
    [self showDetailViews];
}
- (void)showUpViews{
    NSString * paystatus =[NSString stringWithFormat:@"%@",[self.sourceDic objectForKey:@"payWay"]];
   
    NSString *moneyStr =[NSString stringWithFormat:@"%@元",[self.sourceDic objectForKey:@"amount"]];
// 支付状态图片
    UIImageView * ig = [[UIImageView alloc]initWithFrame:CGRectMake(0, 25, 60, 60)];
   
    ig.center = CGPointMake(self.upView.center.x, ig.center.y);
    [self.upView addSubview:ig];
    
// 本次消费金额
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0,25+60+15, 200, 30)];
    lb.center = CGPointMake(self.upView.center.x, lb.center.y);
    lb.textColor = LHColor(34, 34, 34);

    lb.font = [UIFont systemFontOfSize:30];
    lb.text = moneyStr;
    lb.textAlignment = NSTextAlignmentCenter;
    [self.upView addSubview:lb];
//    支付btn
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 25+60+15+30+20, 200, 44)];
    btn.center = CGPointMake(self.upView.center.x, btn.center.y);
    btn.userInteractionEnabled = NO;
    [btn setTitle:@"已支付"forState:UIControlStateNormal];
    [btn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickPayBtn) forControlEvents:UIControlEventTouchUpInside];
  [ btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.backgroundColor = LHColor(255, 198, 0);
    [self.upView addSubview:btn];
    btn.layer.cornerRadius = 22;
    btn.layer.masksToBounds = YES;
    if ([paystatus isEqualToString:@"1"]) {
        ig.image = [UIImage imageNamed:@"payok"];
    }else{
        ig.image = [UIImage imageNamed:@"paywait"];
        [btn setTitle:@"支付" forState:UIControlStateNormal];
        btn.userInteractionEnabled = YES;
    }
}
- (void)showDetailViews{
   NSString *endTime =[NSString stringWithFormat:@"%@",[self.sourceDic objectForKey:@"chEndDate"]];
    NSString *startTime =[NSString stringWithFormat:@"%@",[self.sourceDic objectForKey:@"chStartDate"]];
    NSString *account =[NSString stringWithFormat:@"%@",[self.sourceDic objectForKey:@"cardNo"]];
     NSString *location =[NSString stringWithFormat:@"%@",[self.sourceDic objectForKey:@"poleId"]];
    for (int i = 0; i<4; i++) {
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, i*25+5, 65, 25)];
        lb.text =self.array[i];
        lb.textColor = LHColor(157, 157, 157);
        lb.font = [UIFont systemFontOfSize:12];
        lb.textAlignment = NSTextAlignmentLeft;
        [self.detailView addSubview:lb];
    }
//    开始时间
    self.startLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, DEAppWidth-75, 25)];
    self.startLb.textAlignment = NSTextAlignmentLeft;
    self.startLb.textColor = LHColor(34, 34, 34);
    self.startLb.text = [self getTime:startTime];
    self.startLb.font = [UIFont systemFontOfSize:12];
   
    [self.detailView addSubview:self.startLb];
//   结束时间
    self.endLb= [[UILabel alloc]initWithFrame:CGRectMake(80, 30, DEAppWidth-75, 25)];
    self.endLb.textAlignment = NSTextAlignmentLeft;
    self.endLb.textColor = LHColor(34, 34, 34);
    self.endLb.text = [self getTime:endTime];
    self.endLb.font = [UIFont systemFontOfSize:12];
    [self.detailView addSubview:self.endLb];
//    消费账户
    self.accountLb= [[UILabel alloc]initWithFrame:CGRectMake(80, 2*25+5, DEAppWidth-75, 25)];
    self.accountLb.textAlignment = NSTextAlignmentLeft;
    self.accountLb.textColor = LHColor(34, 34, 34);
    self.accountLb.text = account;
    self.accountLb.font = [UIFont systemFontOfSize:12];
    [self.detailView addSubview: self.accountLb];
//    消费地点
    self.locationLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 3*25+5, DEAppWidth-75, 25)];
    self.locationLb.textAlignment = NSTextAlignmentLeft;
    self.locationLb.textColor = LHColor(34, 34, 34);
    self.locationLb.text = [self locationStr:location];
    self.locationLb.font = [UIFont systemFontOfSize:12];
    [self.detailView addSubview: self.locationLb];
    
    
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
-(UIView *)upView{
    if (_upView == nil) {
       
        _upView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, DEAppWidth, 219)];
        _upView.backgroundColor = [UIColor whiteColor];
        _upView.userInteractionEnabled = YES;
    }
    return  _upView;
}
-(UIView *)detailView{
    if (_detailView == nil) {
        
        _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upView.frame)+20, DEAppWidth, 110)];
        _detailView.backgroundColor = [UIColor whiteColor];
    }
    return  _detailView;
}
#pragma mark - CDBarViewDelagate
-(void)popUpViewController{
    
    NSArray *subs = self.navigationController.childViewControllers;
    [self.navigationController popToViewController:[subs objectAtIndex:subs.count-2] animated:YES];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - 自定义
-(void)didClickPayBtn{
    
}
- (NSString *)getTime:(NSString *)str{
    NSTimeInterval newTime = str.longLongValue/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:newTime];
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [forma stringFromDate:date];
    
    return string;
}
-(NSString *)locationStr:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@":"];
    NSString *loca = arr.lastObject;
    
    return loca;
}
@end
