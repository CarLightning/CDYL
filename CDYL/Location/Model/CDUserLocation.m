//
//  CDUserLocation.m
//  CDYL
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDUserLocation.h"

@interface CDUserLocation () 

@end
@implementation CDUserLocation
static CDUserLocation * _userInfor;

+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_userInfor == nil) {
            _userInfor = [[CDUserLocation alloc]init];
        }
    });
    return _userInfor;
}

@end
