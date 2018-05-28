//
//  CDBaseViewController.m
//  CDYL
//
//  Created by admin on 2018/4/3.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBaseViewController.h"

@interface CDBaseViewController ()

@end

@implementation CDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LHColor(226, 226, 226);
   
   
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)dealloc{
    NSLog(@"%@无内存泄漏",NSStringFromClass([self class]));
}

@end
