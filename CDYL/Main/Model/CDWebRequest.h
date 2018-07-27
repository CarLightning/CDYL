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
+ (void)requestsearchChargePoleWithlat:(NSString *)lat lon:(NSString *)lon radius:(NSString *)radius type:(NSString *)type status:(NSString *)status startTime:(NSString *)startTime endTime:(NSString *)endTime regId:(NSString *)regId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//查询可预约充电站
+ (void)requestsearchCanBespeakChargePoleWithlat:(NSString *)lat lon:(NSString *)lon radius:(NSString *)radius type:(NSString *)type status:(NSString *)status startTime:(NSString *)startTime endTime:(NSString *)endTime regId:(NSString *)regId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//登录
+ (void)loginWithName:(NSString *)name PassWord:(NSString *)pWord AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//发验证码
+ (void)requestsendVerCodeWithTel:(NSString *)tel AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;

// 用户注册
+ (void)requestregUserWithTel:(NSString *)tel Code:(NSString *)cood Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//重置密码
+ (void)requestResetPassWithTel:(NSString *)tel Code:(NSString *)cood Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//收藏 facType设施类型1是站，2是桩
+ (void)requestgaddCollectWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass facId:(NSString *)facId facType:(NSString *)facType AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//取消收藏桩
+ (void)requestdeleteColleteWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass facId:(NSString *)facId  AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//读取我收藏的所有的桩信息
+ (void)requestgetMyCollectWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//指定站下所有的充电桩
+ (void)requestGetgetPoleByStationId:(NSString *)Pid AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//开始预约桩
+ (void)requestbespeakPoleWithidentity:(NSString *)iden UID:(NSString *)uid Type:(NSString *)type cardNo:(NSString *)cardNo Pass:(NSString *)pass CardId:(NSString *)cardid phoneNum:(NSString *)phoneNum startTime:(NSString *)startTime lastTime:(NSString *)lastTime AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;

//当前预约
+ (void)requestgetBespeakPoleIdByCardnoWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//取消预约
+ (void)requestdisBespeakPoleWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  cardId:(NSString *)cardId bespeak_serv_id:(NSString *)idstring AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;

//查询未支付账单
+ (void)requestqueryCardBillWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//读取用户的充zhi卡
+ (void)requestGetUserCardWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//设置默认卡
+ (void)requesSetDefaultCardnumidentity:(NSString *)identity cardNo:(NSString *)cardNo pass:(NSString *)pass cardId:(NSString *)cardId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//取消默认卡
+ (void)requesCancleCardDefaultWithidentity:(NSString *)identity cardNo:(NSString *)cardNo pass:(NSString *)pass cardId:(NSString *)cardId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//消费明细
+ (void)requestgetConsumRecordWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  cardId:(NSString *)cardId pageSize:(NSString *)pageSize index:(NSString *)index AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//充值明细
+ (void)requestgetRechRecordWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass  cardId:(NSString *)cardId pageSize:(NSString *)pageSize index:(NSString *)index AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//获取消息
+ (void)requestGetNewMessageWithIdentify:(NSString *)identity cardNo:(NSString *)cardNo pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;

//读取我的充电
+(void)requestgetStartChargingPoleidentity:(NSString *)iden cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//读取充电实时信息
+ (void)requestgetRealByPoleIdid:(NSString *)Uid AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//读取未支付订单
+ (void)requestgetqueryCardBillWithidentity:(NSString *)identity cardNo:(NSString *)cardNo Pass:(NSString *)pass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//关闭充电桩
+ (void)requestClosePoidWithidentity:(NSString *)identity poldId:(NSString *)poldId cardNo:(NSString *)cardNo Pass:(NSString *)pass cardId:(NSString *)cardId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//产生订单编号
+ (void)requestgenTransNocardId:(NSString *)cardId total_fee:(NSString *)total_fee accName:(NSString *)accName accId:(NSString *)accId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//通过预约开启充电桩
+ (void)requestOpenPoldWithIdentity:(NSString *)identity poleId:(NSString *)poleId cardNo:(NSString *)userNo pass:(NSString *)pass cardId:(NSString *)cardId type:(NSString *)type value:(NSString *)value pwm:(NSString *)pwm bespeak_serv_id:(NSString *)bespeak_serv_id AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//余额支付
+ (void)requestpayChargeRecordidentity:(NSString *)iden billId:(NSString *)billId cardId:(NSString *)cardId payPass:(NSString *)payPass AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
//扫码充电开启充电桩
+ (void)requestOpenPoleByScanWithIdentity:(NSString *)identity cardNo:(NSString *)userNo pass:(NSString *)pass cardId:(NSString *)cardId poleId:(NSString *)poleId AndBack:(void (^)(NSDictionary * backDic))success failure:(void (^)(NSString * err))failure;
@end
