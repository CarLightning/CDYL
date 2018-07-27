//
//  CDLocationViewController.m
//  CDYL
//
//  Created by admin on 2018/5/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDLocationViewController.h"
#import "CDShowCell.h"
#import "CDPoleViewController.h"
#import "CDUserLocation.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "GPSNaviViewController.h"

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
    
    if (self.navigationController.navigationBar.hidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    if (self.cthType == 0) {
        //附近
        [self getSourceFromWeb];
    }else{
        //收藏
        [self getSourceWithCollection];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.cthType != 0) {
        NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
        if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
            //当前视图控制器在栈中，故为push操作
            NSLog(@"push");
        } else if ([viewControllers indexOfObject:self] == NSNotFound) {
            //当前视图控制器不在栈中，故为pop操作
            self.navigationController.navigationBarHidden = YES;
        }
    }
}
#pragma mark -  tableViewDelagate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stationSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifyCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.model = self.stationSource[indexPath.row];
    cell.btnName = @"取消收藏";
    if (self.cthType == 0) {
        cell.btnName = @"收藏";
    }
    cell.delegate = self ;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 196;
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
    
    CDPoleViewController *poleView = [[CDPoleViewController alloc]init];
    poleView.stationModel = cell.model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:poleView animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}
#pragma mark -  ShowCellDelegate

/***点击导航按钮***/
-(void)clickTheNavigationButtonWithCDStation:(CDStation *)model{
    NSLog(@"点击导航");
    //    CLLocationCoordinate2D  location  = self.nowCoordinate;
    CLLocationCoordinate2D  location  = [CDUserLocation share].userCoordinate;
    AMapNaviPoint *startPoint =  [AMapNaviPoint locationWithLatitude:location.latitude longitude:location.longitude];
    AMapNaviPoint *endPoint =  [AMapNaviPoint locationWithLatitude:model.lat longitude:model.lon];
    GPSNaviViewController *gpsNavi = [[GPSNaviViewController alloc]init];
    gpsNavi.startPoint = startPoint;
    gpsNavi.endPoint = endPoint;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gpsNavi animated:YES];
    
}
/***点击收藏按钮***/
-(void)clickTheCollectionButtonWithCDStation:(CDStation *)model{
    NSLog(@"点击收藏");
    NSString *phoneNub = [CDUserInfor shareUserInfor].phoneNum;
    NSString *PwNub = [CDUserInfor shareUserInfor].userPword;
    NSString *facType = @"1";
    NSString *facId = model.pid;
    __weak typeof(self) weakself = self;
    if (![CDXML isLogin]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重新登陆" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CDBaseViewController*  basecth = [[NSClassFromString(@"CDViewController") alloc]init];
            
            CDNav *navi = [[CDNav alloc]initWithRootViewController:basecth];
            navi.navigationBar.hidden = YES;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navi animated:YES completion:nil];
        }];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        if (self.cthType ==0) {
            
            
            [CDWebRequest requestgaddCollectWithidentity:@"1" cardNo:phoneNub Pass:PwNub facId:facId facType:facType AndBack:^(NSDictionary *backDic) {
                
                [weakself showAlert:@"收藏成功"];
                
            } failure:^(NSString *err) {
                [weakself showAlert:err];
                
            }];
            
        }else{
            [CDWebRequest requestdeleteColleteWithidentity:@"1" cardNo:phoneNub Pass:PwNub facId:facId AndBack:^(NSDictionary *backDic) {
                [weakself showAlert:@"取消成功"];
                [weakself getSourceWithCollection];
            } failure:^(NSString *err) {
                [weakself showAlert:err];
            }];
        }
    }
}

#pragma mark -  Method
#pragma mark -附近
-(void)getSourceFromWeb{
    NSString *lat = [NSString stringWithFormat:@"%.3f",self.nowCoordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%.3f",self.nowCoordinate.longitude];
    NSTimeInterval beginTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval  endTime = beginTime +3600;
    NSString *begin = [NSString stringWithFormat:@"%.0f",beginTime];
    NSString *end = [NSString stringWithFormat:@"%.0f",endTime];
    __block typeof(self) weakself = self;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self hiddenAllBaseView];
    if (self.radius == nil) {
        self.radius =@"100";
    }
    [CDWebRequest requestsearchCanBespeakChargePoleWithlat:lat lon:lon radius:self.radius type:@"0" status:@"0" startTime:begin endTime:end regId:@"" AndBack:^(NSDictionary *backDic) {
        
        weakself.stationSource =[weakself changeArrFrom:backDic[@"stationlist"]];
        [hud hideAnimated:YES];
        [weakself.tabaleV reloadData];
        if (weakself.stationSource.count == 0) {
            [weakself showEmptyViewWith:@"附近没有找到充电桩"];
        }
    } failure:^(NSString *err) {
        [hud hideAnimated:YES];
        [weakself showEmptyViewWith:err];
        
    }];
}
#pragma mark -收藏
- (void)getSourceWithCollection{
    [self hiddenAllBaseView];
    if (![CDXML isLogin]) {
        [self showEmptyViewWith:@"用户未登录"];
    }else{
        __block typeof(self) weakself = self;
        NSString *cardNo = [CDUserInfor shareUserInfor].phoneNum;
        NSString *pass = [CDUserInfor shareUserInfor].userPword;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [CDWebRequest requestgetMyCollectWithidentity:@"1" cardNo:cardNo Pass:pass AndBack:^(NSDictionary *backDic) {
            
            weakself.stationSource =[weakself changeArrFrom:backDic[@"stationlist"]];
            [hud hideAnimated:YES];
            [weakself.tabaleV reloadData];
        } failure:^(NSString *err) {
        }];
    }
}

- (void)initSubs {
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    tv.delegate=self;
    tv.dataSource=self;
    tv.backgroundColor = [UIColor clearColor];
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tv registerClass:[CDShowCell class] forCellReuseIdentifier:identifyCell];
    [self.view addSubview:tv];
    self.tabaleV =tv;
}
//距离排序
-(NSArray *)changeArrFrom:(NSArray *)arr{
    NSString *keyStr = [[NSString alloc]init];
    if (self.cthType == 0) {
        keyStr = @"distance";
    }else{
        keyStr = @"id";
    }
    NSArray *newArr=[arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString * distance1=[NSString stringWithFormat:@"%@",obj1[keyStr]];
      
        NSString * distance2=[NSString stringWithFormat:@"%@",obj2[keyStr]];
        if (self.cthType == 0) {
            
            
            float dis1= distance1.floatValue;
            float dis2=distance2.floatValue;
            
            if (dis1<dis2) {
                return  NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
         
        } else {
         distance1 =  [distance1 substringFromIndex:8];
         distance2 =  [distance2 substringFromIndex:8];
            long long dis1= distance1.longLongValue;
            long long dis2=distance2.longLongValue;
            long long d = dis1-dis2;
            if (d<0) {
                return  NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
        }
        
    }];
    NSArray *lastArr = [CDStation arrayOfModelsFromDictionaries:newArr error:nil];
    return lastArr;
}

- (void)showAlert:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
