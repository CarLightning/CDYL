//
//  CDPayCell.h
//  CDYL
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDPayCell : UITableViewCell
@property (nonatomic, assign) BOOL Is_select;

- (void)reloadCellWith:(NSString *)name rowIndex:(NSUInteger)index;
- (void)selectBgShow:(BOOL)showSelectBg;
@end
