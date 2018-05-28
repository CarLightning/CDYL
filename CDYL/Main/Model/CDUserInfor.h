//
//  CDUserInforMation.h
//  CDYL
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface CDUserInfor : JSONModel

/***手机号***/
@property (nonatomic, copy) NSString <Optional> * phoneNum;
/***用户密码(MD5加密后)***/
@property (nonatomic, copy) NSString<Optional>  * userPword;
/***头像***/
@property (nonatomic, strong) NSString<Optional>  * headImagePath;





/***用户名***/
@property (nonatomic, copy) NSString<Optional>  * userName;
/***身份证号***/
@property (nonatomic, copy) NSString<Optional>  * idCardNum;
/***邮箱***/
@property (nonatomic, copy) NSString<Optional>  * Email;
/***紧急手机号***/
@property (nonatomic, copy) NSString <Optional> * emergencyPhoneNum;
/***默认卡***/
@property (nonatomic, copy) NSString <Optional>  * defaultCard;


+(instancetype)shareUserInfor;
/*更新*/
- (void)updateInforWithAll:(BOOL)all_update;
@end
