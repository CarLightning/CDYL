//
//  CDBespeakModel.m
//  CDYL
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBespeakModel.h"
#import "CDUserLocation.h"

@interface CDBespeakModel ()

@end
@implementation CDBespeakModel

-(NSString *)comparyName{
    if (_comparyName == nil) {
        _comparyName = @"硕维新能源技术有限公司";
    }
    return _comparyName;
}
-(NSString *)distance{
    if (_distance == nil) {
        if (self.lat && self.lon) {
            //1.将两个经纬度点转成投影点
            MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(self.lat,self.lon));
            CLLocationCoordinate2D userloca =[CDUserLocation share].userCoordinate;
            
            MAMapPoint point2 = MAMapPointForCoordinate([CDUserLocation share].userCoordinate);
            //2.计算距离
            CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
            _distance = [NSString stringWithFormat:@"%.2fkm",distance/1000];
            return _distance;
        }
    }
    return @"0.00km";
    
}




-(void)setDetailName:(NSString *)detailName{
    NSArray *arr = [detailName componentsSeparatedByString:@":"];
    _detailName = arr.lastObject;
}
-(void)setStartTime:(NSString *)startTime{
    
    _startTime = [self star:startTime endTime:nil is_all:NO];
}
-(void)setEndTime:(NSString *)endTime{
    _endTime = [self star:nil endTime:endTime is_all:NO];
    
}

- (NSString *)star:(NSString *)sTime endTime:(NSString *)eTime is_all:(BOOL)is_all{
    NSTimeInterval starT = sTime.longLongValue/1000;
    NSTimeInterval endT = eTime.longLongValue/1000;
    NSTimeInterval allT = endT-starT;
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *starTime = [forma stringFromDate:[NSDate dateWithTimeIntervalSince1970:starT]];
    
    NSString *endTime = [forma stringFromDate:[NSDate dateWithTimeIntervalSince1970:endT]];
    NSString *allTime = [NSString stringWithFormat:@"%.0f分钟",allT/60];
    
    if (!is_all) {
        if (sTime == nil) {
            return endTime;
        }else{
            return starTime;
        }
    }
    _allTime = allTime;
    return allTime;
}
@end
