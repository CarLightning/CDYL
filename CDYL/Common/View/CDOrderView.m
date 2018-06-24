//
//  CDOrderView.m
//  CDYL
//
//  Created by admin on 2018/6/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDOrderView.h"

@implementation CDOrderView

-(void)setSourceDic:(NSDictionary *)sourceDic{
    _sourceDic = sourceDic;
    NSString *deductState = [NSString stringWithFormat:@"%@",sourceDic[@"deductState"]];
     self.statusLb.text = @"已支付";
    if ([deductState isEqualToString:@"2"]) {
        self.statusLb.text = @"未支付";
    }
    NSArray *arr = [self locationStr:sourceDic[@"poleId"]];
    self.namePole.text = arr.lastObject;
    self.frontPole.text = arr.firstObject;
//开始时间
    NSString *start = [NSString stringWithFormat:@"%@",sourceDic[@"chStartDate"]];
    self.startTime.text = [self getTime:start];
//结束时间
     NSString *end = [NSString stringWithFormat:@"%@",sourceDic[@"chEndDate"]];
   self.endTime.text = [self getTime:end];
//总时间
    self.allTime.text = [self allTimeWithStart:start end:end];
 //总共充电
    self.allPower.text = [NSString stringWithFormat:@"%@度",sourceDic[@"kwh"]];
    
  //总共金额
    self.money.text = [NSString stringWithFormat:@"%@元",sourceDic[@"amount"]];
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
