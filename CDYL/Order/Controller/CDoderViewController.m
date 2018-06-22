//
//  CDoderViewController.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CDoderViewController.h"
#import "CDAppointmentOrderCth.h"
#import "CDShowChangeCth.h"
#import "CDWaitPayCth.h"
#import "CDTopLabel.h"

@interface CDoderViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *topSview;
@property (nonatomic, strong) UIScrollView *contentSview;

@end

@implementation CDoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    [self _setup];
    
    // 设置导航栏
    [self _setupNavigationItem];
    
    // 初始化自控制器
    [self _setupChildController];
    
    // 设置子控件
    [self _setupSubViews];
    
  
}
#pragma mark - 初始化
- (void)_setup
{
    self.view.backgroundColor = LHColor(223, 223, 223);
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


#pragma mark - 设置导航栏
- (void)_setupNavigationItem
{
    self.title = @"订单";
}
#pragma mark - 初始化子控制器
- (void)_setupChildController
{
    CDAppointmentOrderCth *AppointmentOrder = [[CDAppointmentOrderCth alloc] init];
    AppointmentOrder.title = @"当前预约";
    [self addChildViewController:AppointmentOrder];
    
    CDShowChangeCth *showCharge = [[CDShowChangeCth alloc] init];
    showCharge.title = @"充电中";
    [self addChildViewController:showCharge];
    
    CDWaitPayCth *waitPay = [[CDWaitPayCth alloc] init];
    waitPay.title = @"待支付";
    [self addChildViewController:waitPay];
    
}
#pragma mark - 设置子控件
- (void)_setupSubViews
{
    // 设置顶部的标签栏
    [self _setupTitlesView];
    
    // 底部的scrollView
    [self _setupContentView];
    
}
/**
 * 设置顶部的标签栏
 */
- (void)_setupTitlesView
{
    CGFloat blockX = 64;
    if (is_iphoneX) {
        blockX = 88;
    }
    // 标签栏整体
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.frame = CGRectMake(0, blockX, DEAppWidth, 44);
    titlesView.showsHorizontalScrollIndicator = NO;
    titlesView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:titlesView];
    self.topSview = titlesView;
    
    // 设置TopicTitle
    [self _setupTopicTitle];
}

/**
 * 底部的scrollView
 */
- (void)_setupContentView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(DEAppWidth * self.childViewControllers.count, 0);
    self.contentSview = contentView;
    
  
   
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 * 添加标题
 */
- (void)_setupTopicTitle
{
    // 定义临时变量
    CGFloat labelW = (DEAppWidth-100)/3;
    CGFloat labelY = 0;
    CGFloat labelH = self.topSview.frame.size.height;
    
    // 添加label
    NSInteger count = self.childViewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        CDTopLabel *label = [[CDTopLabel alloc] init];
        label.text = [self.childViewControllers[i] title];
     
        label.frame = CGRectMake((labelW+50)*i, labelY, labelW, labelH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.topSview addSubview:label];
        
        if (i == 0) { // 最前面的label
            label.scale = 1.0;
        }
    }
    
    // 设置contentSize
    self.topSview.contentSize = CGSizeMake(DEAppWidth, 0);
   
    
}

- (void)labelClick:(UITapGestureRecognizer *)tap{
   
    NSInteger tag = tap.view.tag;
    CGPoint point = CGPointMake(DEAppWidth *tag, 0);
    [self.contentSview setContentOffset:point animated:YES];
}
#pragma mark - UIScrollViewDelegate
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    
 
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 * 只要scrollView在滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //边界
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.topSview.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    CDTopLabel *leftLabel = self.topSview.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    CDTopLabel *rightLabel = (rightIndex == self.topSview.subviews.count) ? nil : self.topSview.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}
@end
