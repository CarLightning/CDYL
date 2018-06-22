//
//  CDPoleViewController.m
//  CDYL
//
//  Created by admin on 2018/5/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDPoleViewController.h"
#import "CDPoliList.h"
#import "CDPoleCell.h"
#import "CDPoleSettingCth.h"

@interface CDPoleViewController ()<UITableViewDelegate,UITableViewDataSource,PoleDelegate>
@property (nonatomic, strong) NSArray *poleSource;
//@property (nonatomic, strong) CDPoliList *poliModel;
@property (nonatomic, strong) UITableView *tabaleV;

@end

@implementation CDPoleViewController

static NSString *const identifyCell = @"POLECELL";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubs];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSourceFromWeb];
}

#pragma mark -  tableViewDelagate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.poleSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDPoleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyCell forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.poleSource[indexPath.row];
    cell.delegate = self ;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

#pragma mark -  ShowCellDelegate


#pragma mark -  Method
-(void)getSourceFromWeb{
    NSString *stationId = self.stationModel.pid;
    __block typeof(self) weakself = self;
    [CDWebRequest requestGetgetPoleByStationId:stationId AndBack:^(NSDictionary *backDic) {
        NSString *is_ok = [NSString stringWithFormat:@"%@",backDic[@"success"]];
        
        if ([is_ok isEqualToString:@"1"]) {
            
       weakself.poleSource = [CDPoliList arrayOfModelsFromDictionaries:backDic[@"list"] error:nil];
            [weakself.tabaleV reloadData];
            if (weakself.poleSource.count == 0) {
                [weakself showEmptyViewWith:@"没有找到充电桩"];
            }
        }
    } failure:^(NSString *err) {
        [weakself showEmptyViewWith:err];
    }];
    

   
}
- (void)initSubs {
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor = [UIColor clearColor];
    [tv registerClass:[CDPoleCell class] forCellReuseIdentifier:identifyCell];
    [self.view addSubview:tv];
    self.tabaleV =tv;
}
#pragma mark - PoleDelegate
- (void)clickTheBespeakBtn:(CDPoliList *)model{
    CDPoleSettingCth *pole = [[CDPoleSettingCth alloc]init];
    pole.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pole animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    NSLog(@"点击预约");
}
@end
