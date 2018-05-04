//
//  CDWebRequest.h
//  CDYL
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^ReturnData)(id data);
//typedef void(^Failure)(NSString * fileMsg);

@interface CDWebRequest : NSObject


//查询充电站
+ (void)requestsearchChargePoleWithlat:(NSString *)lat lon:(NSString *)lon radius:(NSString *)radius type:(NSString *)type status:(NSString *)status startTime:(NSString *)startTime endTime:(NSString *)endTime regId:(NSString *)regId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSError * err))failure;

//登录
+ (void)loginWithName:(NSString *)name PassWord:(NSString *)pWord AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSError * err))failure;
//发验证码
+ (void)requestsendVerCodeWithTel:(NSString *)tel AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSError * err))failure;

// 用户注册
+ (void)requestregUserWithTel:(NSString *)tel Code:(NSString *)cood Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSError * err))failure;








@end
