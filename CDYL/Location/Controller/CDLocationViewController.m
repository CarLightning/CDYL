//
//  CDLocationViewController.m
//  CDYL
//
//  Created by admin on 2018/5/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDLocationViewController.h"
#import "CDShowCell.h"

@interface CDLocationViewController ()<UITableViewDelegate,UITableViewDataSource,ShowCellDelegate>
@property (nonatomic, strong) NSArray *stationSource;
@property (nonatomic, strong) UITableView *tabaleV;

@end

@implementation CDLocationViewController

static NSString *const identifyCell = @"SHOWCELL";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubs];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSourceFromWeb];
}
-(void)getSourceFromWeb{
    NSString *lat = [NSString stringWithFormat:@"%.3f",self.nowCoordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%.3f",self.nowCoordinate.longitude];
    NSTimeInterval beginTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval  endTime = beginTime +3600;
NSString *begin = [NSString stringWithFormat:@"%.0f",beginTime];
    NSString *end = [NSString stringWithFormat:@"%.0f",endTime];
    __block typeof(self) weakself = self;
    [CDWebRequest requestsearchCanBespeakChargePoleWithlat:lat lon:lon radius:@"100" type:@"0" status:@"0" startTime:begin endTime:end regId:@"" AndBack:^(NSDictionary *backDic) {
        
        NSString *is_ok = [NSString stringWithFormat:@"%@",backDic[@"success"]];
       
        if ([is_ok isEqualToString:@"1"]) {
            
           weakself.stationSource =[weakself changeArrFrom:backDic[@"stationlist"]];
            [weakself.tabaleV reloadData];
        }
    } failure:^(NSError *err) {
        
        
    }];
}
- (void)initSubs {
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    tv.delegate=self;
    tv.dataSource=self;
    [tv registerClass:[CDShowCell class] forCellReuseIdentifier:identifyCell];
    [self.view addSubview:tv];
    self.tabaleV =tv;
}
#pragma mark -  tableViewDelagate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stationSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyCell forIndexPath:indexPath];

    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.model = self.stationSource[indexPath.row];
    cell.delegate = self ;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CDShowCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
#pragma mark -  ShowCellDelegate

/***点击导航按钮***/
-(void)clickTheNavigationButton{
    NSLog(@"点击导航");
}
/***点击收藏按钮***/
-(void)clickTheCollectionButton{
    NSLog(@"点击收藏");
}

//排序
-(NSArray *)changeArrFrom:(NSArray *)arr{
   ;
    NSArray *newArr=[arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString * distance1=[NSString stringWithFormat:@"%@",obj1[@"distance"]];
        float dis1= distance1.floatValue;
        NSString * distance2=[NSString stringWithFormat:@"%@",obj2[@"distance"]];
        
        float dis2=distance2.floatValue;
        
        if (dis1<dis2) {
            return  NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
        
    }];
    NSArray *lastArr = [CDStation arrayOfModelsFromDictionaries:newArr error:nil];
    return lastArr;
}
@end
