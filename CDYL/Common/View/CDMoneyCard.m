//
//  CDMoneyCard.m
//  CDYL
//
//  Created by admin on 2018/5/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDMoneyCard.h"

@interface CDMoneyCard ()

/**卡背景**/
@property (nonatomic, strong) UIImageView *bgiv;
/**￥**/
@property (nonatomic, strong) UIImageView *moneyiv;
/**卡id**/
@property (nonatomic, strong) UILabel     *cardIdLb;
/**卡金额**/
@property (nonatomic, strong) UILabel     *moneyLb;
/**btn**/
@property (nonatomic, strong) UIButton    *defaultBtn;
@end

@implementation CDMoneyCard
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgiv];
        [self addSubview:self.cardIdLb];
        [self addSubview:self.defaultBtn];
        [self addSubview:self.moneyLb];
        [self addSubview:self.moneyiv];
        [self add_subMasonry];
    }
    return self;
}
- (void)add_subMasonry {
    [self.bgiv mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.bottom.mas_equalTo(self);
         make.left.mas_equalTo(self).offset(20);
         make.right.mas_equalTo(self).offset(-20);
    }];
    [self.cardIdLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgiv).offset(25);
        make.top.mas_equalTo(self.bgiv.mas_top).offset(30);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    [self.defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardIdLb);
        make.right.equalTo(self.bgiv.mas_right).offset(-25);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgiv.mas_bottom).offset(-20);
        make.right.equalTo(self.defaultBtn.mas_right);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    [self.moneyiv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moneyLb.mas_centerY);
        make.right.equalTo(self.moneyLb.mas_left).offset(-10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}


-(UIImageView *)bgiv{
    if (_bgiv == nil) {
        _bgiv = [[UIImageView alloc]init];
        _bgiv.image = [UIImage imageNamed:@"default_card"];
        _bgiv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheCard)];
        [self addGestureRecognizer:tap];
    }
    return _bgiv;
}
-(UIImageView *)moneyiv{
    if (_moneyiv == nil) {
        _moneyiv = [[UIImageView alloc]init];
        _moneyiv.image = [UIImage imageNamed:@"money_icon"];
    }
    return _moneyiv;
}
-(UILabel *)cardIdLb{
    if (_cardIdLb == nil) {
        _cardIdLb = [[UILabel alloc]init];
        _cardIdLb.font = [UIFont systemFontOfSize:17];
        _cardIdLb.textColor = LHColor(255, 255, 255);
    }
    return _cardIdLb;
}
-(UILabel *)moneyLb{
    if (_moneyLb == nil) {
        _moneyLb = [[UILabel alloc]init];
        _moneyLb.font = [UIFont systemFontOfSize:33];
        _moneyLb.textColor = LHColor(255, 255, 255);
    }
    return _moneyLb;
}
-(UIButton *)defaultBtn{
    if (_defaultBtn == nil) {
        _defaultBtn = [[UIButton alloc]init];
        [_defaultBtn setImage:[UIImage imageNamed:@"default_btn"] forState:UIControlStateNormal];
        [_defaultBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultBtn;
}
-(void)setModel:(CDMoneyCardInfor *)model{
    _model = model;
    self.cardIdLb.text = model.cardno;
    self.moneyLb.text = model.haveMoney;
    if (!model.isdefaultt) {
        [self changeImage];
    }
}
- (void)changeImage{
    self.bgiv.image = [UIImage imageNamed:@"nodefault_card"];
    [self.defaultBtn setImage:[UIImage imageNamed:@"nodefault_btn"] forState:UIControlStateNormal];
}
- (void)clickBtn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheDefaultButton:)]) {
        [self.delegate clickTheDefaultButton:self.model];
    }
}
- (void)tapTheCard {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheMoneyCard:)]) {
        [self.delegate clickTheMoneyCard:self.model];
    }
}
@end
