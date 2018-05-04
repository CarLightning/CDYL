//
//  CDPoliList.h
//  CDYL
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 admin. All rights reserved.
//  桩模型

#import <JSONModel/JSONModel.h>

@interface CDPoliList : JSONModel

//                "id":"304012015071300000000014",
//　　　　　　　　　　"name":"邵逸夫医院1#充电桩",
//　　　　　　　　　　"poleType":"交流充电桩/7.0千瓦/220.0伏/32.0安",
//　　　　　　　　　　"installSite":"浙江杭州 下沙路391号",
//　　　　　　　　　　"powerRating":7,
//　　　　　　　　　　"nomVol":220,
//　　　　　　　　　　"nomCurrent":32,
//　　　　　　　　　　"lon":120.312388,
//　　　　　　　　　　"lat":30.302524,
//　　　　　　　　　　"status":4,
//　　　　　　　　　　"isBesp":2

/**桩的id编号**/
@property (nonatomic, copy) NSString  * uid;
/**桩的名称**/
@property (nonatomic, copy) NSString  * name;
/**经度**/
@property (nonatomic, copy) NSString  * lon;
/**维度**/
@property (nonatomic, copy) NSString  * lat;
/**桩类型介绍**/
@property (nonatomic, copy) NSString  * poleType;
/**桩的安装地址**/
@property (nonatomic, copy) NSString  * installSite;
@property (nonatomic, copy) NSString  * nomVol;
@property (nonatomic, copy) NSString  * nomCurrent;

/**桩的状态
 1、充电中
 2、空闲
 3、故障
 4、离线
 5、就绪
 6、预约中
 **/
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger powerRating;
@property (nonatomic, assign) NSInteger isBesp;
@end
