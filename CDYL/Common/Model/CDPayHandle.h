//
//  CDPayHandle.h
//  CDYL
//
//  Created by admin on 2018/6/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDPayHandle : NSObject

+ (void)WXPayWithMoney:(NSString *)payMoney;

+ (void)AliPayWithMoney:(NSString *)money outTradeNO:(NSString *)outTradeNO;
@end
