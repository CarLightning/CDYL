//
//  CDUserLocation.h
//  CDYL
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CDStation.h"

@interface CDUserLocation : NSObject
@property (nonatomic, assign) CLLocationCoordinate2D  userCoordinate;
@property (nonatomic, strong) NSArray *stationArr;

+(instancetype)share;

@end
