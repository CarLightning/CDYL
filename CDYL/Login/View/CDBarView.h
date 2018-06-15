//
//  CDBarView.h
//  CDYL
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDBarViewDelagate <NSObject>
-(void)popUpViewController;
@optional
-(void)didClickSelectButton;
@end
@interface CDBarView : UIView
@property (nonatomic, copy) NSString  * title;
@property (nonatomic, weak) id <CDBarViewDelagate>  delegate;
@property (nonatomic, assign) BOOL  is_showFun;
@property (nonatomic, strong) UIImage *bgImage;

@end
