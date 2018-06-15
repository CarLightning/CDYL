//
//  UserMessage.m
//  CDYL
//
//  Created by admin on 2018/6/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UserMessage.h"
#import <YYText.h>

@implementation UserMessage
-(void)setMsg_time:(NSString *)msg_time{
    NSTimeInterval time  = msg_time.longLongValue/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"MM-dd HH:mm"];
    NSString *newTime = [forma stringFromDate:date];
    if ([newTime hasPrefix:@"0"]) {
        newTime = [newTime substringFromIndex:1];
    }
    
    _msg_time = newTime;
}
#pragma mark - 公共方法
-(NSAttributedString *)attributedText{
    /** 文本行高 */
    CGFloat const  MHCommentContentLineSpacing = 10.0f;
    
    if (self.info==nil)
        return nil;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.info];
    attributeString.yy_lineSpacing = 0;
    attributeString.yy_font = [UIFont fontWithName:@"PingFangSC-Light" size:12.0f];
    attributeString.yy_color = LHColor(34, 34, 34);
    attributeString.yy_lineSpacing = MHCommentContentLineSpacing;
    return attributeString;
    
}
@end
