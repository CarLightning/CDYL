//
//  CDShowChangeCth.m
//  CDYL
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDShowChangeCth.h"
#import "ZJLabel.h"

@interface CDShowChangeCth ()
@property (nonatomic, strong) ZJLabel *waterView;
@property (nonatomic, strong) UILabel *statuLb; //充电状态
@property (nonatomic, strong) UILabel *volLb;
@property (nonatomic, strong) UILabel *volValueLb; //电量
@property (nonatomic, strong) UILabel *consumeLb;
@property (nonatomic, strong) UILabel *consumeValueLb; //消费
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *timeValueLb; //充电时间
@property (nonatomic, strong) UIButton *endBtn;  //结束充电按钮
@property (nonatomic, strong) NSDictionary *realDic;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CDShowChangeCth

- (void)viewDidLoad {
    [super viewDidLoad];
    [self add_SubViews];
    [self add_Masonrys];
    
}
-(void)viewWillAppear:(BOOL)animated{
    if ([CDXML isLogin]) {
        if (self.timer ) {
            self.timer.fireDate = [NSDate distantPast];
        }else{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(getSourceDic) userInfo:nil repeats:YES];
            [self.timer fire];
        }
    }else{
        [self pole_isNoCharge];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    if (self.timer) {
        self.timer.fireDate = [NSDate distantFuture];
    }
}
- (void)add_SubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.waterView];
    [self.view addSubview:self.statuLb];
    [self.view addSubview:self.volLb];
    [self.view addSubview:self.volValueLb];
    [self.view addSubview:self.consumeLb];
    [self.view addSubview:self.consumeValueLb];
    [self.view addSubview:self.timeLb];
    [self.view addSubview:self.timeValueLb];
    [self.view addSubview:self.endBtn];
}
- (void)add_Masonrys{
    [self.statuLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(37);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    [self.volLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(DEAppWidth/4-50);
        make.top.equalTo(self.statuLb.mas_bottom).offset(35);
        make.width.equalTo(@100);
        make.height.equalTo(@16);
    }];
    [self.volValueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.volLb.mas_left);
        make.top.equalTo(self.volLb.mas_bottom).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    
    [self.consumeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(50-DEAppWidth/4);
        make.top.equalTo(self.volLb.mas_top);
        make.width.equalTo(@100);
        make.height.equalTo(@16);
    }];
    [self.consumeValueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.consumeLb.mas_left);
        make.top.equalTo(self.consumeLb.mas_bottom).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.statuLb.mas_bottom).offset(180);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    [self.timeValueLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.timeLb.mas_centerX);
        make.top.equalTo(self.timeLb.mas_bottom).offset(5);
        make.width.equalTo(@250);
        make.height.equalTo(@45);
    }];
    
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.timeLb.mas_centerX);
        make.top.equalTo(self.timeValueLb.mas_bottom).offset(60);
        make.width.equalTo(@174);
        make.height.equalTo(@38);
    }];
}

#pragma mark - get Method

-(ZJLabel *)waterView{
    if (_waterView == nil) {
        CGFloat height = DEAppHeight-95/2-64-48-150;
        if (is_iphoneX) {
            height = DEAppHeight-95/2-88-48-34-150;
        }
        _waterView = [[ZJLabel alloc]initWithFrame:CGRectMake(0, 150, DEAppWidth, height)];
        _waterView.present = 1.0f;
    }
    return _waterView;
}
-(UILabel *)statuLb{
    if (_statuLb == nil) {
        _statuLb = [[UILabel alloc]init];
        _statuLb.text = @"未充电";
        _statuLb.textAlignment = NSTextAlignmentCenter;
        _statuLb.textColor = LHColor(34, 34, 34);
        _statuLb.font = [UIFont systemFontOfSize:23];
    }
    return _statuLb;
}
-(UILabel *)volLb{
    if (_volLb == nil) {
        _volLb = [[UILabel alloc]init];
        _volLb.textAlignment = NSTextAlignmentCenter;
        _volLb.text = @"电量 (度)";
        _volLb.textColor = LHColor(157, 157, 157);
        _volLb.font = [UIFont systemFontOfSize:13];
    }
    return _volLb;
}
-(UILabel *)consumeLb{
    if (_consumeLb == nil) {
        _consumeLb = [[UILabel alloc]init];
        _consumeLb.textAlignment = NSTextAlignmentCenter;
        _consumeLb.text = @"消费 (元)";
        _consumeLb.textColor = LHColor(157, 157, 157);
        _consumeLb.font = [UIFont systemFontOfSize:13];
    }
    return _consumeLb;
}
-(UILabel *)volValueLb{
    if (_volValueLb == nil) {
        _volValueLb = [[UILabel alloc]init];
        _volValueLb.textAlignment = NSTextAlignmentCenter;
        _volValueLb.text = @"0.00";
        _volValueLb.textColor = LHColor(34, 34, 34);
        _volValueLb.font = [UIFont systemFontOfSize:24];
    }
    return _volValueLb;
}
-(UILabel *)consumeValueLb{
    if (_consumeValueLb == nil) {
        _consumeValueLb = [[UILabel alloc]init];
        _consumeValueLb.textAlignment = NSTextAlignmentCenter;
        _consumeValueLb.text = @"0.00";
        _consumeValueLb.textColor = LHColor(34, 34, 34);
        _consumeValueLb.font = [UIFont systemFontOfSize:24];
    }
    return _consumeValueLb;
}
-(UILabel *)timeLb{
    if (_timeLb == nil) {
        _timeLb = [[UILabel alloc]init];
        _timeLb.textAlignment = NSTextAlignmentCenter;
        _timeLb.text = @"已充电时间 (时:分)";
        _timeLb.textColor = LHColor(255, 255, 255);
        _timeLb.font = [UIFont systemFontOfSize:13];
    }
    return _timeLb;
}
-(UILabel *)timeValueLb{
    if (_timeValueLb == nil) {
        _timeValueLb = [[UILabel alloc]init];
        _timeValueLb.textAlignment = NSTextAlignmentCenter;
        _timeValueLb.text = @"0:00";
        _timeValueLb.textColor = LHColor(255, 255, 255);
        _timeValueLb.font = [UIFont systemFontOfSize:50];
    }
    return _timeValueLb;
}
-(UIButton *)endBtn{
    if (_endBtn == nil) {
        _endBtn = [[UIButton alloc]init];
        [_endBtn addTarget:self action:@selector(clickTheEndbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_endBtn setTitle:@"结束充电" forState:UIControlStateNormal];
        [_endBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_endBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _endBtn.userInteractionEnabled = NO;
        _endBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _endBtn.backgroundColor = [UIColor clearColor];
        _endBtn.layer.cornerRadius = 76/4;
        _endBtn.layer.masksToBounds = YES;
        _endBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _endBtn.layer.borderWidth = 1.0f;
    }
    return _endBtn;
}
#pragma mark - 自定义Method
- (void)clickTheEndbtn:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"关闭当前充电" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self closeRealCharging];
    }];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}
