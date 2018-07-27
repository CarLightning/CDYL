//
//  CDMapViewController.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//
#import "CDMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CDWebRequest.h"
#import "CDStation.h"
#import "LocationAnnotationView.h"
#import "AliMapViewCustomAnnotationView.h"
#import "CDPointAnnotation.h"
#import "AliMapViewCustomCalloutView.h"
#import "CDLocationViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "GPSNaviViewController.h"
#import "CDCompanyShow.h"
#import "CDUserLocation.h"
#import "CDPoleViewController.h"

#define paoHight (is_iphoneX ? CDPaoHight+34: CDPaoHight)
@interface CDMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,CallViewDelegate>{
    LocationAnnotationView *_locationAnnotationView;

   
}

@property (nonatomic, strong) MAMapView *mapview;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D nowCoordinate;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) AliMapViewCustomCalloutView *selectView;
@property (nonatomic) BOOL is_request; // 是否请求
@end

@implementation CDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.is_request = YES;
    [self setAliMap];
    [self setRightItem];
    [self setBtn];
   
    [self location];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.navigationController.navigationBar.hidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    if (self.selectView &&self.selectView.hidden) {
        self.selectView.hidden = NO;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.selectView && !self.selectView.hidden) {
        self.selectView.hidden = YES;
    }
    
}
#pragma mark selector
-(void)setAliMap{
    [AMapServices sharedServices].enableHTTPS = YES;
    //初始化地图
    MAMapView *mapview = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    mapview.mapType = 0;
    //配置属性
    mapview.showsScale = NO;
    mapview.showsCompass = NO;
    mapview.rotateCameraEnabled = NO;
    mapview.rotateEnabled= NO;
    mapview.compassOrigin = CGPointMake(10, 100);
    mapview.logoCenter = CGPointMake(DEAppHeight - 50, 285);
    mapview.zoomLevel = 14;
    //    mapview.minZoomLevel = 14;
    mapview.delegate = self;
    //    mapview.maxZoomLevel = 17;
    
    ///把地图添加至view
    [self.view addSubview:mapview];
    self.mapview =mapview;
    
    //    不显示经度圈
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;
    
    [self.mapview updateUserLocationRepresentation:r];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    mapview.showsUserLocation = YES;
    mapview.userTrackingMode = MAUserTrackingModeFollow;
    
    self.locationManager = [[AMapLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.locatingWithReGeocode = NO;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
}
-(NSMutableArray *)sourceArray{
    
    return _sourceArray?:(_sourceArray = ({
        NSMutableArray *sourceArray = [NSMutableArray array];
        sourceArray;
    }));
}
-(void)setRightItem{
    UIButton *btn = [[UIButton alloc]init];
    CGRect frame = CGRectMake(0, 0, 40, 40);
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:@"rightItem"] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self action:@selector(_clickTheItem:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}


-(void)setBtn{
    UIButton *btn=[[UIButton alloc]init];
    if (IS_IPHONE_X) {
        btn.frame = CGRectMake(30, DEAppHeight-44-34-60, 30, 30);
    }else{
        btn.frame = CGRectMake(30, DEAppHeight-44-60, 30, 30);
    }
    btn.backgroundColor=LHColor(255, 198, 0);
    [btn setTitle:@"定" forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.shadowOffset = CGSizeMake(1, 1);
    btn.layer.shadowOpacity = 0.8;
    btn.layer.cornerRadius=5;
    [self.view addSubview:btn];
    
    
    
}
-(void)location{
    
    
    //单次定位
    [self.locationManager startUpdatingLocation];
    
}
-(void)getSource:(BOOL)is_request{
    if (!self.is_request) {
        return;
        
    }else{
        self.is_request = NO;
    //CLLocationCoordinate2D amapcoord =CLLocationCoordinate2DMake(30.277, 120.33);
    
    typeof(self) __block weakSelf =  self;
        CLLocationCoordinate2D  location  = self.nowCoordinate;
        NSString * lat = [NSString stringWithFormat:@"%.3f",location.latitude];
        NSString * lon = [NSString stringWithFormat:@"%.3f",location.longitude];
      
    [CDWebRequest requestsearchChargePoleWithlat:lat lon:lon radius:@"2000" type:@"0" status:@"0" startTime:@"0" endTime:@"0" regId:@"" AndBack:^(NSDictionary *backDic) {
        
        NSDictionary *dic = backDic;
        
        NSArray *stationList = [CDStation arrayOfModelsFromDictionaries:dic[@"stationlist"] error:nil];
        
        [weakSelf createAnnotation:stationList];
        
    } failure:^(NSString *err) {
        
    }];
    }
}
#pragma mark - 点击事件
- (void)_clickTheItem:(UIButton *)btn {
    CDLocationViewController *loca = [[CDLocationViewController alloc]init];
    loca.nowCoordinate = self.nowCoordinate;
    loca.cthType = 0;//附近充电桩
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loca animated:YES];
    self.hidesBottomBarWhenPushed = NO;
   
}
-(void)clickTheBtn{
    self.is_request = YES;
    [self getSource:self.is_request];
    [self location];
    [self.mapview setZoomLevel:16 animated:YES];
    [self.mapview setCenterCoordinate:self.nowCoordinate animated:YES];
}
#pragma mark - AMapLocationManagerDelegate

-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    CLLocationCoordinate2D coor = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coor.latitude, coor.longitude);
    //    AMapCoordinateType type = AMapCoordinateTypeGPS;
    //    _nowCoordinate = AMapCoordinateConvert(coor, type);
    self.nowCoordinate = coor;
    [CDUserLocation share].userCoordinate = coor;
    
     [self getSource:self.is_request];
}
#pragma mark - MAMapViewDelegate
#pragma mark 代理方法很多，根据需求选择

