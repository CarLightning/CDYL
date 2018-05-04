//
//  CDPointAnnotation.h
//  CDYL
//
//  Created by admin on 2018/4/9.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CDStation.h"

@interface CDPointAnnotation : MAPointAnnotation

@property (nonatomic, strong) CDStation *stationModel;

@end
