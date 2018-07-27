//
//  CDBespeakView.m
//  CDYL
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBespeakView.h"
@interface CDBespeakView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *detailName;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *comparyLb;
@property (nonatomic, strong) UILabel *comparyName;
@property (nonatomic, strong) UILabel *statrLn;
@property (nonatomic, strong) UILabel *statrname;
@property (nonatomic, strong) UILabel *endLb;
@property (nonatomic, strong) UILabel *endName;
@property (nonatomic, strong) UILabel *allLb;
@property (nonatomic, strong) UILabel *allName;
@property (nonatomic, strong) UIButton *nowChargeBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UILabel *disLb;

@end
@implementation CDBespeakView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self addMasonrys];
       
    }
    return self;
}
- (void)addSubViews{
    self.backgroundColor = LHColor(255, 255, 255);
    [self addSubview:self.bgView];
    [self addSubview:self.detailName];
    [self addSubview:self.name];
    [self addSubview:self.line];
    [self addSubview:self.comparyLb];
    [self addSubview:self.comparyName];
    [self addSubview:self.statrLn];
    [self addSubview:self.statrname];
    [self addSubview:self.endLb];
    [self addSubview:self.endName];
    [self addSubview:self.allLb];
    [self addSubview:self.allName];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.nowChargeBtn];
    [self addSubview:self.collectBtn];
    [self addSubview:self.disLb];
}


- (void)addMasonrys{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@246);
    }];
    [self.detailName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@15);
    }];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.detailName);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-80);
        make.top.equalTo(self.detailName.mas_bottom).offset(15);
        
        make.height.equalTo(@20);
    }];
    [self.disLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.name);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(92);
        make.height.equalTo(@0.5);
    }];
    [self.comparyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self.line.mas_bottom).offset(15.5);
        make.width.equalTo(@60);
        make.height.equalTo(@13);
    }];
    [self.comparyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self.comparyLb);
        make.width.equalTo(@200);
        make.height.equalTo(@13);
    }];
    [self.statrLn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self.comparyLb.mas_bottom).offset(12);
        make.width.equalTo(@60);
        make.height.equalTo(@13);
    }];
    [self.statrname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self.statrLn);
        make.width.equalTo(@200);
        make.height.equalTo(@13);
    }];
    [self.endLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self.statrLn.mas_bottom).offset(12);
        make.width.equalTo(@60);
        make.height.equalTo(@13);
    }];
    [self.endName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self.endLb);
        make.width.equalTo(@200);
        make.height.equalTo(@13);
    }];
    [self.allLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self.endLb.mas_bottom).offset(12);
        make.width.equalTo(@60);
        make.height.equalTo(@13);
    }];
    [self.allName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self.allLb);
        make.width.equalTo(@200);
        make.height.equalTo(@13);
    }];
     CGFloat Wight = DEAppWidth/2-20;
    [self.nowChargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(Wight);
        make.height.mas_equalTo(41);
        
    }];
   
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo(Wight);
        make.height.mas_equalTo(41);
    }];
}

