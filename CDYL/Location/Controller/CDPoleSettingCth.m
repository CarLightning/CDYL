//
//  CDPoleSettingCth.m
//  CDYL
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDPoleSettingCth.h"
#import "CDBespeakTableViewCell.h"
#import "CDRowCell.h"
#import "HSDatePickerViewController.h"

@interface CDPoleSettingCth ()<UITableViewDelegate,UITableViewDataSource,rowCellDelagate,HSDatePickerViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSString  * poleTime;
@property (nonatomic, strong) NSDate *startDate;

@end

@implementation CDPoleSettingCth

static CGFloat SmallCellHeight = 55;
static CGFloat bigCellHeight = 75;
static CGFloat HeaderHeight = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor = [UIColor clearColor];
    [tv registerClass:[CDBespeakTableViewCell class] forCellReuseIdentifier:@"bespeakupcell"];
    [tv registerClass:[CDRowCell class] forCellReuseIdentifier:@"rowcell"];
    [self.view addSubview:tv];
    self.tableV = tv;
    
    CGFloat heightY =HeaderHeight +SmallCellHeight+bigCellHeight;
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(30, heightY+40, DEAppWidth-60, 40)];
    btn.backgroundColor=LHColor(255, 189, 0);
    [btn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.layer.cornerRadius=20;
    [self.tableV addSubview:btn];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSourceArr];
}
-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
#pragma mark -  tableViewDelagate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CDBespeakTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"bespeakupcell" forIndexPath:indexPath];
        cell.status = 200;
        [cell reloadCellWithRow:indexPath.row arr:self.array];
        return cell;
    }else  {
        CDRowCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"rowcell" forIndexPath:indexPath];
         cell.status  = 200;
        cell.delagate = self;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ) {
        return SmallCellHeight;
    }
    return bigCellHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, HeaderHeight)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeaderHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        HSDatePickerViewController *hsdpvc = [[HSDatePickerViewController alloc] init];
        hsdpvc.delegate = self;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:hsdpvc animated:YES completion:nil];
    }
}

#pragma mark - rowCellDalagate
-(void)changeTheSearchValue:(NSString *)index{
    self.poleTime = index;
}



#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date {
    self.startDate = date;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateStr = [format stringFromDate:date];
    [self.array replaceObjectAtIndex:0 withObject:dateStr];
    [self.tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:YES];
}

#pragma mark - 自定义 method
- (void)getSourceArr {
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSTimeInterval timeSt = [NSDate date].timeIntervalSince1970+1800;
    NSDate *showDate = [NSDate dateWithTimeIntervalSince1970:timeSt];
    self.startDate = showDate;
    self.poleTime = @"30";
    [self.array addObject:[format stringFromDate:showDate]];
    [self.tableV reloadData];
    
}
//开始预约
- (void)clickTheBtn{
    NSString * identify = @"1";
    NSString * uid = self.model.uid;
    NSString * type = @"2";
    NSString *cardNum = [CDUserInfor shareUserInfor].phoneNum;
    NSString *passNum = [CDUserInfor shareUserInfor].userPword;
    NSString *cardId = [CDUserInfor shareUserInfor].defaultCard;
    NSString *phoneNum = [CDUserInfor shareUserInfor].phoneNum;
    NSTimeInterval startTime = self.startDate.timeIntervalSince1970*1000;
    NSString *statrdate = [NSString stringWithFormat:@"%.0f",startTime];
    
    NSTimeInterval endTime = self.poleTime.floatValue *60*1000;
    NSString *endDate = [NSString stringWithFormat:@"%.0f",endTime];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText ;
    hud.offset = CGPointMake(0.f, 0);
    hud.detailsLabel.font = [UIFont systemFontOfSize:12];
    hud.detailsLabel.text = @"正在预约...";
    
    [CDWebRequest requestbespeakPoleWithidentity:identify UID:uid Type:type cardNo:cardNum Pass:passNum CardId:cardId phoneNum:phoneNum startTime:statrdate lastTime:endDate AndBack:^(NSDictionary *backDic) {
        hud.detailsLabel.text = @"预约成功";
        [hud hideAnimated:YES afterDelay:1.5];
        
    } failure:^(NSString *err) {
        
        hud.detailsLabel.text = err;
        [hud hideAnimated:YES afterDelay:1.5];
    }];
}

@end
