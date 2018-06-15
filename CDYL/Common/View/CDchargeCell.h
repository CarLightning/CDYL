//
//  CDchargeCell.h
//  CDYL
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDchargeCell : UITableViewCell
@property (nonatomic, assign) NSUInteger  type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *money;
@end
