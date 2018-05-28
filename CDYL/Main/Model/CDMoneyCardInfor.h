//
//  CDMoneyCardInfor.h
//  CDYL
//
//  Created by admin on 2018/5/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "JSONModel.h"

@interface CDMoneyCardInfor : JSONModel

@property (nonatomic, copy) NSString  * cardno;
@property (nonatomic, copy) NSString  * haveMoney;
@property (nonatomic, copy) NSString  * status;
@property (nonatomic, copy) NSString  * type;
@property (nonatomic, copy) NSString  * valivity;
@property (nonatomic) BOOL   isdefaultt;
@end
