//
//  CDPayView.h
//  CDYL
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDMoneyCardInfor.h"

@interface CDPayView : UIView
@property (nonatomic, strong) CDMoneyCardInfor *model;
@property (nonatomic, strong,readonly) UITextField *textFiled;
@end
