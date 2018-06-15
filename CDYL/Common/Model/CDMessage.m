//
//  CDMessage.m
//  CDYL
//
//  Created by admin on 2018/6/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDMessage.h"
#import "CDBaseSqlite.h"
#import "CDUserInfor.h"
#import "UserMessage.h"
#import "MsgCellFrame.h"
@implementation CDMessage
{
    NSTimer *_timer;
}
static CDMessage *shareMessage = nil;

+(instancetype)shareMessage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareMessage = [[CDMessage alloc]initStartReceiveMeaage];
       
    });
    return shareMessage;
}


#pragma mark - 启动后台刷新
- (instancetype)initStartReceiveMeaage{
    self = [super init];
    if (self) {
        [self creatTable];
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(getNewMessage) userInfo:nil repeats:YES];
        [_timer fire];
    }
    return self;
}
- (void)creatTable{
    
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_USER_TABLE,TABLE_NAME];
    [[CDBaseSqlite shareSqlite]createTable:TABLE_NAME withSQL:sqlString];
}
- (void)getNewMessage{
   
    [CDWebRequest requestGetNewMessageWithIdentify:@"1" cardNo:[CDUserInfor shareUserInfor].phoneNum pass:[CDUserInfor shareUserInfor].userPword AndBack:^(NSDictionary *backDic) {
        NSArray *arr = [backDic objectForKey:@"list"];
        if (arr.count>0) {
            NSDictionary *dic = arr.firstObject;
            NSString *cardNo = [dic objectForKey:@"cardno"];
            NSString *info = [dic objectForKey:@"info"];
             NSString *uid = [CDUserInfor shareUserInfor].phoneNum;
            NSString *msg_time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]];
            
            NSDictionary *dicParameter = @{@"phoneNum":uid,@"cardNo":cardNo,@"msg_time":msg_time,@"info":info};
            NSString *sqlString = [NSString stringWithFormat:SQL_iNSERT_CONV,TABLE_NAME];
            BOOL ok = [[CDBaseSqlite shareSqlite]excuteSQL:sqlString withDicParameter:dicParameter];
            if (ok) {
                NSLog(@"插入数据成功");
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"CHANGENOTIFITY" object:nil];
                
            }else{
                NSLog(@"插入数据失败");
            }
        }else{
           
        }
       
        
    } failure:^(NSString *err) {
        NSLog(@"消息:%@",err);
    }];
}
#pragma mark - 删除所有消息
- (void)deleteAllMessage{
 
    NSString *sqlString = [NSString stringWithFormat:@"delete from %@ ",TABLE_NAME];
    BOOL ok = [[CDBaseSqlite shareSqlite]excuteSQL:sqlString];
    if (ok) {
        NSLog(@"消息表删除成功");
       
    }
}
#pragma mark - 从数据库拿到所有消息
-(NSMutableArray *)getAllMessages{
    NSMutableArray *arr = [NSMutableArray array];
    

    NSString *sqlString = [NSString stringWithFormat:@"select * from %@",TABLE_NAME];
    [[CDBaseSqlite shareSqlite]excuteQuerySQL:sqlString resultBlock:^(FMResultSet *reSet) {
        
        while ([reSet next]) {
            MsgCellFrame *cellFrame = [[MsgCellFrame alloc]init];
            UserMessage *model = [[UserMessage alloc]init];
            model.uid =  [reSet stringForColumn:@"phoneNum"];
            model.cardNo  = [reSet stringForColumn:@"cardNo"];
            model.msg_time  =  [reSet stringForColumn:@"msg_time"];
            model.info  = [reSet stringForColumn:@"info"];
            cellFrame.model = model;
            [arr insertObject:cellFrame atIndex:0];
        }}];
    
    return arr;
}

//暂停Timer
- (void)pastTimer
{
    [_timer setFireDate:[NSDate distantPast]];
}
//从启timer
- (void)futureTimer
{
    [_timer setFireDate:[NSDate distantFuture]];
}
@end
