//
//  CDWebRequest.m
//  CDYL
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 admin. All rights reserved.
//


#import "CDWebRequest.h"
#import "CDAFNetLine.h"

//http://183.129.254.28/webservice/services/IcCardWebService/wxOrderId?total_fee=1&accName=&accId=&cardId=3050120160821006
@implementation CDWebRequest

static NSString *const headStr = @"http://183.129.254.28/webservice/services";

+ (void)addLastString:(NSString *)str parameter:(NSDictionary *)parame AndBack:(void(^)(NSDictionary * backDic))success failure:(void(^)(NSString  * error))meg{
    NSString *urlString =[headStr stringByAppendingPathComponent:str];
    NSString *lastStr = [[str componentsSeparatedByString:@"/"] lastObject];
    [[CDAFNetLine shareManager] Post:urlString Parameter:parame XMLString:lastStr success:success failure:meg];
}

#pragma mark - 查询充电站
+ (void)requestsearchChargePoleWithlat:(NSString *)lat lon:(NSString *)lon radius:(NSString *)radius type:(NSString *)type status:(NSString *)status startTime:(NSString *)startTime endTime:(NSString *)endTime regId:(NSString *)regId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * _Nonnull))failure{

   NSDictionary *parameter = @{@"lat":lat,@"lon":lon, @"radius":radius, @"type":type, @"status":status, @"startTime":startTime,@"endTime":endTime, @"regId":regId};
    
//    @"http://183.129.254.28/webservice/services/StationWebService/searchChargePoleAll?lat=30.3&lon=120.35&radius=2000&type=0&status=0&startTime=1526027400&endTime=1526031000&regId=";
   

    NSString * string =@"StationWebService/searchChargePoleAll";
   
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 查询充电站
+ (void)requestsearchCanBespeakChargePoleWithlat:(NSString *)lat lon:(NSString *)lon radius:(NSString *)radius type:(NSString *)type status:(NSString *)status startTime:(NSString *)startTime endTime:(NSString *)endTime regId:(NSString *)regId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * _Nonnull))failure{
    
    NSDictionary *parameter = @{@"lat":lat,@"lon":lon, @"radius":radius, @"type":type, @"status":status, @"startTime":startTime,@"endTime":endTime, @"regId":regId};
    
   
    
    //    @"http://183.129.254.28/webservice/services/StationWebService/searchChargePole?lat=30.3&lon=120.35&radius=2000&type=0&status=0&startTime=1526027400&endTime=1526031000&regId=";
    
    NSString * string =@"StationWebService/searchChargePole";
    
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 登录
//http://183.129.254.28/webservice/services/IcCardWebService/checkLogin?type=1&name=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E
+ (void)loginWithName:(NSString *)name PassWord:(NSString *)pWord AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    
    
    NSDictionary *parameter = @{@"name":name,
                                @"pass":pWord,
                                @"type":@"1",
                                };
    NSString * string =@"IcCardWebService/checkLogin";
    
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 发送验证码
+ (void)requestsendVerCodeWithTel:(NSString *)tel AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
     NSDictionary *parameter = @{@"tel":tel};
    NSString * string =@"IcCardWebService/sendVerCode";
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark -  用户注册
+ (void)requestregUserWithTel:(NSString *)tel Code:(NSString *)cood Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
   
    NSDictionary *parameter = @{@"telphone":tel,@"verCode":cood,@"pass":pass};
    NSString * string =@"IcCardWebService/regUserByPhone";
    
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
    
}
#pragma mark - 重置密码
+ (void)requestResetPassWithTel:(NSString *)tel Code:(NSString *)cood Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
  
    NSDictionary *parameter = @{@"tel":tel,@"verCode":cood,@"newPass":pass};
    NSString * string =@"IcCardWebService/resetPass";
    
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 收藏桩
+ (void)requestgaddCollectWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass facId:(NSString *)facId facType:(NSString *)facType AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    
  
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"facId":facId,@"facType":facType};
    NSString * string =@"IcCardWebService/addCollect";
    
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 取消收藏桩
+ (void)requestdeleteColleteWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass facId:(NSString *)facId  AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
     NSString * string =@"IcCardWebService/deleteCollete";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"facId":facId};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
//http://183.129.254.28/webservice/services/IcCardWebService/getMyCollect?identity=1&cardNo=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E
#pragma mark - 读取我收藏的所有的桩信息
+ (void)requestgetMyCollectWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/getMyCollect";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass};
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 开始预约桩
+ (void)requestbespeakPoleWithidentity:(NSString *)iden UID:(NSString *)uid Type:(NSString *)type cardNo:(NSString *)cardNo Pass:(NSString *)pass CardId:(NSString *)cardid phoneNum:(NSString *)phoneNum startTime:(NSString *)startTime lastTime:(NSString *)lastTime AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/bespeakPole";
    NSDictionary *parameter = @{@"identity":iden,@"id":uid ,@"type":type,@"cardNo":cardNo,@"pass":pass,@"cardId":cardid,@"phoneNum":phoneNum,@"startTime":startTime,@"lastTime":lastTime};
    
   [self addLastString:string parameter:parameter AndBack:success failure:failure];
}

#pragma mark - 当前预约
+ (void)requestgetBespeakPoleIdByCardnoWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/getBespeakPole";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass};
    //http://183.129.254.28/webservice/services/IcCardWebService/getBespeakPole?identity=1&cardNo=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 取消预约
+ (void)requestdisBespeakPoleWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  cardId:(NSString *)cardId bespeak_serv_id:(NSString *)idstring AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/disBespeakPole";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"bespeak_serv_id":idstring,@"cardId":cardId};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}

