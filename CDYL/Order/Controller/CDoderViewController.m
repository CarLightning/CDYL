//
//  CDoderViewController.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CDoderViewController.h"
#import "CDShowChangeCth.h"
#import "CDWaitPayCth.h"
#import "UIView+PYExtension.h"

@interface CDoderViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *topSview;
@property (nonatomic, strong) UIScrollView *contentSview;
@property (nonatomic, strong) UILabel *scrollowLb;

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
    self.navigationItem.title = @"我的订单";
}
#pragma mark - 初始化子控制器
- (void)_setupChildController
{
    CDShowChangeCth *showCharge = [[CDShowChangeCth alloc] init];
    showCharge.title = @"充电状态";
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
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    titlesView.frame = CGRectMake(0, blockX, DEAppWidth, 95/2);
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
    contentView.bounces = NO;
    contentView.frame = CGRectMake(0, CGRectGetMaxY(self.topSview.frame), DEAppWidth, DEAppHeight);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
   
    contentView.contentSize = CGSizeMake(DEAppWidth * self.childViewControllers.count, 0);
   [self.view addSubview:contentView];
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
    CGFloat labelW = DEAppWidth/2;
    CGFloat labelY = 0;
    CGFloat labelH = self.topSview.frame.size.height;
    
    // 添加TitleLabel
    NSInteger count = self.childViewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [self.childViewControllers[i] title];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(labelW*i, labelY, labelW, labelH);
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = LHColor(34, 34, 34);
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.topSview addSubview:label];
        
    }
    //添加滚动条
    CGFloat scrollLbW = 98;
    CGFloat scrollLbY = self.topSview.frame.size.height-2.5;
    CGFloat scrollLbH =2 ;
    
    UILabel *scrollLb = [[UILabel alloc]initWithFrame:CGRectMake(0, scrollLbY, scrollLbW, scrollLbH)];
    scrollLb.center = CGPointMake(DEAppWidth/4, scrollLb.center.y);
    scrollLb.backgroundColor = LHColor(255, 198, 0);
    [self.topSview addSubview:scrollLb];
    self.scrollowLb = scrollLb;
    
    
    //添加底线
    CGFloat downLbOr = 0;
    CGFloat downLbW = DEAppWidth;
    CGFloat downLbY = self.topSview.frame.size.height-0.5;
    CGFloat downLbH =0.5 ;
    UILabel *downLb = [[UILabel alloc]initWithFrame:CGRectMake(downLbOr, downLbY, downLbW, downLbH)];
    downLb.backgroundColor = LHColor(216, 216, 216);
    [self.topSview addSubview:downLb];

    
    // 设置contentSize
    self.topSview.contentSize = CGSizeMake(DEAppWidth, 0);
   
    
}

- (void)labelClick:(UITapGestureRecognizer *)tap{
   
    NSInteger tag = tap.view.tag;
    CGPoint point = CGPointMake(DEAppWidth *tag, 0);
    [UIView animateWithDuration:0.5 animations:^{
         [self.contentSview setContentOffset:point];
    } completion:^(BOOL finished) {
        [self scrollViewDidEndScrollingAnimation:self.contentSview];
    }];
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
    CGFloat OffsetX = scrollView.contentOffset.x/2;
    
     //设置scrollLabel的位置
    self.scrollowLb.transform = CGAffineTransformMakeTranslation(OffsetX, 0);
}
@end
