//
//  CDTabbar.h
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDTabbar ;
@protocol CDTabbarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidPlusClick:(CDTabbar *)tarbar;
@end


@interface CDTabbar : UITabBar
@property (nonatomic, weak) id<CDTabbarDelegate> delegate;

+ (instancetype)tabBar;
@end
