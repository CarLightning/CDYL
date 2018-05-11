//
//  CDCodeViewController.m
//  CDYL
//
//  Created by admin on 2018/5/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDCodeViewController.h"
#import "UIView+PYExtension.h"

@interface CDCodeViewController ()
@property (nonatomic, strong) UILabel *countLb;
@property (nonatomic, strong) UITextField *codeTf;
@property (nonatomic, strong) UIButton *LoginButton;
@property (nonatomic, strong) UIButton *getCodeBtn;

@end

@implementation CDCodeViewController{
    NSTimer *_timer;
    NSInteger numberCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerDisappear) userInfo:nil repeats:YES];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    
}
-(void)setSubViews{
    self.title = @"手机号验证";
    self.view.backgroundColor = [UIColor whiteColor];
    numberCount = 60;
    CGFloat black = 79;
    if (is_iphoneX) {
        black = 103;
    }
    
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(15, black, DEAppWidth-30, 40)];
    lb.text=@"为了安全，我们会向你的手机发送短信验证码";
    lb.font=[UIFont systemFontOfSize:14];
    lb.textAlignment=NSTextAlignmentLeft;
    lb.textColor=LHColor(177, 177, 177);
    [self.view addSubview:lb];
    
    UIView *showView =[[UIView alloc]initWithFrame:CGRectMake(15, black+40, DEAppWidth-30, 40)];
    [self.view addSubview:showView];
    
    UIImageView *codeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7.5, 25, 25)];
    codeImage.image = [UIImage imageNamed:@"codeImage"];
    [showView addSubview:codeImage];
    
    
    UITextField *codeTf= [[UITextField alloc]initWithFrame:CGRectMake(30, 0, DEAppWidth-30-50, 40)];
    codeTf.keyboardType =UIKeyboardTypeNumberPad;
    codeTf.placeholder=@"输入验证码";
    codeTf.font=[UIFont systemFontOfSize:14];
    [showView addSubview:codeTf];
    self.codeTf = codeTf;
    
    UILabel *countLb=[[UILabel alloc]initWithFrame:CGRectMake(showView.py_width-60, 0, 60, 40)];
    countLb.font=[UIFont systemFontOfSize:14];
    countLb.textAlignment=NSTextAlignmentCenter;
    countLb.textColor=[UIColor grayColor];
    [showView addSubview:countLb];
    
    self.countLb = countLb;
   
    UIButton *getCodeBtn=[[UIButton alloc]initWithFrame:countLb.frame];
   
    [getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [getCodeBtn setTitleColor:LHColor(59, 156, 233) forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(clickThegetCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:getCodeBtn];
    getCodeBtn.hidden = YES;
    self.getCodeBtn = getCodeBtn;
    
    UILabel *lineLb=[[UILabel alloc]initWithFrame:CGRectMake(0, showView.py_height+1, showView.py_width, 0.5)];
    lineLb.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5];
    [showView addSubview:lineLb];
    
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(15, showView.py_centerX+40+40, DEAppWidth-30, 40)];
    btn.backgroundColor = LHColor(251, 102, 110);
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
   
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 0.5;
    self.LoginButton = btn;
    
    
}
//点击下一步
-(void)clickTheBtn:(UIButton *)btn{
    [self.view endEditing:YES];
    if (self.codeTf.text.length>0) {
        if(self.cthType == 30){
            [self toReviewPassword];
        }else{
            [self toRegister];
        }
     
    }else{
        [self showMessage:@"不能为空"];
    }
    
}
-(void)toRegister{
    
    __weak typeof(self) weakself = self;
    [CDWebRequest requestregUserWithTel:self.userNum Code:self.codeTf.text Pass:[CDXML md5:self.PwordNum] AndBack:^(NSDictionary *backDic) {
        NSString *is_ok = [NSString stringWithFormat:@"%@",backDic[@"success"]];
        NSString *msg = [NSString stringWithFormat:@"%@",backDic[@"message"]];
        if ([is_ok isEqualToString:@"1"]) {
            
            [weakself registerSuccessd];
            
        }else{
            [weakself showMessage:msg];
        }
        
    } failure:^(NSError *err) {
        [weakself showMessage:@"网络连接失败"];
    }];
    
}

-(void)toReviewPassword{
    
    __weak typeof(self) weakself = self;
    [CDWebRequest requestResetPassWithTel:self.userNum Code:self.codeTf.text Pass:[CDXML md5:self.PwordNum] AndBack:^(NSDictionary *backDic) {
        
    
        NSString *is_ok = [NSString stringWithFormat:@"%@",backDic[@"success"]];
        NSString *msg = [NSString stringWithFormat:@"%@",backDic[@"message"]];
        if ([is_ok isEqualToString:@"1"]) {
            
            [weakself passwordChangeSuccessed];
            
        }else{
            [weakself showMessage:msg];
        }
        
    } failure:^(NSError *err) {
        [weakself showMessage:@"网络连接失败"];
    }];
}
//计时器
-(void)timerDisappear{
    numberCount --;
    if (numberCount == 0) {
        _timer.fireDate = [NSDate distantFuture];
        self.countLb.hidden = YES;
        self.getCodeBtn.hidden = NO;
    }
    self.countLb.text = [NSString stringWithFormat:@"%lds",numberCount];
}
//发送验证码
-(void)clickThegetCodeBtn{
    NSString *phone = self.userNum;
    __weak typeof( self) weakself = self;
    [CDWebRequest requestsendVerCodeWithTel:phone AndBack:^(NSDictionary *backDic) {
        NSString *message = backDic[@"message"];
        [weakself showMessage:message];
        weakself.getCodeBtn.hidden = YES;
        weakself.countLb.hidden = NO;
        numberCount = 60;
        [_timer setFireDate:[NSDate distantPast]];
        
    } failure:^(NSError *err) {
    [weakself showMessage:@"网络连接失败"];
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)dealloc{
    NSLog(@"%@无内存泄漏",NSStringFromClass([self class]));
}
-(void)showMessage:(NSString *)msg{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:2.0f];
}
//注册成功
-(void)registerSuccessd{
    [CDUserInfor shareUserInfor].phoneNum = self.userNum;
    [CDUserInfor shareUserInfor].userPword = [CDXML md5:self.PwordNum];
    [[CDUserInfor shareUserInfor] updateInforWithAll:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//密码修改成功
- (void)passwordChangeSuccessed{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功，请重新登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:1] animated:YES];
    }];
   
    [alert addAction:action1];
   
    [self presentViewController:alert animated:YES completion:nil];

}
@end
