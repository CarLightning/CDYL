//
//  CDNav.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//sao'mia

#import "CDNav.h"

@interface CDNav ()

@end

@implementation CDNav

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        UINavigationBar *navbar = [[UINavigationBar alloc]init];
        navbar.tintColor=[UIColor blackColor];
        navbar.barTintColor=[UIColor whiteColor];
        NSDictionary *attri = @{
                                NSForegroundColorAttributeName :[UIColor blackColor],
                                NSFontAttributeName : [UIFont systemFontOfSize:18]
                                };
        navbar.titleTextAttributes = attri;
        [self setValue:navbar forKey:@"navigationBar"];
    }
    return self;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
