//
//  CDAFNetLine.h
//  CDYL
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDAFNetLine : NSObject

typedef void(^SuccessedData)(id data);
typedef void(^FailureMessage)(NSError * error);

+(instancetype)shareManager;

-(void)Get:(NSString *)urlString Parameter:(NSDictionary *)parameter XMLString:(NSString *)str success:(SuccessedData)success failure:(FailureMessage)failure;
-(void)Post:(NSString *)urlString Parameter:(NSDictionary *)parameter XMLString:(NSString *)str success:(SuccessedData)success failure:(FailureMessage)failure;
@end
