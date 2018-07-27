//
//  WaitPayVIew.m
//  CDYL
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "WaitPayVIew.h"

@implementation WaitPayVIew

-(void)setSourceDic:(NSDictionary *)sourceDic{
    _sourceDic = sourceDic;
    NSString *msg = sourceDic [@"billMsg"];
    self.namePole = [self messageArr:msg].lastObject;
    self.frontPole = [self messageArr:msg].firstObject;
 
    //开始时间
    NSString *start = [NSString stringWithFormat:@"%@",sourceDic[@"startTime"]];
    self.startTime.text = [self getTime:start];
    //结束时间
    NSString *end = [NSString stringWithFormat:@"%@",sourceDic[@"finishTime"]];
    self.endTime.text = [self getTime:end];
    //总时间
    self.allTime.text = [self allTimeWithStart:start end:end];
    //总共充电
    self.allPower.text = [NSString stringWithFormat:@"%@度",sourceDic[@"kwh"]];
    
    //总共金额
    self.money.text = [NSString stringWithFormat:@"%@元",sourceDic[@"cost"]];
}

-(NSArray *)messageArr:(NSString *)str{
//    NSString * msgStr = [str componentsSeparatedByString:@","][1];
//    NSString *firstObj = [msgStr componentsSeparatedByString:@" "][0];
//    firstObj = [firstObj stringByReplacingOccurrencesOfString:@"在" withString:@""];
//    NSString *secObj = [msgStr componentsSeparatedByString:@" "][1];
//    secObj = [secObj componentsSeparatedByString:@"#"].firstObject;
//    secObj = [NSString stringWithFormat:@"%@#充电桩",secObj];
//    return @[firstObj,secObj];
    return nil;
}
- (NSString *)getTime:(NSString *)str{
    NSTimeInterval newTime = str.longLongValue/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:newTime];
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *string = [forma stringFromDate:date];
    
    return string;
}
-(NSString *)allTimeWithStart:(NSString *)start end:(NSString *)end{
    NSTimeInterval startTime =  start.longLongValue/1000;
    NSTimeInterval endTime = end.longLongValue/1000;
    int allTime = endTime-startTime;
    int all = allTime /60;
    int last = allTime %60;
    if (last>1) {
        all= all+1;
    }
    
    
    return [NSString stringWithFormat:@"%d分钟",all];
}
-(NSArray *)locationStr:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@":"];
    
    
    return arr;
}

@end
