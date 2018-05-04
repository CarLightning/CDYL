//
//  NSFileManager+CDFilePath.m
//  CDYL
//
//  Created by admin on 2018/4/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "NSFileManager+CDFilePath.h"

@implementation NSFileManager (CDFilePath)
-(NSString *)userAccountPath:(BOOL)is_creat{
    
    NSString *string = [self documentPath];
    NSString *director = [string stringByAppendingPathComponent:@"UserInforFile"];
    NSString * path = [director stringByAppendingPathComponent:@"infor.data"];
    if (is_creat) {
        
        BOOL createFileOK = [[NSFileManager defaultManager]fileExistsAtPath:director];
        if (!createFileOK) {
            
            //创建文件夹
            [[NSFileManager defaultManager]createDirectoryAtPath:director withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //创建文件
        [[NSFileManager defaultManager]createFileAtPath:path contents:nil attributes:nil];
    }
    
    
    
    
    return path;
}
-(NSString *)headImagePath:(BOOL)is_creat{
    
    NSString *string = [self documentPath];
    NSString *director = [string stringByAppendingPathComponent:@"UserInforFile"];
    NSString * path = [director stringByAppendingPathComponent:@"headImage.png"];
    if (is_creat) {
        
        BOOL createFileOK = [[NSFileManager defaultManager]fileExistsAtPath:director];
        if (!createFileOK) {
            
            //创建文件夹
            [[NSFileManager defaultManager]createDirectoryAtPath:director withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //创建文件
        [[NSFileManager defaultManager]createFileAtPath:path contents:nil attributes:nil];
    }
    
   
    return path;
}

-(NSString *)documentPath{
    NSString *document =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return document;
}
-(NSString *)libraryPath{
    NSString *library =NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    return library;
}
-(NSString *)NSCachesPath{
    
    NSString *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return caches;
}
@end
