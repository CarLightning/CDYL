//
//  CDBgVIew.m
//  CDYL
//
//  Created by admin on 2018/6/6.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBgVIew.h"
@interface CDBgVIew()
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UIImageView *bgIgView;
@property (nonatomic, strong) UIButton *consumeBtn;
@property (nonatomic, strong) UIButton *rechargeBtn;
@end
@implementation CDBgVIew

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self addMansonrys];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheView)];
        [self addGestureRecognizer:tap];
      
        self.alpha = 0;
    }
    return self;
}
- (void)addSubViews{
    [self addSubview:self.bigView];
    [self addSubview:self.bgIgView];
    [self addSubview:self.rechargeBtn];
    [self addSubview:self.consumeBtn];
}
- (void)addMansonrys{
    [self.bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    [self.bgIgView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat block = 64-9;
        if (is_iphoneX) {
            block=88-9;
        }
        make.top.equalTo(self).offset(block);
        make.left.equalTo(self).offset(57);
        make.width.equalTo(@100);
        make.height.equalTo(@105);
    }];
    [self.consumeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgIgView);
        make.height.equalTo(@50);
        make.bottom.equalTo(self.rechargeBtn.mas_top);
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.bgIgView);
        make.height.equalTo(@45);
        make.bottom.equalTo(self.bgIgView.mas_bottom);
    }];
    
}

- (UIView *)bigView{
    if (_bigView == nil) {
        _bigView = [[UIView alloc]init];
        _bigView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.5f];
        
    }
    return _bigView;
}
- (UIImageView *)bgIgView{
    if (_bgIgView == nil) {
        _bgIgView = [[UIImageView alloc]init];
        _bgIgView.image =[UIImage imageNamed:@"ConsumeIcon"];
        _bgIgView.userInteractionEnabled= YES;
    }
    return _bgIgView;
}
- (UIButton *)consumeBtn{
    if (_consumeBtn == nil) {
        _consumeBtn = [[UIButton alloc]init];
        [_consumeBtn addTarget:self action:@selector(didClickUpBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _consumeBtn;
}
- (UIButton *)rechargeBtn{
    if (_rechargeBtn == nil) {
        _rechargeBtn = [[UIButton alloc]init];
        [_rechargeBtn addTarget:self action:@selector(didClickDownBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
}

- (void) didClickDownBtn{
    if (self.delagate &&[self.delagate respondsToSelector:@selector(clickTheRechargeRecordBtn)]) {
        [self.delagate clickTheRechargeRecordBtn];
    }
}
- (void) didClickUpBtn{
    if (self.delagate &&[self.delagate respondsToSelector:@selector(clickTheConsumeRecordBtn)]) {
        [self.delagate clickTheConsumeRecordBtn];
    }
}
- (void)hiddenTheAlert{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}
- (void)showTheAlert{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)tapTheView{
    [self hiddenTheAlert];
}
@end
