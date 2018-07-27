//
//  LSXPointViewController.m
//  LSX
//
//  Created by admin on 2016/11/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LSXPointViewController.h"
#import "CDNav.h"
#import "CDMineViewController.h"

@interface LSXPointViewController (){
    int  state;
    
}
@property (nonatomic, strong) UILabel           *stLb;  //状态
@property (nonatomic, strong) UIImageView       *imagev;  //是否在线图标
@property (nonatomic, strong) UIButton          *btn;

//查询桩开启状态
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation LSXPointViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    [self getStatusAboutPold];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    float black=80;
    //    background
    self.view.backgroundColor=[UIColor whiteColor];
    
    CGFloat OriginY= 64;
    if (is_iphoneX) {
        OriginY = 88;
    }
    UIImageView *ivi=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, 2*DEAppHeight/3)];
    ivi.image=[UIImage imageNamed:@"ban.png"];
    //    ivi.backgroundColor=[UIColor redColor];
    [self.view addSubview:ivi];
    
    // imageview
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(black, OriginY+30, DEAppWidth-black*2, DEAppWidth-black*2)];
    imageview.image=[UIImage imageNamed:@"充电桩404"];
    [self.view addSubview:imageview];
    
    //  在线.离线
    UIImageView *imagev=[[UIImageView alloc]init];
    
    if (DEAppWidth==320) {
        imagev.frame=CGRectMake(DEAppWidth-130, OriginY+28, 40, 40);
        imagev.center=CGPointMake(DEAppWidth/2+(DEAppWidth-black*2)/4+10, imageview.center.y-0.866*(DEAppWidth/2-black));
    }else {
        imagev.frame=CGRectMake(DEAppWidth-130, OriginY+28, 50, 50);
        imagev.center=CGPointMake(DEAppWidth/2+(DEAppWidth-black*2)/4+12, imageview.center.y-0.866*(DEAppWidth/2-black)-5);
    }
    
    [self.view addSubview:imagev];
    imagev.hidden=YES;
    self.imagev=imagev;
    
    
    UILabel *poldlb=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame)+20, DEAppWidth, 30)];
    poldlb.text=[NSString stringWithFormat:@"%@",self.poldId];
    poldlb.font=[UIFont systemFontOfSize:16];
    
    poldlb.textAlignment=NSTextAlignmentCenter;
    poldlb.textColor=[UIColor whiteColor];
    [self.view addSubview:poldlb];
    
//  是否在线
    UILabel *statelb=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(poldlb.frame)+15, 260, 25)];
    statelb.center=CGPointMake(self.view.center.x, statelb.center.y);
    statelb.font=[UIFont systemFontOfSize:18];
    statelb.textAlignment=NSTextAlignmentCenter;
    statelb.textColor=[UIColor whiteColor];
    self.stLb=statelb;
    [self.view addSubview:statelb];
    
// 线1
    UIImageView *zuoImage=[[UIImageView alloc]initWithFrame:CGRectMake(DEAppWidth/2-0.33*DEAppWidth-30, statelb.frame.origin.y, DEAppWidth*0.26, 0.0053*DEAppHeight)];
    zuoImage.center=CGPointMake(zuoImage.center.x, statelb.center.y);
    zuoImage.image=[UIImage imageNamed:@"zuo"];
    [self.view addSubview:zuoImage];
    
// 线2
    UIImageView *youImage=[[UIImageView alloc]initWithFrame:CGRectMake(DEAppWidth/2+0.06*DEAppWidth+30, statelb.frame.origin.y, DEAppWidth*0.26, 0.0053*DEAppHeight)];
     youImage.center=CGPointMake(youImage.center.x, statelb.center.y);
    youImage.image=[UIImage imageNamed:@"you"];
    [self.view addSubview:youImage];
  
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(ivi.frame)+50, DEAppWidth-60, 50)];
    btn.backgroundColor=[UIColor colorWithRed:144.0/255.0 green:190.0/255.0 blue:32.0/255.0 alpha:1.0];
    btn.titleLabel.textColor=[UIColor whiteColor];
    [btn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"我要充电" forState:UIControlStateNormal];
    btn.layer.cornerRadius=4;
    [self.view addSubview:btn];
     self.btn=btn;
    
   
    
}


-(NSMutableAttributedString *)text:(NSString *)str{
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:str];
    //把查找到的范围 颜色修改成红色
    if (DEAppWidth==320) {
        [attributeString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, 2)];
    }else{
        [attributeString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, 2)];
    }
    return attributeString;
}
-(void)clickTheBtn{
    switch (state) {
        case 5:  //就绪
        {
            [self openPold];
        }
            break;
        default:
            [self Alert:@"当前充电桩状态不支持充电"];
            break;
    }
}
-(void)Alert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        
//     [SWWebRequest requestBaiduMapInformationAndCallback:^(id obj) {
        

