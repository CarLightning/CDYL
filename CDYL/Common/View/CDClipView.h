//
//  CDClipView.h
//  CDYL
//
//  Created by admin on 2018/6/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CDClipViewDelagate <NSObject>
-(void)didSaveImage:(UIImage *)image;
@end
@interface CDClipView : UIView

@property (nonatomic, strong) UIImage *Headimage;
@property (nonatomic, assign) BOOL  is_ShowBtn;
@property (nonatomic, weak) id <CDClipViewDelagate> delagate;

@end
