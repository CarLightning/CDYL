//
//  CDPoleCell.m
//  CDYL
//
//  Created by admin on 2018/5/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDPoleCell.h"
@interface CDPoleCell()
@property (nonatomic, strong) UIImageView *showIg;
/**名字**/
@property (nonatomic, strong) UILabel *nameLb;
/**电压电流**/
@property (nonatomic, strong) UILabel *electricLb;
/**状态**/
@property (nonatomic, strong) UILabel *statusLb;
/**预约**/
@property (nonatomic, strong) UIButton *bespeakBtn;
@end

@implementation CDPoleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubInfor];
        [self addSubMasonry];
    }
    return self;
}
- (void)addSubInfor {
    [self.contentView addSubview:self.showIg];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.electricLb];
    [self.contentView addSubview:self.statusLb];
    [self.contentView addSubview:self.bespeakBtn];
    
    
    
}
-(void)setModel:(CDPoliList *)model{
    _model = model;
    self.nameLb.text = model.name;
    NSString * text = [model.poleType componentsSeparatedByString:@"瓦/"].lastObject;
    self.electricLb.text = text;
//    1、充电中
//    2、空闲
//    3、故障
//    4、离线
//    5、就绪
//    6、预约中
    
    switch (model.status) {
        case 1:
            self.statusLb.text = @"充电中";
            break;
        case 2:
            self.statusLb.text = @"空闲";
            break;
        case 3:
            self.statusLb.text = @"故障";
            break;
        case 4:
            self.statusLb.text = @"离线";
            break;
        case 5:{
            self.statusLb.text = @"就绪";
           self.bespeakBtn.userInteractionEnabled = YES;
            self.bespeakBtn.backgroundColor = LHColor(22, 177, 184);
        }
            break;
        case 6:
            self.statusLb.text = @"预约中";
            break;
    }
}
- (void)addSubMasonry {
   
    [self.showIg mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(8);
        make.width.height.equalTo(@60);
        
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showIg.mas_right).offset(10);
        make.top.equalTo(self.showIg.mas_top).offset(5);
        make.width.equalTo(@250);
        make.height.equalTo(@20);
    }];
    [self.electricLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.nameLb);
        make.top.equalTo(self.nameLb.mas_bottom).offset(10);
        make.width.equalTo(@250);
        make.height.equalTo(@20);
    }];
    [self.statusLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.nameLb);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    [self.bespeakBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.statusLb);
        make.top.equalTo(self.statusLb.mas_bottom).offset(5);
        make.bottom.equalTo(self).offset(-8);
         make.width.equalTo(@70);
    }];
    
}




- (UIImageView *)showIg{
    if (_showIg == nil) {
        _showIg = [[UIImageView alloc]init];
        _showIg.image = [UIImage imageNamed:@"poleBg.png"];
    }
    return _showIg;
}

- (UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb =[[UILabel alloc]init];
        _nameLb.textAlignment=NSTextAlignmentLeft;
        _nameLb.font=[UIFont systemFontOfSize:13];
        _nameLb.textColor=[UIColor blackColor];
    }
    return _nameLb;
}
- (UILabel *)electricLb{
    if (_electricLb == nil) {
        _electricLb =[[UILabel alloc]init];
        _electricLb.textAlignment=NSTextAlignmentLeft;
        _electricLb.font=[UIFont systemFontOfSize:12];
        _electricLb.textColor=[UIColor grayColor];
    }
    return _electricLb;
}
- (UILabel *)statusLb{
    if (_statusLb == nil) {
        _statusLb =[[UILabel alloc]init];
        _statusLb.textAlignment=NSTextAlignmentCenter;
        _statusLb.font=[UIFont systemFontOfSize:13];
        _statusLb.textColor=[UIColor blackColor];
    }
    return _statusLb;
}

- (UIButton *)bespeakBtn{
    if (_bespeakBtn == nil) {
        _bespeakBtn = [[UIButton alloc]init];
        _bespeakBtn.backgroundColor = LHColor(111, 113, 121);
        _bespeakBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_bespeakBtn setTitle:@"预约" forState:UIControlStateNormal];
        [_bespeakBtn addTarget:self action:@selector(clickThtBtn:) forControlEvents:UIControlEventTouchUpInside];
        _bespeakBtn.layer.cornerRadius =4;
        _bespeakBtn.layer.masksToBounds = YES;
        _bespeakBtn.userInteractionEnabled = NO;
    }
    return _bespeakBtn;
}
- (void)clickThtBtn:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheBespeakBtn)]) {
        [self.delegate clickTheBespeakBtn];
    }
}
@end
