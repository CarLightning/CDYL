//
//  CDSetOneCell.h
//  CDYL
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol setOneCellDelagate <NSObject>

- (void)didTheSwitchBtn:(UISwitch *)sw;


@end
@interface CDSetOneCell : UITableViewCell
@property (nonatomic, weak) id <setOneCellDelagate> delagate;
-(void)showName:(NSString *)name;
@end
