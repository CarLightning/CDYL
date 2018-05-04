//
//  CDWebRequest.m
//  CDYL
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 admin. All rights reserved.
//


#import "CDWebRequest.h"
#import "CDAFNetLine.h"


@implementation CDWebRequest

static NSString *const headStr = @"http://183.129.254.28/webservice/services";
//查询充电站
+ (void)requestsearchChargePoleWithlat:(NSString *)lat
                                   lon:(NSString *)lon
                                radius:(NSString *)radius
                                  type:(NSString *)type
                                status:(NSString *)status
                             startTime:(NSString *)startTime
                               endTime:(NSString *)endTime
                                 regId:(NSString *)regId
                               AndBack:(void (^)(NSDictionary * backDic))success
                               failure:(void (^)(NSError * _Nonnull))failure{
    
    NSString *urlString =[headStr stringByAppendingPathComponent:@"StationWebService/searchChargePoleAll"];
    NSDictionary *parameter = @{@"lat":lat,
                                @"lon":lon,
                                @"radius":radius,
                                @"type":type,
                                @"status":status,
                                @"startTime":startTime,
                                @"endTime":endTime,
                                @"regId":regId
                                };
    
//    @"http://183.129.254.28/webservice/services/StationWebService/searchChargePoleAll?lat=30.3&lon=120.35&radius=2000&type=0&status=0&startTime=0&endTime=0&regId=";
   
    [[CDAFNetLine shareManager] Post:urlString Parameter:parameter XMLString:@"searchChargePoleAll" success:success failure:failure];
    
    
}
//登录
//http://183.129.254.28/webservice/services/IcCardWebService/checkLogin?type=1&name=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E
+ (void)loginWithName:(NSString *)name PassWord:(NSString *)pWord AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSError * err))failure{
    
    NSString *urlString =[headStr stringByAppendingPathComponent:@"IcCardWebService/checkLogin"];
    NSDictionary *parameter = @{@"name":name,
                                @"pass":pWord,
                                @"type":@"1",
                                };
     [[CDAFNetLine shareManager] Post:urlString Parameter:parameter XMLString:@"checkLogin" success:success failure:failure];
}
// 发送验证码
+ (void)requestsendVerCodeWithTel:(NSString *)tel AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSError * err))failure{
    NSString *urlString =[headStr stringByAppendingPathComponent:@"IcCardWebService/sendVerCode"];
     NSDictionary *parameter = @{@"tel":tel};
    [[CDAFNetLine shareManager] Post:urlString Parameter:parameter XMLString:@"sendVerCode" success:success failure:failure];
}
// 用户注册
+ (void)requestregUserWithTel:(NSString *)tel Code:(NSString *)cood Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSError * err))failure{
    NSString *urlString =[headStr stringByAppendingPathComponent:@"IcCardWebService/regUserByPhone"];
    NSDictionary *parameter = @{@"telphone":tel,@"verCode":cood,@"pass":pass};
    [[CDAFNetLine shareManager] Post:urlString Parameter:parameter XMLString:@"regUserByPhone" success:success failure:failure];
}
@end
