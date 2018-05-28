//
//  CDLoginViewController.m
//  CDYL
//
//  Created by admin on 2018/4/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDLoginViewController.h"
#import "CDLoginView.h"
#import "CDWebRequest.h"
#import "CDCodeViewController.h"
#import "CDReViewController.h"
#import "CDBarView.h"

@interface CDLoginViewController ()<CDBarViewDelagate>
@property (nonatomic, strong) CDLoginView *loginView;
@property (nonatomic, strong) UIView *HUDView;
@property (nonatomic, strong) UIButton *LoginButton;
@property (nonatomic, strong) UIButton *reviewBtn; //重设密码
@property (nonatomic, strong) UIView *LoginAnimView;
//登录转圈的那条白线所在的layer
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong)CDBarView *barView;
@end

@implementation CDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubInfors];
}

- (void)setSubInfors {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat Height = 64;
    if (is_iphoneX) {
        Height = 88;
    }
    CDBarView *barView = [[CDBarView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, Height)];
    barView.delegate = self;
    [self.view addSubview:barView];
    self.barView = barView;
    
    if (self.cthType == 1) {//登录界面
        [self LoginCth:barView.bounds.size.height+15 title:@"手机号登录"];
       
    }else{
        [self registerCth:barView.bounds.size.height+15 title:@"手机号注册"];
      
    }
}
- (void)LoginCth:(CGFloat )block title:(NSString *)string {
   
    self.barView.title = string;
    CDLoginView *lgView = [[CDLoginView alloc]initWithFrame:CGRectMake(0, block, DEAppWidth, 88) wight:0];
    [self.view addSubview:lgView];
    self.loginView = lgView;
    [self setBtnblack:block title:@"登录" tag:100];
   
    UIButton *reviewBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, block+200, DEAppWidth-30, 40)];
    
    [reviewBtn setTitle:@"重设密码" forState:UIControlStateNormal];
    reviewBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [reviewBtn addTarget:self action:@selector(clickThereviewBtn:) forControlEvents:UIControlEventTouchUpInside];
    [reviewBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:reviewBtn];
    self.reviewBtn = reviewBtn;
    
    
}
-(void)registerCth:(CGFloat )block title:(NSString *)string  {
    self.barView.title = string;
    CDLoginView *lgView = [[CDLoginView alloc]initWithFrame:CGRectMake(0, block, DEAppWidth, 88) wight:35];
    [self.view addSubview:lgView];
    self.loginView = lgView;
    [self setBtnblack:block title:@"下一步" tag:101];
}
-(void)setBtnblack:(CGFloat)black title:(NSString *)title tag:(NSUInteger)tag{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(15, black+130, DEAppWidth-30, 40)];
    btn.backgroundColor = LHColor(255, 198, 80);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [btn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 20;

    self.LoginButton = btn;
}
#pragma mark - Btn点击方法
-(void)clickTheBtn:(UIButton *)btn{
    [self.view endEditing:YES];
     if (btn.tag == 100) { //登录
         [self LoginButtonClick];
    }else{ // 注册
        [self registerBtnClick];
        
    }
}
-(void)clickThereviewBtn:(UIButton *)btn{
    CDReViewController *review = [[CDReViewController alloc]init];
    [self.navigationController pushViewController:review animated:YES];
}
#pragma mark - 登录方法
-(BOOL)is_okPhone:(NSString *)phoneNum Pword:(NSString *)pwordNum{
    if (phoneNum.length>0 && pwordNum.length>0) {
        if ([CDXML phoneNumberIsTrue:phoneNum]) {
            if (self.cthType ==1 ) {
                 return YES;
            }else{
                if (pwordNum.length>=6) {
                    return YES;
                }else{
                    [self showAlert:@"密码至少六位"];
                }
            }
            
           
        }else{
             [self showAlert:@"手机号有误"];
        }
    }else{
        [self showAlert:@"不能为空"];
    }
    return NO;
}
-(void)registerBtnClick{
    
    NSString *phone = self.loginView.phoneTf.text;
    NSString *pword = self.loginView.pWordTf.text;
    if ([self is_okPhone:phone Pword:pword]) {
      
        [CDWebRequest requestsendVerCodeWithTel:phone AndBack:^(NSDictionary *backDic) {
            
        } failure:^(NSString *err) {
            
        }];
        CDCodeViewController *codeView = [[CDCodeViewController alloc]init];
        codeView.userNum = phone;
        codeView.PwordNum = pword;
        [self.navigationController pushViewController:codeView animated:YES];
    }
    
}
- (void)LoginButtonClick
{
    //HUDView，盖住view，以屏蔽掉点击事件
    self.HUDView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.HUDView];
    self.HUDView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    //执行登录按钮转圈动画的view
    self.LoginAnimView = [[UIView alloc] initWithFrame:self.LoginButton.frame];
    self.LoginAnimView.layer.cornerRadius = 10;
    self.LoginAnimView.layer.masksToBounds = YES;
    self.LoginAnimView.frame = self.LoginButton.frame;
    self.LoginAnimView.backgroundColor = self.LoginButton.backgroundColor;
    [self.view addSubview:self.LoginAnimView];
    self.LoginButton.hidden = YES;
    
    //把view从宽的样子变圆
    CGPoint centerPoint = self.LoginAnimView.center;
    CGFloat radius = MIN(self.LoginButton.frame.size.width, self.LoginButton.frame.size.height);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.LoginAnimView.frame = CGRectMake(0, 0, radius, radius);
        self.LoginAnimView.center = centerPoint;
        self.LoginAnimView.layer.cornerRadius = radius/2;
        self.LoginAnimView.layer.masksToBounds = YES;
        
    }completion:^(BOOL finished) {
        
        //给圆加一条不封闭的白色曲线
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path addArcWithCenter:CGPointMake(radius/2, radius/2) radius:(radius/2 - 5) startAngle:0 endAngle:M_PI_2 * 2 clockwise:YES];
        self.shapeLayer = [[CAShapeLayer alloc] init];
        self.shapeLayer.lineWidth = 1.5;
        self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.fillColor = self.LoginButton.backgroundColor.CGColor;
        //        self.shapeLayer.frame = CGRectMake(0, 0, radius, radius);
        self.shapeLayer.path = path.CGPath;
        [self.LoginAnimView.layer addSublayer:self.shapeLayer];
        
        //让圆转圈，实现"加载中"的效果
        CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        baseAnimation.duration = 0.4;
        baseAnimation.fromValue = @(0);
        baseAnimation.toValue = @(2 * M_PI);
        baseAnimation.repeatCount = MAXFLOAT;
        [self.LoginAnimView.layer addAnimation:baseAnimation forKey:nil];
        
        //开始登录
        [self doLogin];
    }];
    
}
//登录
-(void)doLogin{
   
        NSString *phone = self.loginView.phoneTf.text;
        NSString *pword = self.loginView.pWordTf.text;
     __block typeof(self) weakself = self;
        if ([self is_okPhone:phone Pword:pword]) {
            NSString *md5_pw = [CDXML md5:pword];

            //延时，模拟网络请求的延时
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [CDWebRequest loginWithName:phone PassWord:md5_pw AndBack:^(NSDictionary *backDic) {
                NSDictionary *dic = backDic;
                if (dic) {
                    NSString *is_ok = [NSString stringWithFormat:@"%@",dic[@"success"]];
                    if ([is_ok isEqualToString:@"1"]) {
                        [weakself loginSuccessWith:phone md5Pw:md5_pw];
                    }else{
                        //登录失败
                        [weakself loginFail];
                    }
                    
                    
                }
                
            } failure:^(NSString *err) {
                //登录失败
                [weakself loginFail];
            }];
            });
            
        }else{
             [self loginFail];
        }
    
    
}
/** 登录成功 */
- (void)loginSuccessWith:(NSString *)phone md5Pw:(NSString *)pword
{
    //移除蒙版
    [self.HUDView removeFromSuperview];
    //跳转到另一个控制器
    [CDUserInfor shareUserInfor].phoneNum = phone;
    [CDUserInfor shareUserInfor].userPword = pword;
    [[CDUserInfor shareUserInfor] updateInforWithAll:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
//    写入UserDefault
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    [userdf setBool:YES forKey:@"isLogin"];
    [userdf synchronize];
    
}
/** 登录失败 */
- (void)loginFail
{
    //把蒙版、动画view等隐藏，把真正的login按钮显示出来
    self.LoginButton.hidden = NO;
    [self.HUDView removeFromSuperview];
    [self.LoginAnimView removeFromSuperview];
    [self.LoginAnimView.layer removeAllAnimations];
    
    //给按钮添加左右摆动的效果(路径动画)
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.LoginAnimView.layer.position;
    
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:point]];
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration = 0.5f;
    [self.LoginButton.layer addAnimation:keyFrame forKey:keyFrame.keyPath];
}
#pragma mark - 注册方法

#pragma mark - 自定义方法
-(void)showAlert:(NSString *)message{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:2.0f];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - CDBarViewDelagate
-(void)popUpViewController{
    NSArray *subs = self.navigationController.childViewControllers;
   
    [self.navigationController popToViewController:[subs objectAtIndex:subs.count-2] animated:YES];
}
@end
