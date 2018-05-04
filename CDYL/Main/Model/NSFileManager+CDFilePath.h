//
//  NSFileManager+CDFilePath.h
//  CDYL
//
//  Created by admin on 2018/4/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CDFilePath)
-(NSString *)headImagePath:(BOOL)is_creat;
-(NSString *)userAccountPath:(BOOL)is_creat;;

@end
