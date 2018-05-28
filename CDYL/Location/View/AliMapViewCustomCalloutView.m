//
//  AliMapViewCustomCalloutView.m
//  AliMapKit
//
//  Created by 夏远全 on 16/12/12.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//  自定义气泡

#import "AliMapViewCustomCalloutView.h"
#import <Masonry.h>
#import "UIView+PYExtension.h"

#define CanTouchColor LHColor(22, 177, 184)
#define CanntTouchColor LHColor(192, 192, 192)

@interface AliMapViewCustomCalloutView ()

/**充电点**/
@property (nonatomic, strong) UILabel *name;
/**充电地址**/
@property (nonatomic, strong) UILabel  * addre;
/**充电距离**/
@property (nonatomic, strong) UILabel *distance;
/**运营单位**/
@property (nonatomic, strong) UILabel *companyName;
/**是否收藏过**/
@property (nonatomic, assign) BOOL is_Collection;
/**是否能预约**/
@property (nonatomic, assign) BOOL is_Appointment;
@property (nonatomic, strong) UIButton *appBtn;


@end

@implementation AliMapViewCustomCalloutView


//初始化内容
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    UILabel *lb=[[UILabel alloc]init];
    lb.text=@"保税物流站点";
    lb.font=[UIFont systemFontOfSize:15];
    lb.textAlignment=NSTextAlignmentLeft;
    lb.textColor=[UIColor blackColor];
    [self addSubview:lb];
    lb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheLabel:)];
    [lb addGestureRecognizer:tap];
    self.name = lb;
   
    UILabel *server=[[UILabel alloc]init];
    server.text=@"服务 ⭐⭐⭐⭐⭐";
//    server.backgroundColor = [UIColor blackColor];
    server.font=[UIFont systemFontOfSize:14];
    server.textAlignment=NSTextAlignmentLeft;
    server.textColor=[UIColor blackColor];
    [self addSubview:server];
    
    UILabel *addre=[[UILabel alloc]init];
    addre.text=@"浙江杭州十一号大街";
//    addre.backgroundColor = [UIColor blackColor];
    addre.font=[UIFont systemFontOfSize:14];
    addre.textAlignment=NSTextAlignmentLeft;
    addre.textColor=[UIColor blackColor];
    [self addSubview:addre];
    self.addre = addre;
    
    UILabel *distance=[[UILabel alloc]init];
    distance.text=@"1.32km";
//    distance.backgroundColor = [UIColor blackColor];
    distance.font=[UIFont systemFontOfSize:14];
    distance.textAlignment=NSTextAlignmentLeft;
    distance.textColor=[UIColor blackColor];
    [self addSubview:distance];
    self.distance = distance;
    
    UILabel *company=[[UILabel alloc]init];
    company.text=@"运营单位：硕维新能源技术有限公司";
//    company.backgroundColor = [UIColor blackColor];
    company.font=[UIFont systemFontOfSize:14];
    company.textAlignment=NSTextAlignmentLeft;
    company.textColor=[UIColor blackColor];
    [self addSubview:company];
    self.companyName = company;
    
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self).offset(10);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(25);
    }];
    [server mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(lb.mas_bottom).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(25);
    }];
    [addre mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(server.mas_bottom).offset(0);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(25);
    }];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(addre.mas_bottom).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    [company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(distance.mas_bottom).offset(0);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(25);
    }];
    
    UIButton *collectBtn=[[UIButton alloc]init];
    collectBtn.backgroundColor = CanTouchColor;
    collectBtn.titleLabel.textColor=[UIColor whiteColor];
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
    collectBtn.layer.cornerRadius=4;
    [self addSubview:collectBtn];
    
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self).offset(15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *navigaBtn = [[UIButton alloc]init];
    navigaBtn.backgroundColor = CanTouchColor;
    navigaBtn.titleLabel.textColor=[UIColor whiteColor];
    [navigaBtn setTitle:@"导航" forState:UIControlStateNormal];
    [navigaBtn addTarget:self action:@selector(clickTheNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
    navigaBtn.layer.cornerRadius=4;
    [self addSubview:navigaBtn];
   
    CGFloat width = self.py_width/2;
    [navigaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(- width -10);
        make.top.mas_equalTo(company.mas_bottom).offset(15);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *appointmentBtn = [[UIButton alloc]init];
    appointmentBtn.backgroundColor = CanTouchColor;
    appointmentBtn.titleLabel.textColor=[UIColor whiteColor];
    [appointmentBtn setTitle:@"预约" forState:UIControlStateNormal];
    [appointmentBtn addTarget:self action:@selector(clickTheAppBtn:) forControlEvents:UIControlEventTouchUpInside];
    appointmentBtn.layer.cornerRadius=4;
    [self addSubview:appointmentBtn];
    self.appBtn = appointmentBtn;
   
    [appointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.left.mas_equalTo(self).offset(width +10);
        make.top.mas_equalTo(company.mas_bottom).offset(15);
        make.height.mas_equalTo(30);
    }];
}

-(void)setStationModel:(CDStation *)stationModel{
    _stationModel = stationModel;
    
    self.name.attributedText = [self showString:stationModel.name];
    self.addre.text = stationModel.addr;
    self.distance.text = stationModel.distance;
    self.is_Appointment = [stationModel.canOrder isEqualToString:@"can"]? YES :NO ;
    if (!self.is_Appointment) {
        self.appBtn.backgroundColor = CanntTouchColor;
        self.appBtn.userInteractionEnabled = NO;
    }
    
    
    
}
#pragma mark - method
-(NSMutableAttributedString *)showString:(NSString *)str{
    
    NSDictionary *dic = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName : CanTouchColor,NSFontAttributeName : [UIFont systemFontOfSize:16]};
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:str attributes:dic];
    return attribute;
    
}
#pragma mark - 点击事件
- (void)clickTheBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(stationModel:didCollection:)]) {
        [self.delegate stationModel:self.stationModel didCollection:YES];
    }
}
- (void)clickTheNaviBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(stationModel:didNavigationBtn:)]) {
        [self.delegate stationModel:self.stationModel didNavigationBtn:YES];
    }
}
- (void)clickTheAppBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(stationModel:didAppointmentBtn:)]) {
        [self.delegate stationModel:self.stationModel didAppointmentBtn:YES];
    }
}
- (void)clickTheLabel:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(stationModel:didTouchHightLightLabel:)]) {
        [self.delegate stationModel:self.stationModel didTouchHightLightLabel:YES];
    }
}



@end
