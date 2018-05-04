//
//  AliMapViewCustomCalloutView.h
//  AliMapKit
//
//  Created by 夏远全 on 16/12/12.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//  自定义气泡

#import <UIKit/UIKit.h>
#import "CDStation.h"

@class AliMapViewCustomCalloutView;

@protocol CallViewDelegate <NSObject>

/** 点击蓝体字事件回调 */
- (void)stationModel:(CDStation *)model didTouchHightLightLabel:(BOOL)touch;
/** 点击收藏的事件回调 */
- (void)stationModel:(CDStation *)model didCollection:(BOOL)collection;
/** 点击导航的事件回调 */
- (void)stationModel:(CDStation *)model didNavigationBtn:(BOOL)naviagtion;
/** 点击预约的事件回调 */
- (void)stationModel:(CDStation *)model didAppointmentBtn:(BOOL)appointment;
@end




@interface AliMapViewCustomCalloutView : UIView

@property (nonatomic, strong) CDStation *stationModel;

@property (nonatomic, weak) id <CallViewDelegate> delegate;
@end
