//
//  CDBespeakTableViewCell.h
//  CDYL
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDBespeakTableViewCell : UITableViewCell
@property (nonatomic, assign) CGFloat  status;
- (void)reloadCellWithRow:(NSUInteger)row arr:(NSArray *)arr;
@end
