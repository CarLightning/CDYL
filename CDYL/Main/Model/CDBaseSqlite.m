//
//  CDBaseSqlite.m
//  CDYL
//
//  Created by admin on 2018/6/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBaseSqlite.h"

@implementation CDBaseSqlite
static CDBaseSqlite *shareManager = nil;

+(CDBaseSqlite *)shareSqlite{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[CDBaseSqlite alloc]initWithUserId:0];
    });
    return shareManager;
}
-(id)init{
    return nil;
}
-(instancetype)initWithUserId:(NSInteger)uid{
    self = [super init];
    if (self) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [[documentPath stringByAppendingPathComponent:@"FMDBInfor"] stringByAppendingPathComponent:@"data"];
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL is_exist = [manager fileExistsAtPath:path];
        if (!is_exist) {
            BOOL creat_ok = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            if (creat_ok) {
                NSLog(@"创建成功");
            }else{
                NSLog(@"创建Path失败");
            }
        }
        path = [path stringByAppendingPathComponent:@"sql.db"];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        NSLog(@"\n消息数据库：%@",path);
        
        
        
    }
    return self;
    
}

- (void)createTable:(NSString*)tableName withSQL:(NSString*)sqlString{
    
    __block BOOL ok = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        if (![db tableExists:tableName]) {
            ok = [db executeUpdate:sqlString withArgumentsInArray:nil];
            if ([db hadError]) {
                NSLog(@"executeSQLList Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            }
        }
    }];
    //    return ok;
}

-(BOOL)excuteSQL:(NSString*)sqlString withArrParameter:(NSArray*)arrParameter{
    
    __block BOOL ok = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withArgumentsInArray:arrParameter];
        }];
    }
    return ok;
}


-(BOOL)excuteSQL:(NSString*)sqlString withDicParameter:(NSDictionary*)dicParameter{
    
    __block BOOL ok = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withParameterDictionary:dicParameter];
        }];
    }
    return ok;
}
- (BOOL)excuteSQL:(NSString *)sqlString,...{
    
    __block BOOL ok = NO;
    if (self.dbQueue) {
        va_list args;
        va_list *p_args;
        p_args = &args;
        va_start(args, sqlString);
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withVAList:*p_args];
        }];
        va_end(args);
    }
    return ok;
}


- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void(^)(FMResultSet * reSet))resultBlock{
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *retSet = [db executeQuery:sqlStr];
            if (resultBlock) {
                resultBlock (retSet);
            }
        }];
    }
}
@end;
