//
//  CDPoliList.m
//  CDYL
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 admin. All rights reserved.
// 


#import "CDPoliList.h"

@implementation CDPoliList
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"uid":@"id"}];
}
@end