//没有充电
- (void)pole_isNoCharge{
    self.waterView.present = 1;
    self.statuLb.text = @"未充电";
    self.volValueLb.text = @"0.00";
    self.consumeValueLb.text = @"0.00";
    self.timeValueLb.text = @"0.00";
    self.endBtn.userInteractionEnabled = NO;
}
//正在充电点
- (void)pole_isCharging:(NSDictionary *)dic{
    self.endBtn.userInteractionEnabled = YES;
    self.waterView.present = 0.9;
    self.statuLb.text = @"正在充电";
    float vol = [NSString stringWithFormat:@"%@",dic[@"kwh"]].floatValue;
    self.volValueLb.text = [NSString stringWithFormat:@"%.2f",vol];
    float money = [NSString stringWithFormat:@"%@",dic[@"money"]].floatValue;
    self.consumeValueLb.text =  [NSString stringWithFormat:@"%.2f",money];
    NSString *hour = [NSString stringWithFormat:@"%@",dic[@"hour"]];
    if (hour.length==1) {
        hour = [@"0" stringByAppendingString:hour];
    }
    NSString *min = [NSString stringWithFormat:@"%@",dic[@"minute"]];
    if (min.length==1) {
        min = [@"0" stringByAppendingString:min];
    }
    self.timeValueLb.text =  [NSString stringWithFormat:@"%@:%@",hour,min];
    self.endBtn.userInteractionEnabled = YES;
    
}
- (void) getSourceDic{
    NSString *cardNo= [CDUserInfor shareUserInfor].phoneNum;
    NSString *pass = [CDUserInfor shareUserInfor].userPword;
    __block typeof(self) weakself = self;
    [CDWebRequest requestgetStartChargingPoleidentity:@"1" cardNo:cardNo Pass:pass AndBack:^(NSDictionary *backDic) {
        NSArray *list = backDic[@"list"];
        if (list.count<1) {
            [weakself pole_isNoCharge];
        }else{
            NSString *poldId = [NSString stringWithFormat:@"%@",list.firstObject];
            
            [CDWebRequest requestgetRealByPoleIdid:poldId AndBack:^(NSDictionary *backDic) {
                
                [weakself pole_isCharging:backDic[@"poleReal"]];
            } failure:^(NSString *err) {
                
            }];
        }
        
    } failure:^(NSString *err) {
        [weakself pole_isNoCharge];
    }];
}

- (void)closeRealCharging{
    
    NSString *cardNo= [CDUserInfor shareUserInfor].phoneNum;
    NSString *pass = [CDUserInfor shareUserInfor].userPword;
    NSString *cardId = [CDUserInfor shareUserInfor].defaultCard;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.lastObject animated:YES];
    
    hud.label.text = @"正在关闭充电桩";
    [CDWebRequest requestgetStartChargingPoleidentity:@"1" cardNo:cardNo Pass:pass AndBack:^(NSDictionary *backDic) {
        
        NSArray *list = backDic[@"list"];
        if (list.count>0) {
            NSString *poldId = [NSString stringWithFormat:@"%@",list.firstObject];
            [CDWebRequest requestClosePoidWithidentity:@"1" poldId:poldId cardNo:cardNo Pass:pass cardId:(NSString *)cardId AndBack:^(NSDictionary *backDic) {
                hud.mode = MBProgressHUDModeCustomView;
                UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                hud.customView = [[UIImageView alloc] initWithImage:image];
                hud.label.text = @"关闭成功";
                [hud hideAnimated:YES afterDelay:1.5];
            } failure:^(NSString *err) {
                hud.label.text = err;
                [hud hideAnimated:YES afterDelay:1.5];
            }];
        }
    } failure:^(NSString *err) {
        hud.mode = MBProgressHUDModeCustomView;
        UIImage *image = [[UIImage imageNamed:@"ErrorMark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        hud.customView = [[UIImageView alloc]initWithImage:image];
        hud.label.text = @"关闭失败";
        [hud hideAnimated:YES afterDelay:1.5];
    }];
}
@end
