//
//  CDcell.m
//  CDYL
//
//  Created by admin on 2018/5/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDcell.h"
@interface CDcell ()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UIImageView *backIg;
@end
@implementation CDcell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameLb];
        [self addSubview:self.backIg];
        [self add_mansonrys];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)add_mansonrys {
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    [self.backIg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
}
- (UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.textColor = LHColor(34, 34, 34);
        _nameLb.font = [UIFont systemFontOfSize:20];
        _nameLb.text = @"充值";
    }
   return  _nameLb;
}
-(UIImageView *)backIg {
    if (_backIg == nil) {
        _backIg = [[UIImageView alloc]init];
        _backIg.image = [UIImage imageNamed:@"rightBack"];
    }
    return _backIg;
}
- (void)tapTheView{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(jumpToAddmoney)]) {
        [self.delegate jumpToAddmoney];
    }
}
@end
