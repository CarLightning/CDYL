//
//  CDShowCell.m
//  CDYL
//
//  Created by admin on 2018/5/11.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDShowCell.h"
@interface CDShowCell()

/**展示图片**/
@property (nonatomic, strong) UIImageView *showImage;
/**名称**/
@property (nonatomic, strong) UILabel *nameLb;
/**桩的数量**/
@property (nonatomic, strong) UILabel *havePoliLb;

/**位置**/
@property (nonatomic, strong) UILabel *locationLb;
/**距离**/
@property (nonatomic, strong) UILabel *distanceLb;
/**导航**/
@property (nonatomic, strong) UIButton *navigaBtn;
/**预约**/
@property (nonatomic, strong) UIButton *collecBtn;

@end

@implementation CDShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubInfor];
        [self addSubMasonry];
    }
    return self;
}
- (void)addSubInfor {
    [self.contentView addSubview:self.showImage];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.havePoliLb];
    [self.contentView addSubview:self.locationLb];
    [self.contentView addSubview:self.distanceLb];
    [self.contentView addSubview:self.navigaBtn];
    [self.contentView addSubview:self.collecBtn];
    
    
}
-(void)setModel:(CDStation *)model{
    _model = model;
    self.nameLb.text = model.name;
    self.distanceLb.text = model.distance;
    self.locationLb.text = model.addr;
    NSString *groudipo = [NSString stringWithFormat:@"%ld",model.polelist.count];
    self.havePoliLb.text = [NSString stringWithFormat:@"交流桩%@个，直流桩0个",groudipo];
}
- (void)addSubMasonry {
    float btnWidht = (DEAppWidth-30)/2 ;
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.height.equalTo(@80);
        
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showImage.mas_right).offset(10);
        make.top.equalTo(self.showImage);
        make.right.equalTo(self).offset(-50);
        make.height.equalTo(@20);
    }];
    [self.havePoliLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.showImage.mas_right).offset(10);
        make.top.equalTo(self.nameLb.mas_bottom).offset(0);
        make.right.equalTo(self).offset(-50);
        make.height.equalTo(@20);
    }];
    [self.locationLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.showImage.mas_right).offset(10);
        make.top.equalTo(self.havePoliLb.mas_bottom).offset(0);
        make.right.equalTo(self).offset(-50);
        make.height.equalTo(@20);
    }];
    [self.distanceLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.showImage.mas_right).offset(10);
        make.top.equalTo(self.locationLb.mas_bottom).offset(0);
        make.right.equalTo(self).offset(-50);
        make.height.equalTo(@20);
    }];
    [self.navigaBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.showImage);
        make.top.equalTo(self.showImage.mas_bottom).offset(10);
        make.width.mas_equalTo(btnWidht);
        make.height.equalTo(@28);
    }];
    [self.collecBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.navigaBtn.mas_right).offset(10);
        make.top.equalTo(self.navigaBtn);
        make.width.mas_equalTo(btnWidht);
        make.height.equalTo(@28);
    }];
    
}

- (UIImageView *)showImage{
    if (_showImage == nil) {
        _showImage = [[UIImageView alloc]init];
//        _showImage.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
        _showImage.image = [UIImage imageNamed:@"showIpo.jpg"];
        _showImage.layer.cornerRadius = 3;
        _showImage.layer.masksToBounds=YES;
    }
    return _showImage;
}
- (UILabel *)nameLb{
    if (_nameLb == nil) {
        
        _nameLb =[[UILabel alloc]init];
//        _nameLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _nameLb.text=@"进出口加工区充电点";
        _nameLb.textAlignment=NSTextAlignmentLeft;
        _nameLb.font=[UIFont systemFontOfSize:13];
        _nameLb.textColor=[UIColor blackColor];
    }
    return _nameLb;
}
- (UILabel *)havePoliLb{
    if (_havePoliLb == nil) {
        
        _havePoliLb =[[UILabel alloc]init];
//        _havePoliLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _havePoliLb.text=@"交流4个，直流1个";
        _havePoliLb.textAlignment=NSTextAlignmentLeft;
        _havePoliLb.font=[UIFont systemFontOfSize:13];
        _havePoliLb.textColor=[UIColor grayColor];
    }
    return _havePoliLb;
}



- (UILabel *)locationLb{
    if (_locationLb == nil) {
        
        _locationLb =[[UILabel alloc]init];
//        _locationLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _locationLb.text=@"杭州十二号大街15号";
        _locationLb.textAlignment=NSTextAlignmentLeft;
        _locationLb.font=[UIFont systemFontOfSize:13];
        _locationLb.textColor=[UIColor blackColor];
    }
    return _locationLb;
}
- (UILabel *)distanceLb{
    if (_distanceLb == nil) {
        
        _distanceLb =[[UILabel alloc]init];
//        _distanceLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _distanceLb.text=@"0.34km";
        _distanceLb.textAlignment=NSTextAlignmentLeft;
        _distanceLb.font=[UIFont systemFontOfSize:12.5];
        _distanceLb.textColor=[UIColor blackColor];
    }
    return _distanceLb;
}
- (UIButton *)navigaBtn{
    if (_navigaBtn == nil) {
        _navigaBtn = [[UIButton alloc]init];
        _navigaBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _navigaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_navigaBtn setTitle:@"导航" forState:UIControlStateNormal];
        [_navigaBtn addTarget:self action:@selector(clickThtNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
        _navigaBtn.layer.cornerRadius =14;
        _navigaBtn.layer.masksToBounds = YES;
    }
    return _navigaBtn;
}
- (UIButton *)collecBtn{
    if (_collecBtn == nil) {
        _collecBtn = [[UIButton alloc]init];
        _collecBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _collecBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_collecBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collecBtn addTarget:self action:@selector(clickThtCollecBtn:) forControlEvents:UIControlEventTouchUpInside];
        _collecBtn.layer.cornerRadius =14;
        _collecBtn.layer.masksToBounds = YES;
    }
    return _collecBtn;
}
- (void)clickThtNaviBtn:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheNavigationButton)]) {
        [self.delegate clickTheNavigationButton];
    }
}
- (void)clickThtCollecBtn:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheCollectionButton)]) {
        [self.delegate clickTheCollectionButton];
    }
}
@end
