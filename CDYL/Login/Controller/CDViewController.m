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
@property (nonatomic, strong) UIImageView *loginBg;
@property (nonatomic, strong) UIImageView *loginHead;
@property (nonatomic, strong) UIButton *loginbtn;
@property (nonatomic, strong) UIButton *registBtn;
@end

@implementation CDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    [self add_masonrys];
    self.navigationController.navigationBarHidden = YES;
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    
    longpress.minimumPressDuration = 2;
    [self.view addGestureRecognizer:longpress];
    
}

-(void)setSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginBg];
    [self.view addSubview:self.loginHead];
    [self.view addSubview:self.loginbtn];
    [self.view addSubview:self.registBtn];
}
- (void)add_masonrys{
    CGFloat block = 134;
    if (is_iphoneX) {
        block = 158;
    }
    [self.loginBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.view);
    }];
    [self.loginHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(block);
        make.left.equalTo(self.view).offset(94);
        make.right.equalTo(self.view).offset(-94);
        make.height.mas_equalTo(self.loginHead.mas_width).multipliedBy(0.214);
    }];
    [self.loginbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginHead.mas_bottom).offset(77);
        make.left.equalTo(self.view).offset(60);
        make.right.equalTo(self.view).offset(-60);
        make.height.mas_equalTo(self.loginbtn.mas_width).multipliedBy(0.146);
    }];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginbtn.mas_bottom).offset(19);
        make.left.equalTo(self.view).offset(60);
        make.right.equalTo(self.view).offset(-60);
        make.height.mas_equalTo(self.registBtn.mas_width).multipliedBy(0.146);
    }];
}
-(UIImageView *)loginBg{
    if (_loginBg == nil) {
        _loginBg = [[UIImageView alloc]init];
        _loginBg.image = [UIImage imageNamed:@"loginBg"];
    }
    return _loginBg;
}

-(UIImageView *)loginHead{
    if (_loginHead == nil) {
        _loginHead = [[UIImageView alloc]init];
        _loginHead.image = [UIImage imageNamed:@"loginHead"];
    }
    return _loginHead;
}
-(UIButton *)loginbtn{
    if (_loginbtn == nil) {
        _loginbtn=[[UIButton alloc]init];
        _loginbtn.backgroundColor = LHColor(255, 198, 80);
        [_loginbtn addTarget:self action:@selector(clickTheLoginBtn) forControlEvents:UIControlEventTouchUpInside];
        [_loginbtn setTitle:@"手机号登录" forState:UIControlStateNormal];
        [_loginbtn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
        [_loginbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _loginbtn.layer.cornerRadius = (DEAppWidth-120)*0.146/2;;
        _loginbtn.layer.masksToBounds = YES;
    }
    return _loginbtn;
}

-(UIButton *)registBtn{
    if (_registBtn == nil) {
        _registBtn=[[UIButton alloc]init];
        _registBtn.backgroundColor = LHColor(255, 198, 80);
        [_registBtn addTarget:self action:@selector(clickTheRegBtn) forControlEvents:UIControlEventTouchUpInside];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _registBtn.layer.cornerRadius = (DEAppWidth-120)*0.146/2;
        _registBtn.layer.masksToBounds = YES;
    }
    
    return _registBtn;
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
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
@end
