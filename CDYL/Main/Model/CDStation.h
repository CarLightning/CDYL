//
//  CDStation.h
//  CDYL
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 admin. All rights reserved.
//  站点模型

#import <JSONModel/JSONModel.h>
#import "CDPoliList.h"
@interface CDStation : JSONModel


/**站点id**/
@property (nonatomic, copy) NSString  * pid;
/**站点名称**/
@property (nonatomic, copy) NSString  * name;

/**站点距离**/
@property (nonatomic, copy) NSString  * distance;
@property (nonatomic, copy) NSString  * staType;
@property (nonatomic, copy) NSString  * facConf;
@property (nonatomic, copy) NSString  * conPerson;
/**站点电话**/
@property (nonatomic, copy) NSString  * telephone;
/**站点位置**/
@property (nonatomic, copy) NSString  * addr;
@property (nonatomic, assign) BOOL      status;
@property (nonatomic, assign) NSInteger isBespk;
/**站点经度**/
@property (nonatomic, assign) CGFloat  lon;
/**站点维度**/
@property (nonatomic, assign) CGFloat  lat;
/**桩模型 */
@property (nonatomic, strong) NSArray * polelist;

/**判断站点是否可以预约**/
@property (nonatomic) NSString <Ignore>* canOrder;

@end