//     }];
    }];
    
    [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)getStatusAboutPold{
    __block typeof(self) weakself = self;
    [CDWebRequest requestgetRealByPoleIdid:self.poldId AndBack:^(NSDictionary *backDic) {
     
        NSDictionary *sourceDic = [backDic objectForKey:@"poleReal"];
        NSString *poleStatus = [NSString stringWithFormat:@"%@",sourceDic[@"status"]];
        
        if ([poleStatus isEqualToString:@"1"]) {
            weakself.stLb.text =@"正在充电中";
        }else if ([poleStatus isEqualToString:@"2"]){
            weakself.stLb.text =@"空闲";
        }else if ([poleStatus isEqualToString:@"3"]){
            weakself.stLb.text =@"故障";
        }else if ([poleStatus isEqualToString:@"4"]){
            weakself.stLb.text =@"离线";
        }else if ([poleStatus isEqualToString:@"5"]){
            weakself.stLb.text =@"就绪";
        }else if ([poleStatus isEqualToString:@"6"]){
            weakself.stLb.text =@"预约中";
        }
        
        state = poleStatus.intValue;
    } failure:^(NSString *err) {
        
    }];
  
}
- (void)openPold{
    if (![CDXML isLogin]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重新登陆" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CDBaseViewController*  basecth = [[NSClassFromString(@"CDViewController") alloc]init];            
            CDNav *navi = [[CDNav alloc]initWithRootViewController:basecth];
            navi.navigationBar.hidden = YES;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navi animated:YES completion:nil];
        }];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
    NSString *cardNo = [CDUserInfor shareUserInfor].phoneNum;
    NSString *pass = [CDUserInfor shareUserInfor].userPword;
 NSString *cardId = [CDUserInfor shareUserInfor].defaultCard;
    __weak typeof(self) weakself = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"开启充电中";
    [CDWebRequest requestOpenPoleByScanWithIdentity:@"1" cardNo:cardNo pass:pass cardId:cardId poleId:self.poldId AndBack:^(NSDictionary *backDic) {
         hud.label.text = @"正在进行绝缘检测，请稍等";
        [weakself whetherOpenPoldOk];
    } failure:^(NSString *err) {
        hud.label.text = err;
        [hud hideAnimated:YES afterDelay:1.5f];
    }];
}
}
/***开启桩成功与否查询**/
- (void)whetherOpenPoldOk{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkPoldState) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)checkPoldState{
    if (self.count>= 12) {
        [self openNO];
    }else{
        __weak typeof(self) weakself = self;
        [CDWebRequest requestgetRealByPoleIdid:self.poldId AndBack:^(NSDictionary *backDic) {
            NSString *status = [NSString stringWithFormat:@"%@",backDic[@"poleReal"][@"status"]];
            if ([status isEqualToString:@"1"]) {
                [weakself openOk];
            }
        } failure:^(NSString *err) {
            
        }];
        self.count++;
    }
    
}
/***开启桩失败**/
-(void)openNO{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"ErrorMark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc]initWithImage:image];
    hud.label.text = @"开启失败";
    [hud hideAnimated:YES afterDelay:1.5f];
    self.count = 0;
    [self.timer invalidate];
    self.timer = nil;
}

/***开启桩成功**/
-(void)openOk{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.text = @"开启成功";
    [hud hideAnimated:YES afterDelay:1.5f];
    self.count = 0;
    [self.timer invalidate];
    self.timer = nil;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CDNav *selectNavi = self.tabBarController.selectedViewController;
        self.tabBarController.selectedIndex = 1;
        self.tabBarController.selectedViewController = self.tabBarController.childViewControllers[1];
        if (selectNavi.childViewControllers.count>0) {
            [selectNavi popToViewController:selectNavi.childViewControllers[0] animated:YES];
        }
    });
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    
        if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
            //当前视图控制器在栈中，故为push操作
            NSLog(@"push");
        } else if ([viewControllers indexOfObject:self] == NSNotFound) {
            //当前视图控制器不在栈中，故为pop操作
            [self containsObject];
        }
    };
    

-(void)containsObject{
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (CDBaseViewController *vc in viewControllers) {
        if ([vc isMemberOfClass:[CDMineViewController class]]) {
            self.navigationController.navigationBarHidden = YES;
        }
    }
    
    
}
@end
