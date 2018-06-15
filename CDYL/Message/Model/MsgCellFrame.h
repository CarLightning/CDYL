//
//  MsgCellFrame.h
//  CDYL
//
//  Created by admin on 2018/6/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserMessage.h"

@interface MsgCellFrame : NSObject
/** 时间frame */
@property (nonatomic, assign,readonly) CGRect  timeFrame;
/** 内容frame */
@property (nonatomic, assign,readonly) CGRect  textLBFrame;
/** 提示frame */
@property (nonatomic, assign,readonly) CGRect  noticeFrame;
/** 背景frame */
@property (nonatomic, assign,readonly) CGRect  bgIvFrame;
/** 头像frame */
@property (nonatomic, assign,readonly) CGRect  headViewFrame;
/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign , readonly) CGFloat height;

@property (nonatomic, strong) UserMessage *model;
@end
