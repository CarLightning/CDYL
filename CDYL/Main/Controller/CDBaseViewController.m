//
//  CDBaseViewController.m
//  CDYL
//
//  Created by admin on 2018/4/3.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBaseViewController.h"

@interface CDBaseViewController ()
@property (nonatomic, strong) UILabel *empytLb;
@property (nonatomic, strong) UIImageView *bgNilIg;

@end

@implementation CDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    236 236 236
    self.view.backgroundColor = commentColor;
     [self.view addSubview:self.bgNilIg];
     [self.view addSubview:self.empytLb];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
    }
}
-(UIImageView *)bgNilIg{
    if (_bgNilIg == nil) {
         float scale = 0.95;
        CGFloat block= 94;
        if (IS_IPHONE_X) {
            block = 118;
        }
        _bgNilIg = [[UIImageView alloc]initWithFrame:CGRectMake(90, block, DEAppWidth-180, scale*(DEAppWidth-180))];
        _bgNilIg.image = [UIImage imageNamed:@"emptyImage"];
        _bgNilIg.hidden = YES;
    }
    return _bgNilIg;
}
-(UILabel *)empytLb{
    if (_empytLb == nil) {
        _empytLb = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgNilIg.frame)+20, DEAppWidth, 25)];
        _empytLb.textColor = LHColor(174, 184, 189);
        _empytLb.font = [UIFont systemFontOfSize:14];
        _empytLb.textAlignment = NSTextAlignmentCenter;
        _empytLb.hidden = YES;
    }
    return _empytLb;
}

- (void)showEmptyViewWith:(NSString *)text{
    self.empytLb.hidden = NO;
    self.bgNilIg.hidden = NO;
    [self.view bringSubviewToFront:self.empytLb];
    [self.view bringSubviewToFront:self.bgNilIg];
    self.empytLb.text = text;
   
}
-(void)hiddenAllBaseView{
    self.empytLb.hidden = YES;
    self.bgNilIg.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)dealloc{
    NSLog(@"%@无内存泄漏",NSStringFromClass([self class]));
    [self hiddenAllBaseView];
}

@end
