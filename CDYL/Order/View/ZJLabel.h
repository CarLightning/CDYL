//
//  ZJLabel.h
//  ZJLabel
//
//  Created by iOS on 16/6/20.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJLabel : UIView
@property (nonatomic,assign)CGFloat present;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)stopAnimation;
@end
