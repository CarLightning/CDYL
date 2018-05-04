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


+ (BOOL)isValidateEmail:(NSString *)email;
@end
