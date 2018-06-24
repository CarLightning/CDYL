//
//  CDOrderView.h
//  CDYL
//
//  Created by admin on 2018/6/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDOrderView : UIView
/*** 已支付、未支付***/
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
/*** 桩名称***/
@property (weak, nonatomic) IBOutlet UILabel *namePole;
/*** 桩位置***/
@property (weak, nonatomic) IBOutlet UILabel *frontPole;
/*** 开始时间***/
@property (weak, nonatomic) IBOutlet UILabel *startTime;
/*** 结束时间***/
@property (weak, nonatomic) IBOutlet UILabel *endTime;
/*** 总共用时***/
@property (weak, nonatomic) IBOutlet UILabel *allTime;
/*** 总共充电***/
@property (weak, nonatomic) IBOutlet UILabel *allPower;
/*** 总金额***/
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (nonatomic, strong) NSDictionary *sourceDic;
@end
