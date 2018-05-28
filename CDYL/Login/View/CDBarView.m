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
@end
@implementation CDBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
        [self add_masonrys];
    }
    return self;
}
- (void)addSubViews {
    [self addSubview:self.backbtn];
    [self addSubview:self.titleLb];
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
- (void)clickTheBackBtn {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(popUpViewController)]) {
        [self.delegate popUpViewController];
    }
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
}
@end
