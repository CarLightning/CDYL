//
//  CDRowCell.h
//  CDYL
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  rowCellDelagate <NSObject>
- (void)changeTheSearchValue:(NSString *)index;
@end
@interface CDRowCell : UITableViewCell
@property (nonatomic, weak) id <rowCellDelagate>  delagate;
@property (nonatomic, assign) CGFloat  status;
@end
