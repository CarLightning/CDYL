//
//  CDBgVIew.h
//  CDYL
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CDBgVIewDelagate <NSObject>
- (void)clickTheConsumeRecordBtn;
- (void)clickTheRechargeRecordBtn;
@end

@interface CDBgVIew : UIView
@property (nonatomic, weak) id<CDBgVIewDelagate>  delagate;
- (void)hiddenTheAlert;
- (void)showTheAlert;
@end