#pragma mark - 查询未支付账单
+ (void)requestqueryCardBillWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/queryCardBill";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 指定站下所有的充电桩
+ (void)requestGetgetPoleByStationId:(NSString *)Pid AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"PoleWebService/getPoleByStationId";
    NSDictionary *parameter = @{@"id":Pid};
   
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
//@"http://183.129.254.28/webservice/services/IcCardWebService/getMyCard?identity=1&cardNo=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E
#pragma mark - 读取用户的充点卡
+ (void)requestGetUserCardWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/getMyCard";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 设置默认卡
+ (void)requesSetDefaultCardnumidentity:(NSString *)identity cardNo:(NSString *)cardNo pass:(NSString *)pass cardId:(NSString *)cardId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/setDefaultCard";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"cardId":cardId};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 取消默认卡
+ (void)requesCancleCardDefaultWithidentity:(NSString *)identity cardNo:(NSString *)cardNo pass:(NSString *)pass cardId:(NSString *)cardId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/cancleCardDefault";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"cardId":cardId};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 消费明细
//@"http://183.129.254.28/webservice/services/IcCardWebService/getConsumRecord?identity=1&cardNo=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E&pageSize=1&index=50&cardId=3050120160821006
+ (void)requestgetConsumRecordWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  cardId:(NSString *)cardId pageSize:(NSString *)pageSize index:(NSString *)index AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/getConsumRecord";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"pageSize":pageSize,@"index":index,@"cardId":cardId};
   
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 充值明细
+ (void)requestgetRechRecordWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  cardId:(NSString *)cardId pageSize:(NSString *)pageSize index:(NSString *)index AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/getRechRecord";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"pageSize":pageSize,@"index":index,@"cardId":cardId};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 获取消息
+ (void)requestGetNewMessageWithIdentify:(NSString *)identity cardNo:(NSString *)cardNo pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/getPushInfo";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 读取我的充电
+(void)requestgetStartChargingPoleidentity:(NSString *)iden cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSDictionary *parameter = @{@"identity":iden,@"cardNo":cardNo,@"pass":pass};
    
    //    @"http://183.129.254.28/webservice/services/IcCardWebService/getStartChargingPole?&identity=1&cardNo=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E
    NSString * string =@"IcCardWebService/getStartChargingPole";
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
    
    
}
#pragma mark - 读取充电zhuang实时信息
+ (void)requestgetRealByPoleIdid:(NSString *)Uid AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSDictionary *parameter = @{@"id":Uid};
    //http://183.129.254.28/webservice/services/PoleWebService/getRealByPoleId?id=304012015070100000000003
    NSString * string =@"PoleWebService/getRealByPoleId";
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
    
}
#pragma mark - 读取未支付订单
+ (void)requestgetqueryCardBillWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/queryCardBill";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass};
    //  http://183.129.254.28/webservice/services/IcCardWebService/queryCardBill?&identity=1&cardNo=13136111092&pass=E10ADC3949BA59ABBE56E057F20F883E
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 关闭充电桩

+ (void)requestClosePoidWithidentity:(NSString *)identity poldId:(NSString *)poldId cardNo:(NSString *)cardNo Pass:(NSString *)pass cardId:(NSString *)cardId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/stopCharging";
    NSDictionary *parameter = @{@"identity":identity,@"cardNo":cardNo,@"pass":pass,@"poleId":poldId,@"cardId":cardId};
    
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}

#pragma mark - 产生订单号
+ (void)requestgenTransNocardId:(NSString *)cardId total_fee:(NSString *)total_fee accName:(NSString *)accName accId:(NSString *)accId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/genTransNo";
//  http://183.129.254.28/webservice/services/IcCardWebService/genTransNo?cardId=3050120160821006&total_fee=0.01&accName=13136111092&accId=13136111092
    NSDictionary *parameter = @{@"cardId":cardId,@"total_fee":total_fee,@"accName":accName,@"accId":accId};
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
   
}
#pragma mark - 通过预约开启充电桩
+(void)requestOpenPoldWithIdentity:(NSString *)identity poleId:(NSString *)poleId cardNo:(NSString *)userNo pass:(NSString *)pass cardId:(NSString *)cardId type:(NSString *)type value:(NSString *)value pwm:(NSString *)pwm bespeak_serv_id:(NSString *)bespeak_serv_id AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/startChargingByBesp";
    
    NSDictionary *parameter = @{@"identity":identity,@"poleId":poleId,@"cardNo":userNo,@"pass":pass,@"cardId":cardId,@"type":type,@"value":value,@"pwm":pwm,@"bespeak_serv_id":bespeak_serv_id};
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 余额支付
+ (void)requestpayChargeRecordidentity:(NSString *)iden billId:(NSString *)billId cardId:(NSString *)cardId payPass:(NSString *)payPass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/payChargeRecord";
    
    NSDictionary *parameter = @{@"identity":iden,@"billId":billId,@"cardId":cardId,@"payPass":payPass};
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
#pragma mark - 扫码充电开启充电桩
+ (void)requestOpenPoleByScanWithIdentity:(NSString *)identity cardNo:(NSString *)userNo pass:(NSString *)pass cardId:(NSString *)cardId poleId:(NSString *)poleId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure{
    NSString * string =@"IcCardWebService/startCharging";
    
    NSDictionary *parameter = @{@"identity":identity,@"poleId":poleId,@"cardNo":userNo,@"pass":pass,@"cardId":cardId,@"type":@"0",@"value":@"0",@"pwm":@"100"};
    [self addLastString:string parameter:parameter AndBack:success failure:failure];
}
@end
