//
//  CDBarView.m
//  CDYL
//
//  Created by admin on 2018/5/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBarView.h"
@interface CDBarView ()
@property (nonatomic, strong) UIButton *backbtn;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *downLb;
@end
@implementation CDBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = LHColor(247, 247, 247);
        [self addSubViews];
        [self add_masonrys];
    }
    return self;
}
- (void)addSubViews {
    [self addSubview:self.backbtn];
    [self addSubview:self.titleLb];
    [self addSubview:self.selectBtn];
    [self addSubview:self.downLb];
    
}
- (void)add_masonrys {
    [self.backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.width.equalTo(@24);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@150);
        make.height.equalTo(@24);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backbtn.mas_right).offset(10);
        make.width.equalTo(@61);
        make.height.equalTo(@24);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    [self.downLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
-(UIButton *)backbtn{
    if (_backbtn == nil) {
        _backbtn=[[UIButton alloc]init];
        
        [_backbtn addTarget:self action:@selector(clickTheBackBtn) forControlEvents:UIControlEventTouchUpInside];
        [_backbtn setBackgroundImage:[UIImage imageNamed:@"backBlack"] forState:UIControlStateNormal];
    }
    return _backbtn;
}
-(UILabel *)titleLb{
    if (_titleLb == nil) {
        _titleLb = [[UILabel alloc]init];
        _titleLb.textColor = LHColor(34, 34, 34);
        _titleLb.font = [UIFont systemFontOfSize:18];
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}
-(UILabel *)downLb{
    if (_downLb == nil) {
        _downLb = [[UILabel alloc]init];
        _downLb.backgroundColor = LHColor(187, 187, 187);
        
    }
    return _downLb;
}
-(UIButton *)selectBtn{
    if (_selectBtn == nil) {
        _selectBtn = [[UIButton alloc]init];
        [_selectBtn setImage:[UIImage imageNamed:@"selectAdd"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(didClickTheFunctionBtn) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.hidden = YES;
    }
    return _selectBtn;
}
- (void)clickTheBackBtn {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(popUpViewController)]) {
        [self.delegate popUpViewController];
    }
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
}
-(void)didClickTheFunctionBtn{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(didClickSelectButton)]) {
        [self.delegate didClickSelectButton];
    }
}
-(void)setIs_showFun:(BOOL)is_showFun{
    _is_showFun = is_showFun;
    self.selectBtn.hidden  = !is_showFun;
    
}
-(void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    [self.selectBtn setImage:bgImage forState:UIControlStateNormal];
}
@end
