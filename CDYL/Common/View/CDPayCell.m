//
//  CDPayCell.m
//  CDYL
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDPayCell.h"
@interface CDPayCell ()
@property (nonatomic, strong) UIImageView *iconIg;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *lineLb;
@property (nonatomic, strong) UIImageView *selectIg;
@property (nonatomic, assign) NSUInteger row;
@end
@implementation CDPayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        [self addMasonrys];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.iconIg];
    [self.contentView addSubview:self.selectIg];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.lineLb];
}
- (void)addMasonrys{
    [self.iconIg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@22.5);
        make.left.equalTo(self.contentView).offset(17.5);
        make.centerY.equalTo(self.contentView);
    }];
    [self.selectIg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
        make.height.equalTo(@25);
        make.left.equalTo(self.iconIg.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    [self.lineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLb);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

-(UIImageView *)iconIg{
    if (_iconIg == nil) {
        _iconIg = [[UIImageView alloc]init];
        _iconIg.image = [UIImage imageNamed:@"alipayBg"];
    }
    return _iconIg;
}
-(UIImageView *)selectIg{
    if (_selectIg == nil) {
        _selectIg = [[UIImageView alloc]init];
        _selectIg.image = [UIImage imageNamed:@"selectBg"];
        _selectIg.hidden = YES;
    }
    return _selectIg;
}
-(UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.textColor = LHColor(34, 34, 34);
        _nameLb.font = [UIFont systemFontOfSize:17];
    }
    return _nameLb;
}

-(UILabel *)lineLb{
    if (_lineLb == nil) {
        _lineLb = [[UILabel alloc]init];
        _lineLb.backgroundColor = LHColor(226, 226, 226);
        _lineLb.hidden = YES;
    }
    return _lineLb;
}
- (void)reloadCellWith:(NSString *)name rowIndex:(NSUInteger)index{
    self.nameLb.text = name;
    if ([name isEqualToString:@"微信支付"]) {
        self.iconIg.image = [UIImage imageNamed:@"chatBg"];
    }
    if (index == 0) {
        self.lineLb.hidden  = NO;
        
    }
}
- (void)selectBgShow:(BOOL)showSelectBg{
    
    _Is_select = showSelectBg;
    self.selectIg.hidden =!showSelectBg;
}
-(void)setIs_select:(BOOL)Is_select{
    self.selectIg.hidden = YES;
}

@end
