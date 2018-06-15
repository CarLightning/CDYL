//
//  CDcell.h
//  CDYL
//
//  Created by admin on 2018/5/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CDcellDelegate <NSObject>

-(void)jumpToAddmoney;

@end

@interface CDcell : UIView

@property (nonatomic, weak) id<CDcellDelegate> delegate;


@end
