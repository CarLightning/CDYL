//
//  CDMessage.h
//  CDYL
//
//  Created by admin on 2018/6/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBaseSqlite.h"

@interface CDMessage : NSObject




+(instancetype)shareMessage;

//创建表
- (void)creatTable;
//刷新数据库
- (void)getNewMessage;
//从数据库拿到所有消息
- (NSMutableArray *)getAllMessages;
//删除数据库
- (void) deleteAllMessage;
//暂停Timer
- (void)pastTimer;
//从启timer
- (void)futureTimer;
@end
