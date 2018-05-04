//
//  CDUserInforMation.m
//  CDYL
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDUserInfor.h"
@interface CDUserInfor()

@end
@implementation CDUserInfor

static CDUserInfor * _userInfor;

+(instancetype)shareUserInfor{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_userInfor) {
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:LHAccountPath];
            NSLog(@"数据库：%@",LHAccountPath);
            if (dic) { // 登陆过
                _userInfor = [[CDUserInfor alloc]initWithDictionary:dic error:nil];
            }else{
                _userInfor = [[CDUserInfor alloc]init];
                NSLog(@"第一次登陆");
            }
        }
    });
    
    return _userInfor;
}


- (void)updateInforWithAll:(BOOL)all_update{
    __block typeof(self)weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (all_update) {
            
            
            [CDWebRequest loginWithName:self.phoneNum PassWord:self.userPword AndBack:^(NSDictionary *backDic) {
                NSString *is_ok = [NSString stringWithFormat:@"%@",backDic[@"success"]];
                if ([is_ok isEqualToString:@"1"]) {
                    // 1、写入邮箱和idcard信息
                    NSDictionary *cardDic =backDic[@"cardinfo"];
                    weakself.idCardNum = [NSString stringWithFormat:@"%@",cardDic[@"idcard"]];
                    weakself.Email = [NSString stringWithFormat:@"%@",cardDic[@"email"]];
                    //2、获取默认卡
                    NSArray *cardArr =backDic[@"list"] ;
                    
                    cardArr =  [cardArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        
                        NSDictionary *dic1 = obj1;
                        NSDictionary *dic2 = obj2;
                        NSString *haveMoney1 = [NSString stringWithFormat:@"%@",dic1[@"haveMoney"]];
                        NSString *haveMoney2 = [NSString stringWithFormat:@"%@",dic2[@"haveMoney"]];
                        float money1 = haveMoney1.floatValue;
                        float money2 = haveMoney2.floatValue;
                        if (money1>money2) {
                            return    NSOrderedDescending;
                        }else{
                            return  NSOrderedAscending;
                        }
                    }];
                    
                    NSMutableArray *lastArr = [[NSMutableArray alloc]initWithArray:cardArr];
                    
                    for (NSDictionary *isDefault in lastArr) {
                        NSString * defaulttCard = [NSString stringWithFormat:@"%@",isDefault[@"isdefaultt"]];
                        if ([defaulttCard isEqualToString:@"1"]) {
                            weakself.defaultCard = [NSString stringWithFormat:@"%@",isDefault[@"cardno"]];
                            [lastArr removeObject:isDefault];
                            [lastArr insertObject:isDefault atIndex:0];
                            break;
                        }
                    }
                    
                    NSDictionary *userInfor = self.toDictionary;
                    NSString *file = [[NSFileManager defaultManager] userAccountPath:YES];
                    [userInfor writeToFile:file atomically:YES];
                    NSLog(@"用户信息更新成功");
                }else{
                    NSLog(@"用户信息更新失败");
                }
                
            } failure:^(NSError *err) {
                NSLog(@"用户信息更新失败");
            }];
        }else{
            NSDictionary *userInfor = self.toDictionary;
            NSString *file = [[NSFileManager defaultManager] userAccountPath:YES];
            [userInfor writeToFile:file atomically:YES];
        }
        
        
    });
}
-(NSString<Optional> *)userName{
    if (_userName == nil) {
        return self.phoneNum;
    }
    return _userName;
}
-(NSString<Optional> *)idCardNum{
    if (_idCardNum == nil) {
        return @"";
    }
    return _idCardNum;
}

-(NSString<Optional> *)emergencyPhoneNum{
    if (_emergencyPhoneNum == nil) {
        return @"";
    }
    return _emergencyPhoneNum;
}
-(NSString<Optional> *)Email{
    if (_Email== nil) {
        return @"";
    }
    return _Email;
}
-(NSString<Optional> *)phoneNum{
    if (_phoneNum == nil) {
        return @"";
    }
    return _phoneNum;
}
@end
