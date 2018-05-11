//
//  CDShowCell.h
//  CDYL
//
//  Created by admin on 2018/5/11.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDStation.h"
@protocol ShowCellDelegate <NSObject>

/***点击导航按钮***/
-(void)clickTheNavigationButton;
/***点击收藏按钮***/
-(void)clickTheCollectionButton;
@end
@interface CDShowCell : UITableViewCell
@property (nonatomic, strong) CDStation *model;
@property (nonatomic, weak)id < ShowCellDelegate >  delegate;
@end
