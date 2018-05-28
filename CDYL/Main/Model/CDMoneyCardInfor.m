//
//  CDMoneyCardInfor.m
//  CDYL
//
//  Created by admin on 2018/5/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDMoneyCardInfor.h"

@implementation CDMoneyCardInfor

-(NSString *)haveMoney{
    if (_haveMoney) {
        float money = _haveMoney.floatValue;
        NSString *hmoney = [NSString stringWithFormat:@"%.2f",money];
        return hmoney;
    }
    return nil;
}
@end
