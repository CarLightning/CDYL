//
//  CDMessageCell.h
//  CDYL
//
//  Created by admin on 2018/6/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgCellFrame.h"

@protocol MsgCellDelegate <NSObject>
- (void)tapZoomTheMessage:(NSString *)msg;
@end

@interface CDMessageCell : UITableViewCell
@property (nonatomic, strong) MsgCellFrame *frameModel;
@property (nonatomic, weak) id <MsgCellDelegate>  delegate;
@end
