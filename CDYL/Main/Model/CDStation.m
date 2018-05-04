//
//  CDStation.m
//  CDYL
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDStation.h"
#import "CDPoliList.h"
@implementation CDStation

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"pid":@"id"}];
}

-(NSString<Ignore> *)canOrder{
    if (self.polelist && self.polelist.count > 0) {
        for (NSDictionary *model in self.polelist) {
            @autoreleasepool {
                NSString *state=[NSString stringWithFormat:@"%@",model[@"status"]];
                if ([state isEqualToString:@"5"]) {
                    return @"can";
                    break;
                }
            }
        }
        
    }
    return @"nocan";
}
-(NSString *)distance{
    if (_distance) {
        CGFloat distan = _distance.floatValue;
        NSString *newDis = [NSString stringWithFormat:@"%.2fkm",distan];
        return newDis;
    }
    return nil;
    
}
@end
