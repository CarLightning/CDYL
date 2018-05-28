//
//  CDCellView.m
//  CDYL
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDCellView.h"
@interface CDCellView ()
@property (nonatomic, strong) UILabel *upLb;
@property (nonatomic, strong) UILabel *lineLb;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *showIg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, assign) NSUInteger row;
@end

@implementation CDCellView

-(instancetype)initWithFrame:(CGRect)frame showUpLb:(BOOL)showUp showLineLb:(BOOL)showline cellName:(NSString *)nameStr{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self add_masonryshowUpLb:showUp showLineLb:showline];
        [self updataImage:nameStr];
       
    }
    return self;
}

- (void)updataImage:(NSString *)str{
    self.nameLb.text = str;
    if ([str isEqualToString:@"钱包"]) {
        self.showIg.image = [UIImage imageNamed:@"moneyIcon"];
        self.row = 0;
    }else if ([str isEqualToString:@"收藏"]){
        self.showIg.image = [UIImage imageNamed:@"collecIcon"];
        self.row = 1;
    }else{
       self.showIg.image = [UIImage imageNamed:@"setIcon"];
        self.row = 2;
    }
}
- (void)addSubViews{
    [self addSubview:self.upLb];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.showIg];
    [self.contentView addSubview:self.nameLb];
    [self addSubview:self.lineLb];
}
- (void)add_masonryshowUpLb:(BOOL)showUp showLineLb:(BOOL)showline{
    [self.upLb mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.top.equalTo(self);
        if (showUp) {
            make.height.equalTo(@15);
        }else{
             make.height.equalTo(@0);
        }
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.upLb.mas_bottom);
        make.height.equalTo(@48);
    }];
    
    [self.showIg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self.contentView);
       
        make.height.width.equalTo(@20);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showIg.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@120);
        make.height.equalTo(@20);
       
    }];
    
    
    [self.lineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.contentView.mas_bottom).offset(-0.5);
        if (showline) {
           make.height.equalTo(@0.5);
        }else{
            make.height.equalTo(@0);
        }
    }];
}
-(UILabel *)upLb{
    if (_upLb == nil) {
        _upLb = [[UILabel alloc]init];
        _upLb.backgroundColor = LHColor(226, 226, 226);
    }
    return _upLb;
}
-(UILabel *)lineLb{
    if (_lineLb == nil) {
        _lineLb = [[UILabel alloc]init];
        _lineLb.backgroundColor = LHColor(226, 226, 226);
    }
    return _lineLb;
}
- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheRow)];
        [_contentView addGestureRecognizer:tap];
        
    }
    return _contentView;
}
-(UIImageView *)showIg{
    if (_showIg == nil) {
        _showIg = [[UIImageView alloc]init];
        
    }
    return _showIg;
}
-(UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.textColor = LHColor(34, 34, 34);
        _nameLb.font = [UIFont systemFontOfSize:17];
    }
    return _nameLb;
}
- (void)tapTheRow{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(userTapTheCellIndex:)]) {
        [self.delegate userTapTheCellIndex:self.row];
    }
}
@end
