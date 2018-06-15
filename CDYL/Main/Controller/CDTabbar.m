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
@property (nonatomic, strong) UIButton *plusBtn;
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
        [plusBtn addTarget:self action:@selector(plusClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

- (void)plusClick:(UIButton *)btn
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


//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil){
        //转换坐标
        CGPoint tempPoint = [self.plusBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.plusBtn.bounds, tempPoint) && self.hidden ==NO){
            //返回按钮
            return _plusBtn;
        }
    }
    return view;
}

@end
