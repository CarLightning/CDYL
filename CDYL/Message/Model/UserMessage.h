//
//  UserMessage.h
//  CDYL
//
//  Created by admin on 2018/6/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserMessage : NSObject
@property (nonatomic, copy) NSString  * uid;
@property (nonatomic, copy) NSString  * cardNo;
@property (nonatomic, copy) NSString  * msg_time;
@property (nonatomic, copy) NSString  * info;

-(NSAttributedString *)attributedText;
@end
