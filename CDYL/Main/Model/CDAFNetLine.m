//
//  CDAFNetLine.m
//  CDYL
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDAFNetLine.h"
#import <AFNetworking.h>
#import "CDXML.h"

@implementation CDAFNetLine
 static AFHTTPSessionManager *manager;
+(instancetype)shareManager{
   
    static CDAFNetLine *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (helper == nil) {
            helper = [[CDAFNetLine alloc]init];
            manager = [AFHTTPSessionManager manager];

            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            manager.requestSerializer.timeoutInterval = 20;
            
            //  设置允许接收返回数据类型： 加上@"application/xml"
            manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"application/xml",nil];
        }
    });
    return helper;
}
-(void)Get:(NSString *)urlString Parameter:(NSDictionary *)parameter XMLString:(NSString *)xmlStr success:(SuccessedData)success failure:(FailureMessage)failure{
    [manager GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [CDXML requestFromString:str AndUseString:xmlStr];
        
        NSString *is_ok = [NSString stringWithFormat:@"%@",dic[@"success"]];
        NSString *messa =[NSString stringWithFormat:@"%@",dic[@"message"]];
        
        if ([is_ok isEqualToString:@"1"]) {
            success (dic);
        }else{
            failure (messa);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure (@"网络错误");
    }];
}

- (void)Post:(NSString *)urlString Parameter:(NSDictionary *)parameter XMLString:(NSString *)xmlStr success:(SuccessedData)success failure:(FailureMessage)failure{
    
    [manager POST:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [CDXML requestFromString:str AndUseString:xmlStr];
        
        NSString *is_ok = [NSString stringWithFormat:@"%@",dic[@"success"]];
        NSString *messa =[NSString stringWithFormat:@"%@",dic[@"message"]];
        
        if ([is_ok isEqualToString:@"1"]) {
        success (dic);
        }else{
            failure (messa);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure (@"网络错误");
    }];
}
@end
