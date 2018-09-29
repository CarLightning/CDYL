//
//  CDchargeViewController.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//  预约

#import "CDchargeViewController.h"
#import "CDUserLocation.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CDBespeakTableViewCell.h"
#import "CDRowCell.h"
#import "HSDatePickerViewController.h"
#import "CDLocationViewController.h"
#import "CDBespeakView.h"

@interface CDchargeViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate,rowCellDelagate,HSDatePickerViewControllerDelegate,BespeakViewDelagate>
/**城市，位置，预约时间**/
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) AMapSearchAPI *search;
/**半径**/
@property (nonatomic, copy) NSString *rowStr;
@property (nonatomic, strong) CDBespeakView *bespeakView;
@property (nonatomic, strong) NSArray *bespeakArr; //预约数组

//查询桩开启状态
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString  * bespeakPold;


@end

@implementation CDchargeViewController

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
    self.tableV.hidden = YES;
    
    CGFloat heightY =HeaderHeight *2+SmallCellHeight*3+bigCellHeight;
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(30, heightY+50, DEAppWidth-60, 40)];
    btn.backgroundColor=LHColor(255, 189, 0);
    [btn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"查找" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.layer.cornerRadius=20;
    [self.tableV addSubview:btn];
    
    [self.view addSubview:self.bespeakView];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![CDXML isLogin]) {
        [self showTableView];
    }else{
        [self getBesparkArrInfor];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
    
}
-(void)dealloc{
    NSLog(@"退出预约界面");
}
#pragma mark - Get method
-(CDBespeakView *)bespeakView{
    if (_bespeakView == nil) {
        CGFloat height = 64;
        if (is_iphoneX) {
            height=88;
        }
        _bespeakView = [[CDBespeakView alloc]initWithFrame:CGRectMake(0, height, DEAppWidth, 246)];
        _bespeakView.delagate = self;
        _bespeakView.hidden = YES;
    }
    return _bespeakView;
}
-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
#pragma mark - 自定义 method
- (void)getBesparkArrInfor{
    __block typeof(self) weakself = self;
    [CDWebRequest requestgetBespeakPoleIdByCardnoWithidentity:@"1" cardNo:[CDUserInfor shareUserInfor].phoneNum Pass:[CDUserInfor shareUserInfor].userPword AndBack:^(NSDictionary *backDic) {
        weakself.bespeakArr = backDic[@"list"];
        if (weakself.bespeakArr.count>0) {
            [weakself showBeSpeakView:weakself.bespeakArr.firstObject];
        }else{
            [weakself showTableView];
        }
        
    } failure:^(NSString *err) {
        
    }];
}
- (void)showBeSpeakView:(NSDictionary *)dic{
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkPoldState) userInfo:nil repeats:YES];
        self.timer.fireDate = [NSDate distantFuture];
        self.count = 0 ;
    }
    self.tableV.hidden = YES;
    self.navigationItem.title = @"当前预约";
    CDBespeakModel *model = [[CDBespeakModel alloc]init];
    model.name = dic[@"addr"];
    model.detailName = dic[@"name"];
    model.poleid = [NSString stringWithFormat:@"%@",dic[@"poleID"]];
    model.cardid = [NSString stringWithFormat:@"%@",dic[@"cardID"]];
    model.bespeakid = [NSString stringWithFormat:@"%@",dic[@"bespeakServId"]];
    model.startTime = [NSString stringWithFormat:@"%@",dic[@"startTime"]];
    model.endTime = [NSString stringWithFormat:@"%@",dic[@"finishTime"]];
    [model star:[NSString stringWithFormat:@"%@",dic[@"startTime"]] endTime:[NSString stringWithFormat:@"%@",dic[@"finishTime"]] is_all:YES];
    model.lat = [NSString stringWithFormat:@"%@",dic[@"lat"]].floatValue;
    model.lon = [NSString stringWithFormat:@"%@",dic[@"lon"]].floatValue;
    
    self.bespeakView.model = model;
    self.bespeakView.hidden = NO;
    
}
-(void)showTableView{
    self.bespeakView.hidden = YES;
    self.tableV.hidden = NO;
    self.navigationItem.title = @"预约";
    [self arrAboutBespeak];
}
- (void)showAlert:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([msg isEqualToString:@"取消成功"]) {
            [self getBesparkArrInfor];
        }
        
    }];
    
    [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)didNowChargeBtnWithModel:(CDBespeakModel *)model{
    NSLog(@"点击开始充电");
    NSString *phoneNub = [CDUserInfor shareUserInfor].phoneNum;
    NSString *PwNub = [CDUserInfor shareUserInfor].userPword;
    NSString *cardId = model.cardid;
    NSString *poleid = model.poleid;
    self.bespeakPold = poleid;
    NSString *bespeak_serv_id = model.bespeakid;
    __weak typeof(self) weakself = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"开启充电中";
    [CDWebRequest requestOpenPoldWithIdentity:@"1" poleId:poleid cardNo:phoneNub pass:PwNub cardId:cardId type:@"0" value:@"0" pwm:@"100" bespeak_serv_id:bespeak_serv_id AndBack:^(NSDictionary *backDic) {
        hud.label.text = @"正在进行绝缘检测，请稍等";
        [weakself whetherOpenPoldOk];
    } failure:^(NSString *err){
        hud.label.text = err;
        [hud hideAnimated:YES afterDelay:1.5f];
    }];
}
- (void)didCollectionBtnWithModel:(CDBespeakModel *)model{
    NSLog(@"点击收藏");
    
    NSString *phoneNub = [CDUserInfor shareUserInfor].phoneNum;
    NSString *PwNub = [CDUserInfor shareUserInfor].userPword;
    NSString *facType = @"1";
    NSString *facId = model.poleid;
    __weak typeof(self) weakself = self;
    [CDWebRequest requestgaddCollectWithidentity:@"1" cardNo:phoneNub Pass:PwNub facId:facId facType:facType AndBack:^(NSDictionary *backDic) {
        
        [weakself showAlert:@"收藏成功"];
        
    } failure:^(NSString *err) {
        [weakself showAlert:err];
        
    }];
}
- (void)didCandelBespeakBtnWithModel:(CDBespeakModel *)model{
    NSLog(@"点击取消预约");
    NSString *phoneNub = [CDUserInfor shareUserInfor].phoneNum;
    NSString *PwNub = [CDUserInfor shareUserInfor].userPword;
    NSString *cardId = model.cardid;
    NSString *bespeakid = model.bespeakid;
    __weak typeof(self) weakself = self;
    
    [CDWebRequest requestdisBespeakPoleWithidentity:@"1" cardNo:phoneNub Pass:PwNub cardId:cardId bespeak_serv_id:bespeakid AndBack:^(NSDictionary *backDic) {
        [weakself showAlert:@"取消成功"];
        
    } failure:^(NSString *err) {
        [weakself showAlert:err];
    }];
}
/***开启桩成功与否查询**/
- (void)whetherOpenPoldOk{
    
    self.timer.fireDate = [NSDate distantPast];
    
}

