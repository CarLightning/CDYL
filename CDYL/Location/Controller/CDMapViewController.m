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

#define paoHight (is_iphoneX ? CDPaoHight+34: CDPaoHight)
@interface CDMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,CallViewDelegate>{
    LocationAnnotationView *_locationAnnotationView;

    BOOL is_request; // 是否请求
}

@property (nonatomic, strong) MAMapView *mapview;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D nowCoordinate;
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) AliMapViewCustomCalloutView *selectView;
@end

@implementation CDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    is_request = YES;
    [self setAliMap];
    [self setRightItem];
    [self setBtn];
   
    [self location];
    
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
-(NSArray *)sourceArray{
    
    return _sourceArray?:(_sourceArray = ({
        NSArray *sourceArray = [NSArray array];
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
    btn.backgroundColor=[UIColor colorWithRed:0/255.0 green:182/255.0 blue:193/255.0 alpha:1.0];
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
    if (!is_request) {
        return;
        
    }else{
        is_request = NO;
    //CLLocationCoordinate2D amapcoord =CLLocationCoordinate2DMake(30.277, 120.33);
    
    typeof(self) __block weakSelf =  self;
        CLLocationCoordinate2D  location  = self.nowCoordinate;
        NSString * lat = [NSString stringWithFormat:@"%.3f",location.latitude];
        NSString * lon = [NSString stringWithFormat:@"%.3f",location.longitude];
      
    [CDWebRequest requestsearchChargePoleWithlat:lat lon:lon radius:@"2000" type:@"0" status:@"0" startTime:@"0" endTime:@"0" regId:@"" AndBack:^(NSDictionary *backDic) {
        
        NSDictionary *dic = backDic;
        
        NSArray *stationList = [CDStation arrayOfModelsFromDictionaries:dic[@"stationlist"] error:nil];
        
        [weakSelf createAnnotation:stationList];
        
    } failure:^(NSError *err) {
        
    }];
    }
}
#pragma mark - 点击事件
- (void)_clickTheItem:(UIButton *)btn {
    CDLocationViewController *loca = [[CDLocationViewController alloc]init];
    loca.nowCoordinate = self.nowCoordinate;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loca animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)clickTheBtn{
    is_request = YES;
    [self getSource:is_request];
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
    
     [self getSource:is_request];
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
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
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
        [self.view addSubview:CustomCalloutView];
        
        
        
        CDPointAnnotation *annotation = (CDPointAnnotation *)view.annotation;
       
       CustomCalloutView.stationModel = annotation.stationModel;
        
        self.tabBarController.tabBar.hidden = YES;
        

        
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
            self.tabBarController.tabBar.hidden = NO;
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
    for (CDStation *model in source) {
        @autoreleasepool {
       CDPointAnnotation *pointAnnotation = [[CDPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(model.lat, model.lon);
        //将GPS转成高德坐标
      // pointAnnotation.coordinate =AMapCoordinateConvert(coordinate, AMapCoordinateTypeGPS);
        pointAnnotation.coordinate = coordinate;
            pointAnnotation.stationModel = model;
        
        [self.mapview addAnnotation:pointAnnotation];
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
#pragma mark - CallViewDelegate
/** 点击蓝体字事件回调 */
- (void)stationModel:(CDStation *)model didTouchHightLightLabel:(BOOL)touch{
    NSLog(@"点击蓝体字");
}
/** 点击收藏的事件回调 */
- (void)stationModel:(CDStation *)model didCollection:(BOOL)collection{
     NSLog(@"点击收藏");
}
/** 点击导航的事件回调 */
- (void)stationModel:(CDStation *)model didNavigationBtn:(BOOL)naviagtion{
     NSLog(@"点击导航");
}
/** 点击预约的事件回调 */
- (void)stationModel:(CDStation *)model didAppointmentBtn:(BOOL)appointment{
     NSLog(@"点击预约");
}
@end
