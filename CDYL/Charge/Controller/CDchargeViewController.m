//
//  CDchargeViewController.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CDchargeViewController.h"
#import "CDUserLocation.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CDBespeakTableViewCell.h"
#import "CDRowCell.h"
#import "HSDatePickerViewController.h"
#import "CDLocationViewController.h"

@interface CDchargeViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate,rowCellDelagate,HSDatePickerViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, copy) NSString *rowStr;
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
    
    CGFloat heightY =HeaderHeight *2+SmallCellHeight*3+bigCellHeight;
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(30, heightY+50, DEAppWidth-60, 40)];
    btn.backgroundColor=LHColor(255, 189, 0);
    [btn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"查找" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.layer.cornerRadius=20;
    [self.tableV addSubview:btn];

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self arrAboutBespeak];
}
-(NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
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
       
        NSString *dateStr = [self getDate];
        [self.array addObject:cityStr];
        [self.array addObject:locationStr];
        [self.array addObject:dateStr];
        
    }
    [self.tableV reloadData];
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
@end
