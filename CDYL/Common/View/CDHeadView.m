//
//  CDHeadView.m
//  CDYL
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 admin. All rights reserved.
//
#import "CDHeadView.h"
@interface CDHeadView ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *phoneLb;
@property (nonatomic, strong) UIButton *editBtn;
@end
@implementation CDHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self add_Masonry];
        [self reloadData];
    }
    return self;
}
- (void)addSubViews {
    [self addSubview:self.bgView];
    [self addSubview:self.headView];
    [self addSubview:self.nameLb];
    [self addSubview:self.phoneLb];
    [self addSubview:self.editBtn];
}
- (void)add_Masonry {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
        
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self).offset(19);
         make.bottom.equalTo(self).offset(-30);
         make.width.height.equalTo(@83);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_top).offset(15);
        make.left.equalTo(self.headView.mas_right).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@25);
    }];
    [self.phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.right.equalTo(self);
        make.top.equalTo (self.nameLb.mas_bottom).offset(10);
        make.height.equalTo(@20);
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self).offset(-15);
         make.bottom.equalTo(self).offset(-15);
        make.width.height.equalTo(@20);
    }];
}
- (void)reloadData {
    NSString *file =[[NSFileManager defaultManager] headImagePath:NO];
    BOOL headPath = [[NSFileManager defaultManager]fileExistsAtPath:file];
    if (headPath) {
        NSData *data = [[NSFileManager defaultManager]contentsAtPath:file];
        self.headView.image = [[UIImage alloc]initWithData:data];
    }else{
        self.headView.image = [UIImage imageNamed:@"headIg"];
    }
    self.nameLb.text = [CDUserInfor shareUserInfor].userName;
    self.phoneLb.text = [NSString stringWithFormat:@"手机号 %@",[CDUserInfor shareUserInfor].phoneNum];
}
-(UIImageView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"headImage"];
    }
    return _bgView;
}
-(UIImageView *)headView{
    if (_headView == nil) {
        _headView = [[UIImageView alloc]init];
        _headView.layer.cornerRadius = 83/2;
        _headView.layer.masksToBounds = YES;
    }
    return _headView;
}
-(UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.font = [UIFont systemFontOfSize:21];
        _nameLb.textColor = LHColor(34, 34, 34);
    }
    return _nameLb;
}
-(UILabel *)phoneLb{
    if (_phoneLb == nil) {
        _phoneLb = [[UILabel alloc]init];
        _phoneLb.font = [UIFont systemFontOfSize:13];
        _phoneLb.textColor = LHColor(109, 109, 109);
    }
    return _phoneLb;
}
-(UIButton *)editBtn {
    if (_editBtn == nil) {
        _editBtn = [[UIButton alloc]init];
        [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(clickTheBtn) forControlEvents:UIControlEventTouchUpInside];;
    }
    return _editBtn;
}
- (void)clickTheBtn {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(didClickTheEditBtn)]) {
        [self.delegate didClickTheEditBtn];
    }
}
@end
