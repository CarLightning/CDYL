//
//  CDDetailViewController.m
//  CDYL
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 admin. All rights reserved.
//  明细界面

#import "CDDetailViewController.h"
#import "CDBarView.h"
#import "CDchargeCell.h"
#import "CDBgVIew.h"
#import "CDConsumeCth.h"

@interface CDDetailViewController ()<CDBarViewDelagate,CDBgVIewDelagate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *sourceArr;
@property (nonatomic, strong) UITableView *tView;
@property (nonatomic, strong) CDBgVIew *bgView;
@property (nonatomic, strong) CDBarView *barView;

@end

@implementation CDDetailViewController

static NSString *const identy = @"DETAILCELL";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//默认充值明细
    self.cthType = 1;
    
    [self setSubViews];
    
    [self getRechargeRecord];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
-(NSMutableArray *)sourceArr{
    if (_sourceArr == nil ) {
        _sourceArr = [NSMutableArray array];
    }
    return _sourceArr;
}
-(void)setSubViews
{
   
   
    [self.view addSubview:self.barView];
    
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.barView.frame), DEAppWidth, DEAppHeight-CGRectGetMaxY(self.barView.frame))style:UITableViewStyleGrouped];
    tv.delegate=self;
    tv.dataSource=self;
    [tv registerClass:[CDchargeCell class] forCellReuseIdentifier:identy];
    [self.view addSubview:tv];
    self.tView = tv;
}
-(CDBarView *)barView{
    if (_barView == nil) {
        CGFloat Height = 64;
        if (is_iphoneX) {
            Height = 88;
        }
        _barView = [[CDBarView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, Height)];
       _barView.delegate = self;
       _barView.is_showFun = YES;
    }
    return _barView;
}
-(CDBgVIew *)bgView{
    if (_bgView == nil) {
        _bgView = [[CDBgVIew alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
        _bgView.delagate = self;
    }
    return _bgView;
}
#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CDchargeCell *cell = [tableView dequeueReusableCellWithIdentifier:identy forIndexPath:indexPath];
    NSDictionary *objectDic = self.sourceArr[indexPath.row];
     cell.type = self.cthType;
    if (self.cthType == 1) {
       
        cell.status =[NSString stringWithFormat:@"%@",[objectDic objectForKey:@"rechSty"]];
        cell.time =[NSString stringWithFormat:@"%@",[objectDic objectForKey:@"rechDate"]];
        cell.money =[NSString stringWithFormat:@"%@",[objectDic objectForKey:@"rechAmount"]];
    }else{
        cell.status =[NSString stringWithFormat:@"%@",[objectDic objectForKey:@"payWay"]];
        cell.time =[NSString stringWithFormat:@"%@",[objectDic objectForKey:@"chStartDate"]];
        cell.money =[NSString stringWithFormat:@"%@",[objectDic objectForKey:@"amount"]];
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *Header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, 0)];
    Header.backgroundColor = [UIColor clearColor];
    return Header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.cthType == 1) {
        return;
    }
    NSDictionary *objectDic = self.sourceArr[indexPath.row];
    CDConsumeCth * base = [[NSClassFromString(@"CDConsumeCth") alloc] init];
    base.sourceDic = objectDic;
    [self.navigationController pushViewController:base animated:YES];
    
}

#pragma mark - CDBarViewDelagate
-(void)popUpViewController{
    
    NSArray *subs = self.navigationController.childViewControllers;
    
    [self.navigationController popToViewController:[subs objectAtIndex:subs.count-2] animated:YES];
    self.navigationController.navigationBarHidden = NO;
}

-(void)didClickSelectButton{
    [self.view addSubview:self.bgView];
    [self.bgView showTheAlert];
}

#pragma mark -CDBgViewDelagate
- (void)clickTheConsumeRecordBtn{
    [self hiddenAllBaseView];
    [self.bgView hiddenTheAlert];
    self.barView.bgImage = [UIImage imageNamed:@"selectConsume"];
    NSLog(@"点击消费");
    [self.sourceArr removeAllObjects];
    [self getConsumeRecord];
}
- (void)clickTheRechargeRecordBtn{
    [self hiddenAllBaseView];
    [self.bgView hiddenTheAlert];
    self.barView.bgImage = [UIImage imageNamed:@"selectAdd"];
    NSLog(@"点击充值");
    [self.sourceArr removeAllObjects];
    [self getRechargeRecord];
}
#pragma mark - 获取数据
//消费记录
- (void)getConsumeRecord{
    self.cthType = 2;
    NSString *cardId = self.model.cardno;
    NSString *cardNo = [CDUserInfor shareUserInfor].phoneNum;
    NSString *pass = [CDUserInfor shareUserInfor].userPword;
    __block __typeof(self) weakSelf = self;
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [CDWebRequest requestgetConsumRecordWithidentity:@"1" cardNo:cardNo Pass:pass cardId:cardId pageSize:@"30" index:@"1" AndBack:^(NSDictionary *backDic) {
        
         NSArray *arr = backDic[@"list"];
             arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            NSString *s1=[NSString stringWithFormat:@"%@",obj1[@"chStartDate"]];
            NSString *s2=[NSString stringWithFormat:@"%@",obj2[@"chStartDate"]];
            if (s1.doubleValue>=s2.doubleValue) {
                return NSOrderedAscending ;
            }else{
                return  NSOrderedDescending;
                
            }
            return NSOrderedSame;
        }];
        weakSelf.sourceArr = [arr mutableCopy];
        [hud hideAnimated:YES];
         [weakSelf.tView reloadData];
        if (weakSelf.sourceArr.count == 0) {
            [self showEmptyViewWith:@"当前没有消费记录"];
        }
       
       
    } failure:^(NSString *err) {
        
        [hud hideAnimated:YES];
        [weakSelf.tView reloadData];
         [self showEmptyViewWith:err];
    }];
}
//充值记录
- (void)getRechargeRecord{
    self.cthType = 1;
    NSString *cardId = self.model.cardno;
    NSString *cardNo = [CDUserInfor shareUserInfor].phoneNum;
    NSString *pass = [CDUserInfor shareUserInfor].userPword;
    __block __typeof(self) weakSelf = self;
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [CDWebRequest requestgetRechRecordWithidentity:@"1" cardNo:cardNo Pass:pass cardId:cardId pageSize:@"30" index:@"1" AndBack:^(NSDictionary *backDic) {
        NSArray *arr = backDic[@"list"];
        arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            NSString *s1=[NSString stringWithFormat:@"%@",obj1[@"rechDate"]];
            NSString *s2=[NSString stringWithFormat:@"%@",obj2[@"rechDate"]];
            if (s1.doubleValue>=s2.doubleValue) {
                return NSOrderedAscending ;
            }else{
                return  NSOrderedDescending;
                
            }
            return NSOrderedSame;
        }];
        
        weakSelf.sourceArr = [arr mutableCopy];
        [hud hideAnimated:YES];
         [weakSelf.tView reloadData];
        if (weakSelf.sourceArr.count == 0) {
            [self showEmptyViewWith:@"当前没有充值记录"];
        }
    } failure:^(NSString *err) {
        
        [hud hideAnimated:YES];
        [weakSelf.tView reloadData];
        [self showEmptyViewWith:err];
    }];
}

@end
