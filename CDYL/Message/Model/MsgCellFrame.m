//
//  MsgCellFrame.m
//  CDYL
//
//  Created by admin on 2018/6/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "MsgCellFrame.h"
#import <YYText.h>

@interface MsgCellFrame()
/** 时间frame */
@property (nonatomic, assign) CGRect  timeFrame;
/** 内容frame */
@property (nonatomic, assign) CGRect  textLBFrame;
/** 提示frame */
@property (nonatomic, assign) CGRect  noticeFrame;
/** 背景frame */
@property (nonatomic, assign) CGRect  bgIvFrame;
/** 头像frame */
@property (nonatomic, assign) CGRect  headViewFrame;
/** height 这里只是 整个话题占据的高度 */
@property (nonatomic , assign ) CGFloat height;
@end
@implementation MsgCellFrame
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)setModel:(UserMessage *)model{
    _model = model;
    /**  竖着方向间隙 */
    CGFloat const CDBlockBW = 10.0f ;
   
    /**  水平方向间隙 */
    
    CGFloat const CDBlockSH = 10.0f;
     CGFloat const CDBlockMH = 15.0f;
    // 时间
    CGFloat createX = DEAppWidth/2-50;
    CGFloat createY = CDBlockBW;
    CGFloat createW = 100;
    CGFloat createH = 20;
    self.timeFrame = CGRectMake(createX, createY, createW, createH);
    
    // 提醒
    CGFloat noticeX = 55+CDBlockMH;
    CGFloat noticeY = CDBlockBW+20+CDBlockBW+5;
    CGFloat noticeW = 100;
    CGFloat noticeH = 0.0001;
    self.noticeFrame = CGRectMake(noticeX, noticeY-5, noticeW, noticeH);
    
    // 内容
    CGFloat textX = CGRectGetMinX(self.noticeFrame);
    CGFloat textY = CGRectGetMaxY(self.noticeFrame)+10;
    CGFloat textW = DEAppWidth - 105;
    CGSize textLimitSize = CGSizeMake(textW, MAXFLOAT);
    CGFloat textH =[YYTextLayout layoutWithContainerSize:textLimitSize text:model.attributedText].textBoundingSize.height;
    
    
    self.textLBFrame = CGRectMake(textX, textY, textW, textH);
    
    // 背景
    CGFloat bgIvX = 55;
    CGFloat bgIvY = CDBlockBW+20+CDBlockBW;
    CGFloat bgIvW = textW+30;
    CGFloat bgIvH = textH+20+noticeH;
    self.bgIvFrame = CGRectMake(bgIvX, bgIvY, bgIvW, bgIvH);
    
    // 头像
    CGFloat headViewX = CDBlockSH;
    CGFloat headViewY = CGRectGetMaxY(self.bgIvFrame)-35;
    CGFloat headViewW = 35;
    CGFloat headViewH = 35;
    self.headViewFrame = CGRectMake(headViewX, headViewY, headViewW, headViewH);
    self.height = CGRectGetMaxY(self.bgIvFrame)+10;
    
    
}
@end
