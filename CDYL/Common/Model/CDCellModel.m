//
//  CDCellModel.m
//  CDYL
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDCellModel.h"

@implementation CDCellModel
-(void)setType:(NSUInteger)type{
    _type = type;
}
-(void)setStatus:(NSString *)status{
    if (_type == 1) {
        if ([status isEqualToString:@"1"]) {
            _status = @"在线充值";
        }else{
            _status = @"现场充值";
        }
    }else{
        if ([status isEqualToString:@"1"]) {
            _status = @"已支付";
        }else{
            _status = @"未支付";
        }
    }
}
-(void)setTime:(NSString *)time{
    _time = [self getTime:time];
}
-(void)setMoney:(NSString *)money{
    _money = money;
}

- (NSString *)getTime:(NSString *)old{
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval secs = old.longLongValue/1000;
    NSDate *oldDtate = [NSDate dateWithTimeIntervalSince1970:secs];
    NSString *str = [forma stringFromDate:oldDtate];
    return str;
}







@end
