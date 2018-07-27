//
//  CDBespeakView.h
//  CDYL
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDBespeakModel.h"
@protocol BespeakViewDelagate <NSObject>

- (void)userDidClickTheBtn:(UIButton *)btn CDBespeakModel:(CDBespeakModel *)model;
@end

@interface CDBespeakView : UIView
@property (nonatomic, weak) id <BespeakViewDelagate> delagate;
@property (nonatomic, strong) CDBespeakModel *model;

@end