-(void)checkPoldState{
    if (self.count>= 12) {
        [self openNO];
    }else{
        __weak typeof(self) weakself = self;
        [CDWebRequest requestgetRealByPoleIdid:self.bespeakPold AndBack:^(NSDictionary *backDic) {
            NSString *status = [NSString stringWithFormat:@"%@",backDic[@"poleReal"][@"status"]];
            if ([status isEqualToString:@"1"]) {
                [weakself openOk];
            }
        } failure:^(NSString *err) {
            
        }];
        self.count++;
    }
    
}
/***开启桩失败**/
-(void)openNO{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"ErrorMark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc]initWithImage:image];
    hud.label.text = @"开启失败";
    [hud hideAnimated:YES afterDelay:1.5f];
    self.count = 0;
    self.timer.fireDate = [NSDate distantFuture];
}

/***开启桩成功**/
-(void)openOk{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.text = @"开启成功";
    [hud hideAnimated:YES afterDelay:1.5f];
    self.count = 0;
    self.timer.fireDate = [NSDate distantFuture];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tabBarController.selectedIndex = 1;
        self.tabBarController.selectedViewController = self.tabBarController.childViewControllers[1];
    });
}

#pragma mark -  tableViewDelagate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CDBespeakTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"bespeakupcell" forIndexPath:indexPath];
        cell.status  = 100;
        [cell reloadCellWithRow:indexPath.row arr:self.array];
        return cell;
    }else  {
        CDRowCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"rowcell" forIndexPath:indexPath];
        cell.status  = 100;
        cell.delagate = self;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 ) {
        return SmallCellHeight;
    }
    return bigCellHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, 10)];
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
    if (indexPath.section == 0 && indexPath.row == 2) {
        HSDatePickerViewController *hsdpvc = [[HSDatePickerViewController alloc] init];
        hsdpvc.delegate = self;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:hsdpvc animated:YES completion:nil];
    }
}
#pragma mark - AMapSearchDelegate
- (void)arrAboutBespeak{
    self.search = [[AMapSearchAPI alloc]init];
    self.search.delegate = self;
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    CLLocationCoordinate2D location = [CDUserLocation share].userCoordinate;
    regeo.location = [AMapGeoPoint locationWithLatitude:location.latitude longitude:location.longitude];
    regeo.requireExtension   = YES;
    [self.search AMapReGoecodeSearch:regeo];
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        NSString *locationStr = response.regeocode.formattedAddress;
        NSString *cityStr = response.regeocode.addressComponent.city;
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *dateStr = [self getDate];
            [weakself.array addObject:cityStr];
            [weakself.array addObject:locationStr];
            [weakself.array addObject:dateStr];
            [weakself.tableV reloadData];
        });
    }
}
- (NSString *)getDate{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSTimeInterval oldtime = [NSDate date].timeIntervalSince1970+1800;
    NSDate *showDate = [NSDate dateWithTimeIntervalSince1970:oldtime];
    NSString *dateStr = [format stringFromDate:showDate];
    return dateStr;
}
#pragma mark - rowCellDalagate
-(void)changeTheSearchValue:(NSString *)index{
    self.rowStr = index;
}

- (void)clickTheBtn{
    CDLocationViewController *loca = [[CDLocationViewController alloc]init];
    loca.nowCoordinate = [CDUserLocation share].userCoordinate;
    loca.cthType = 0;//附近充电桩
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loca animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateStr = [format stringFromDate:date];
    [self.array replaceObjectAtIndex:2 withObject:dateStr];
    [self.tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:YES];
}
#pragma mark - BespeakViewDelagate
-(void)userDidClickTheBtn:(UIButton *)btn CDBespeakModel:(CDBespeakModel *)model{
    switch (btn.tag) {
        case 10:
            [self didNowChargeBtnWithModel:model];
            break;
        case 15:
            [self didCandelBespeakBtnWithModel:model];
            break;
        default:
            [self didCollectionBtnWithModel:model];
            break;
    }
}
@end
