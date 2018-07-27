//
//  CDXML.h
//  CDYL
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDXML : NSObject
+ (NSDictionary *)requestFromString:(NSString *)dataStr AndUseString:(NSString *)string;
+(NSString *)md5:(NSString*)input;
+ (BOOL)CheckIsIdentityCard:(NSString *)identityCard;
+ (BOOL)phoneNumberIsTrue:(NSString *)phoneNumber;
// 显示缓存大小
+ ( float )filePath;
//判断推送是否打开
+ (BOOL)isUserNotificationEnable;
//跳转设置页面
+ (void)goToAppSystemSetting;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)isLogin;
@end