// 地图开始加载
-(void)mapViewWillStartLoadingMap:(MAMapView *)mapView{
    NSLog(@"%s",__func__);
}

//加载地图结束
-(void)mapViewDidFinishLoadingMap:(MAMapView *)mapView{
    NSLog(@"%s",__func__);
}

//地图加载失败
- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
    NSLog(@"%s---%@",__func__,error);
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    return nil;
}
//获取标注视图
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]]){
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[LocationAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationStyleReuseIndetifier];
            
            annotationView.canShowCallout = YES;
        }
        
        _locationAnnotationView = (LocationAnnotationView *)annotationView;
        [_locationAnnotationView updateImage:[UIImage imageNamed:@"userPosition"]];
        
        return annotationView;
    }else if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        
      return   [self fullCustomAnnotationViewWithMapView:mapView viewForAnnotation:annotation];
    }
    
    return nil;
}
//选中标注的时候
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view isKindOfClass:[AliMapViewCustomAnnotationView class]]) {
        
        // 创建泡泡视图
        AliMapViewCustomCalloutView *CustomCalloutView = [[AliMapViewCustomCalloutView alloc]initWithFrame:CGRectMake(0, DEAppHeight, DEAppWidth, paoHight)];
        CustomCalloutView.delegate = self;
        [[[UIApplication sharedApplication] keyWindow] addSubview : CustomCalloutView];
        
        
        
        CDPointAnnotation *annotation = (CDPointAnnotation *)view.annotation;
        [self.mapview setCenterCoordinate:annotation.coordinate animated:YES];
       
       CustomCalloutView.stationModel = annotation.stationModel;
        
//        self.tabBarController.tabBar.hidden = YES;
        

        
        CGPoint point = CustomCalloutView.center;
        CGPoint newPoint = CGPointMake(point.x, point.y- paoHight);
        self.selectView = CustomCalloutView;
        [UIView animateWithDuration:0.3f animations:^{
           
            CustomCalloutView.center = newPoint;
            
            
        } completion:^(BOOL finished) {
           
            
        }];
        
    }
}
//取消选中标注的时候
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
    if (self.selectView) {
        AliMapViewCustomCalloutView *CustomCalloutView = self.selectView;
        CGPoint point = self.selectView.center;
        CGPoint newPoint = CGPointMake(point.x, point.y- paoHight/2);
        [UIView animateWithDuration:0.3f animations:^{
            self.selectView.alpha = 0;
            self.selectView.center = newPoint;
//            self.tabBarController.tabBar.hidden = NO;
        } completion:^(BOOL finished) {

            [CustomCalloutView removeFromSuperview];
        }];
    }
    
}
//手机方向调整
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    
    if (!updatingLocation && _locationAnnotationView != nil)
    {
        [UIView animateWithDuration:0.1 animations:^{
            _locationAnnotationView.rotateDegree = userLocation.heading.trueHeading - self.mapview.rotationDegree;
        }];
    }
    
    
}
#pragma mark - method
- (void)createAnnotation:(NSArray *)source{
    [self.mapview removeAnnotations:self.sourceArray];
    [self.sourceArray removeAllObjects];
    for (CDStation *model in source) {
        @autoreleasepool {
       CDPointAnnotation *pointAnnotation = [[CDPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.lat, model.lon);
        //将GPS转成高德坐标
      // pointAnnotation.coordinate =AMapCoordinateConvert(coordinate, AMapCoordinateTypeGPS);
        pointAnnotation.coordinate = coordinate;
            pointAnnotation.stationModel = model;
        
        [self.mapview addAnnotation:pointAnnotation];
            [self.sourceArray addObject:pointAnnotation];
        }
    }
}
//使用纯定义大头针标注视图
-(AliMapViewCustomAnnotationView *)fullCustomAnnotationViewWithMapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    static NSString *reuseIndetifier = @"annotationReuseIndetifier";
    AliMapViewCustomAnnotationView *annotationView = (AliMapViewCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
    if (annotationView == nil)
    {
        annotationView = [[AliMapViewCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
    }
    annotationView.image = [UIImage imageNamed:@"annotation.png"];
    
    //设置为NO，用以调用自定义的calloutView
    annotationView.canShowCallout = NO;
    
    //设置中心点偏移，使得标注底部中间点成为经纬度对应点
    annotationView.centerOffset = CGPointMake(0, -18);
    
    return annotationView;
}
- (void)showAlert:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
   
    [alert addAction:action1];

    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark - CallViewDelegate
/** 点击蓝体字事件回调 */
- (void)stationModel:(CDStation *)model didTouchHightLightLabel:(BOOL)touch{
    NSLog(@"点击蓝体字");
    CDCompanyShow *subViewController = [[NSClassFromString(@"CDCompanyShow") alloc] init];
    
    subViewController.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subViewController animated:YES];
     self.hidesBottomBarWhenPushed = NO;
}
/** 点击收藏的事件回调 */
- (void)stationModel:(CDStation *)model didCollection:(BOOL)collection{
     NSLog(@"点击收藏");
    
    NSString *phoneNub = [CDUserInfor shareUserInfor].phoneNum;
     NSString *PwNub = [CDUserInfor shareUserInfor].userPword;
    NSString *facType = @"1";
    NSString *facId = model.pid;
    
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
    
    
    
    __weak typeof(self) weakself = self;
    [CDWebRequest requestgaddCollectWithidentity:@"1" cardNo:phoneNub Pass:PwNub facId:facId facType:facType AndBack:^(NSDictionary *backDic) {
 
        [weakself showAlert:@"收藏成功"];
        
    } failure:^(NSString *err) {
        [weakself showAlert:err];
        
    }];
    
    
    
    
    }
    
    
}
/** 点击导航的事件回调 */
- (void)stationModel:(CDStation *)model didNavigationBtn:(BOOL)naviagtion{
     NSLog(@"点击导航");
    CLLocationCoordinate2D  location  = self.nowCoordinate;
    AMapNaviPoint *startPoint =  [AMapNaviPoint locationWithLatitude:location.latitude longitude:location.longitude];
    AMapNaviPoint *endPoint =  [AMapNaviPoint locationWithLatitude:model.lat longitude:model.lon];
    GPSNaviViewController *gpsNavi = [[GPSNaviViewController alloc]init];
    gpsNavi.startPoint = startPoint;
    gpsNavi.endPoint = endPoint;
    
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:gpsNavi animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
    [self presentViewController:gpsNavi animated:YES completion:nil];
}
/** 点击预约的事件回调 */
- (void)stationModel:(CDStation *)model didAppointmentBtn:(BOOL)appointment{
    
    CDPoleViewController *poleView = [[CDPoleViewController alloc]init];
    poleView.stationModel = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:poleView animated:YES];
    self.hidesBottomBarWhenPushed = NO;
     NSLog(@"点击预约");
}
@end
