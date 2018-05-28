//
//  CDPoleCell.h
//  CDYL
//
//  Created by admin on 2018/5/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDPoliList.h"

@protocol PoleDelegate <NSObject>
/***点击预约**/
- (void)clickTheBespeakBtn;

@end
@interface CDPoleCell : UITableViewCell
@property (nonatomic, strong) CDPoliList *model;
@property (nonatomic, weak) id <PoleDelegate> delegate;
@end
