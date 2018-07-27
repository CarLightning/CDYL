//
//  CDPayHandle.m
//  CDYL
//
//  Created by admin on 2018/6/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDPayHandle.h"
#import <AFNetworking.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
@implementation CDPayHandle
#pragma mark - 微信支付
+ (void)WXPayWithMoney:(NSString *)payMoney{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //http://www.evnetworks.cn:8088/wechat/pay/app/getorder
    NSString *string =  @"https://www.evnetworks.cn/wechat/pay/app/getorder";
    NSDictionary * parameter = @{@"total_fee":payMoney};
    
    [manager GET:string parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *sourceDic = [NSJSONSerialization JSONObjectWithData:responseObject options:1 error:nil];
        
//        NSLog(@"%@",sourceDic);
        NSDictionary *dataDic = [sourceDic objectForKey:@"data"];
        NSDictionary *dic = [dataDic objectForKey:@"args"];
        
        // 发起微信支付，设置参数
        PayReq *request = [[PayReq alloc] init];
        request.openID = [dic objectForKey:@"appid"];
        request.partnerId = [dic objectForKey:@"partnerid"];
        request.prepayId= [dic objectForKey:@"prepayid"];
        request.package = [dic objectForKey:@"package"];
        request.nonceStr= [dic objectForKey:@"noncestr"];
        // 将当前时间转化成时间戳
        NSDate *datenow = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
        UInt32 timeStamp =[timeSp intValue];
        
        request.timeStamp= timeStamp;
        
        
        
        request.sign= [dic objectForKey:@"paySign"];
        
        
        // 调用微信
        [WXApi sendReq:request];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 支付宝支付
+ (void)AliPayWithMoney:(NSString *)money outTradeNO:(NSString *)outTradeNO{
    NSString *string = @"https://www.evnetworks.cn/ali/pay/app/getsign";
  
 
    NSDictionary *paramater = @{@"subject":@"1",@"total_amount":money,@"product_code":@"QUICK_MSECURITY_PAY",@"outTradeNO":outTradeNO,@"notify_url":@"http://183.129.254.28/webservice/recharge!notifyURL.action"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置允许接收返回数据类型： 加上@"application/xml"
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"application/xml",nil ];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:string parameters:paramater progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data = [dic objectForKey:@"data"];
        NSString *orderStr = [data objectForKey:@"last"];
        
//        NSData *JSONData = [orderStr dataUsingEncoding:NSUTF8StringEncoding];
//
//        NSString *sth = [[NSString alloc]initWithData:JSONData encoding:NSUTF8StringEncoding];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self payOrder:orderStr fromScheme:@"alisdkdemo"];
        });
        NSLog(@"%@",orderStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
+ (void)payOrder:(NSString *)orderString fromScheme:(NSString *)appScheme{
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic){
        
        
        NSLog(@"reslut = %@",resultDic);
    }];
}

+ (NSString*)encodeValue:(NSString*)value
{
    NSString* encodedValue = value;
    if (value.length > 0) {
        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]invertedSet];
        encodedValue = [value stringByAddingPercentEncodingWithAllowedCharacters:charset];
    }
    return encodedValue;
}

@end
