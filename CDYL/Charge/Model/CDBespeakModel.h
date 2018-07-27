//
//  CDBespeakModel.h
//  CDYL
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAGeometry.h>
@interface CDBespeakModel : NSObject
@property (nonatomic, copy) NSString  * detailName;
@property (nonatomic, copy) NSString  * name;
@property (nonatomic, copy) NSString  * comparyName;
@property (nonatomic, copy) NSString  * startTime;
@property (nonatomic, copy) NSString  * endTime;
@property (nonatomic, copy) NSString  * allTime;
/**桩ID**/
@property (nonatomic, copy) NSString  * poleid;
/**卡ID**/
@property (nonatomic, copy) NSString  * cardid;
/**预约ID**/
@property (nonatomic, copy) NSString  * bespeakid;
@property (nonatomic, assign)  CGFloat lon;
@property (nonatomic, assign)  CGFloat lat;
/**距离**/
@property (nonatomic, copy) NSString  * distance;



- (NSString *)star:(NSString *)sTime endTime:(NSString *)eTime is_all:(BOOL)is_all;
@end
