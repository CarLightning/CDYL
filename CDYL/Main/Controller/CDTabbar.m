//
//  CDTabbar.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CDTabbar.h"
#import "UIView+PYExtension.h"

#define  PYControllCount 4
@interface CDTabbar()
@property (nonatomic, strong) UIView *plusBtn;
@end

@implementation CDTabbar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加加好按钮
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setImage:[[UIImage imageNamed:@"tab_publish_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        // 设置监听事件
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        
    }
    return self;
}

- (void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidPlusClick:)]) {
        [self.delegate tabBarDidPlusClick:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 计算宽度
    CGFloat childW = self.py_width / (PYControllCount + 1);
    self.plusBtn.py_width = childW;
    self.plusBtn.py_height = childW;
    
    // 添加plusBtn的位置
    self.plusBtn.center = CGPointMake(self.center.x, 0);
   
    
    // 引出下标
    NSInteger index = 0;
    // 判断是否为控制器按钮
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child.class isSubclassOfClass:class]) {
            child.py_x = index * childW;
            child.py_width = childW;
            index++;
            if (index == 2) {
                index ++;
            }
        }
    }
}

+ (instancetype)tabBar
{
    return [[self alloc] init];
}


@end
