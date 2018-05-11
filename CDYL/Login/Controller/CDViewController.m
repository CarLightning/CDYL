//
//  CDViewController.m
//  CDYL
//
//  Created by admin on 2018/4/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDViewController.h"
#import "CDLoginViewController.h"

@interface CDViewController ()

@end

@implementation CDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
   
}
-(void)setSubViews{
//    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
//    imageview.image = [UIImage imageNamed:@"sd"];
//    [self.view addSubview:imageview];
    
    UIButton *loginbtn=[[UIButton alloc]initWithFrame:CGRectMake(50, self.view.center.y-35, DEAppWidth-100, 30)];
    loginbtn.backgroundColor = [UIColor whiteColor];
    [loginbtn addTarget:self action:@selector(clickTheLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:loginbtn];
    loginbtn.layer.cornerRadius = 15;
    loginbtn.layer.masksToBounds = YES;
    loginbtn.layer.borderColor = [UIColor redColor].CGColor;
    loginbtn.layer.borderWidth = 0.5;
    
    UIButton * regBtn=[[UIButton alloc]initWithFrame:CGRectMake(50, self.view.center.y+5, DEAppWidth-100, 30)];
    regBtn.backgroundColor = [UIColor whiteColor];
    [regBtn addTarget:self action:@selector(clickTheRegBtn) forControlEvents:UIControlEventTouchUpInside];
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [regBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [regBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:regBtn];
    regBtn.layer.cornerRadius = 15;
    regBtn.layer.masksToBounds = YES;
    regBtn.layer.borderColor = [UIColor redColor].CGColor;
    regBtn.layer.borderWidth = 0.5;
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
   
    longpress.minimumPressDuration = 2;
    [self.view addGestureRecognizer:longpress];
}
- (void)clickTheLoginBtn{
    CDLoginViewController *login = [[CDLoginViewController alloc]init];
    login.cthType = 1;
    
    [self.navigationController pushViewController:login animated:YES];
}
-(void)clickTheRegBtn{
    CDLoginViewController *login = [[CDLoginViewController alloc]init];
    login.cthType = 0;
    
    [self.navigationController pushViewController:login animated:YES];
}
-(void)longPress:(UILongPressGestureRecognizer *)longPress{
    
        [self dismissViewControllerAnimated:YES completion:nil];
   
}

@end