#pragma mark - Get Method
-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = LHColor(255, 255, 255);
    }
    return _bgView;
}
-(UILabel *)detailName{
    if (_detailName == nil) {
        _detailName = [[UILabel alloc]init];
        _detailName.textAlignment = NSTextAlignmentLeft;
        _detailName.textColor = LHColor(34, 34, 34);
        _detailName.font = [UIFont systemFontOfSize:17];
    }
    return _detailName;
}
-(UILabel *)name{
    if (_name == nil) {
        _name = [[UILabel alloc]init];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.textColor = LHColor(157, 157, 157);
        _name.numberOfLines = 0;
        _name.font = [UIFont systemFontOfSize:13];
    }
    return _name;
}
-(UILabel *)disLb{
    if (_disLb == nil) {
        _disLb = [[UILabel alloc]init];
        _disLb.textAlignment = NSTextAlignmentRight;
        _disLb.textColor = LHColor(157, 157, 157);
        _disLb.font = [UIFont systemFontOfSize:12];
    }
    return _disLb;
}
-(UILabel *)line{
    if (_line == nil) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = LHColor(157, 157, 157);
    }
    return _line;
}
-(UILabel *)comparyLb{
    if (_comparyLb == nil) {
        _comparyLb = [[UILabel alloc]init];
        _comparyLb.textAlignment = NSTextAlignmentLeft;
        _comparyLb.text = @"运营商";
        _comparyLb.textColor = LHColor(157, 157, 157);
        _comparyLb.font = [UIFont systemFontOfSize:13];
    }
    return _comparyLb;
}
-(UILabel *)comparyName{
    if (_comparyName == nil) {
        _comparyName = [[UILabel alloc]init];
        _comparyName.textAlignment = NSTextAlignmentLeft;
        _comparyName.textColor = LHColor(34, 34, 34);
        _comparyName.font = [UIFont systemFontOfSize:13];
    }
    return _comparyName;
}
-(UILabel *)statrLn{
    if (_statrLn == nil) {
        _statrLn = [[UILabel alloc]init];
        _statrLn.textAlignment = NSTextAlignmentLeft;
        _statrLn.text = @"开始时间";
        _statrLn.textColor = LHColor(157, 157, 157);
        _statrLn.font = [UIFont systemFontOfSize:13];
    }
    return _statrLn;
}
-(UILabel *)statrname{
    if (_statrname == nil) {
        _statrname = [[UILabel alloc]init];
        _statrname.textAlignment = NSTextAlignmentLeft;
        _statrname.textColor = LHColor(34, 34, 34);
        _statrname.font = [UIFont systemFontOfSize:13];
    }
    return _statrname;
}
-(UILabel *)endLb{
    if (_endLb == nil) {
        _endLb = [[UILabel alloc]init];
        _endLb.textAlignment = NSTextAlignmentLeft;
        _endLb.text = @"结束时间";
        _endLb.textColor = LHColor(157, 157, 157);
        _endLb.font = [UIFont systemFontOfSize:13];
    }
    return _endLb;
}
-(UILabel *)endName{
    if (_endName == nil) {
        _endName = [[UILabel alloc]init];
        _endName.textAlignment = NSTextAlignmentLeft;
        _endName.textColor = LHColor(34, 34, 34);
        _endName.font = [UIFont systemFontOfSize:13];
    }
    return _endName;
}
-(UILabel *)allLb{
    if (_allLb == nil) {
        _allLb = [[UILabel alloc]init];
        _allLb.textAlignment = NSTextAlignmentLeft;
        _allLb.text = @"充电时长";
        _allLb.textColor = LHColor(157, 157, 157);
        _allLb.font = [UIFont systemFontOfSize:13];
    }
    return _allLb;
}
-(UILabel *)allName
{
    if (_allName == nil) {
        _allName = [[UILabel alloc]init];
        _allName.textAlignment = NSTextAlignmentLeft;
        _allName.textColor = LHColor(34, 34, 34);
        _allName.font = [UIFont systemFontOfSize:13];
    }
    return _allName;
}
-(UIButton *)nowChargeBtn
{
    if (_nowChargeBtn == nil) {
        _nowChargeBtn = [[UIButton alloc]init];
     
        _nowChargeBtn.tag = 10;
      
   
        [_nowChargeBtn addTarget:self action:@selector(clickTheNowBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_nowChargeBtn setBackgroundImage:[UIImage imageNamed:@"nowCharge"] forState:UIControlStateNormal];
        
    }
    return _nowChargeBtn;
}
-(UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc]init];
       
         _cancelBtn.tag = 15;
       
        [_cancelBtn addTarget:self action:@selector(clickTheNowBtn:) forControlEvents:UIControlEventTouchUpInside];
       [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancleBeSpeak"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

-(UIButton *)collectBtn
{
    if (_collectBtn == nil) {
        _collectBtn = [[UIButton alloc]init];
        
        _collectBtn.tag = 20;
        
        [_collectBtn addTarget:self action:@selector(clickTheNowBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
         [_collectBtn setBackgroundImage:[UIImage imageNamed:@"selectCollection"] forState:UIControlStateHighlighted];
    }
    return _collectBtn;
}

- (void)clickTheNowBtn:(UIButton *)btn{
    if (self.delagate &&[self.delagate respondsToSelector:@selector(userDidClickTheBtn:CDBespeakModel:)]) {
        [self. delagate userDidClickTheBtn:btn CDBespeakModel:_model];
    }
}
-(void)setModel:(CDBespeakModel *)model{
    _model = model;
    self.detailName.text = model.detailName;
    self.name.text = model.name;
    self.comparyName.text = model.comparyName;
    self.statrname.text = model.startTime;
    self.endName.text = model.endTime;
    self.allName.text = model.allTime;
    self.disLb.text = model.distance;
}
@end
