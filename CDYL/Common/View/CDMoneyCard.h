//
//  CDMoneyCard.h
//  CDYL
//
//  Created by admin on 2018/5/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDMoneyCardInfor.h"

@protocol MoneyCardDelegate <NSObject>

- (void)clickTheMoneyCard:(CDMoneyCardInfor *)model;
- (void)clickTheDefaultButton:(CDMoneyCardInfor *)model;

@end

@interface CDMoneyCard : UIView

@property (nonatomic, strong) CDMoneyCardInfor *model;
@property (nonatomic, weak) id <MoneyCardDelegate> delegate;

@end
