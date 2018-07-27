//
//  CDShowCell.m
//  CDYL
//
//  Created by admin on 2018/5/11.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDShowCell.h"
@interface CDShowCell()


/**名称**/
@property (nonatomic, strong) UILabel *nameLb;
/**交流桩桩的数量**/
@property (nonatomic, strong) UILabel *havePoliLb;
/**直流交流分割线**/
@property (nonatomic, strong) UILabel *upSeparateLine;
/**直流桩桩的数量**/
@property (nonatomic, strong) UILabel *havezhiPoliLb;
/**详情**/
@property (nonatomic, strong) UIButton *detailBtn;
/**上分割线**/
@property (nonatomic, strong) UILabel *upSplitLine;
/**展示图片**/
@property (nonatomic, strong) UIImageView *showImage;
/**位置**/
@property (nonatomic, strong) UILabel *locationLb;
/**距离**/
@property (nonatomic, strong) UILabel *distanceLb;
/**距离图标**/
@property (nonatomic, strong) UIImageView *locaImageV;
/**下分割线**/
@property (nonatomic, strong) UILabel *downSplitLine;
/**导航**/
@property (nonatomic, strong) UIButton *navigaBtn;
/**收藏导航分割线**/
@property (nonatomic, strong) UILabel *downSeparateLine;
/**预约**/
@property (nonatomic, strong) UIButton *collecBtn;
/**foot分割线**/
@property (nonatomic, strong) UILabel *footLine;

@end

@implementation CDShowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = LHColor(255, 255, 255);
        [self addSubInfor];
        [self addSubMasonry];
    }
    return self;
}
- (void)addSubInfor {
    
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.havePoliLb];
    [self.contentView addSubview:self.upSeparateLine];
    [self.contentView addSubview:self.havezhiPoliLb];
    [self.contentView addSubview:self.detailBtn];
    [self.contentView addSubview:self.upSplitLine];
    [self.contentView addSubview:self.showImage];
    [self.contentView addSubview:self.locationLb];
    [self.contentView addSubview:self.locaImageV];
    [self.contentView addSubview:self.distanceLb];
    [self.contentView addSubview:self.downSplitLine];
    [self.contentView addSubview:self.navigaBtn];
    [self.contentView addSubview:self.downSeparateLine];
    [self.contentView addSubview:self.collecBtn];
    [self.contentView addSubview:self.footLine];
    
}
#pragma mark - set Method
-(void)setModel:(CDStation *)model{
    _model = model;
    self.nameLb.text = model.name;
    NSString *groudipo = [NSString stringWithFormat:@"%ld",model.polelist.count];
    self.havePoliLb.attributedText = [self text:[NSString stringWithFormat:@"交流桩 %@",groudipo]];
    self.havezhiPoliLb.attributedText = [self text:@"直流桩 0"];
    
    self.locationLb.text = model.addr;
    self.distanceLb.text = model.distance;
    
    
}
-(void)setBtnName:(NSString *)btnName{
    _btnName = btnName;
    if ([btnName isEqualToString:@"取消收藏"]) {
         [self.collecBtn setImage:[UIImage imageNamed:@"deleteCollection"] forState:UIControlStateNormal];
    }else{
         [self.collecBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }
   
}
#pragma mark - Masonry Method
- (void)addSubMasonry {
  
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.top.equalTo(self.contentView).offset(15);
        make.width.equalTo(@250);
        make.height.equalTo(@20);
    }];
    [self.havePoliLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.nameLb.mas_left);
        make.top.equalTo(self.nameLb.mas_bottom).offset(15);
        make.width.equalTo(@55);
        make.height.equalTo(@15);
    }];
    [self.upSeparateLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.havePoliLb.mas_right).offset(5);
        make.top.equalTo(self.nameLb.mas_bottom).offset(10);
        make.bottom.equalTo(self.havePoliLb.mas_bottom);
        make.width.equalTo(@0.5);
        
    }];
    [self.havezhiPoliLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.upSeparateLine.mas_right).offset(5);
        make.width.top.bottom.equalTo(self.havePoliLb);
    }];
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.contentView.mas_right).offset(-18);
        make.top.equalTo(self.contentView.mas_top).offset(26);
        make.width.equalTo(@50);
        make.height.equalTo(@25);
    }];
    [self.upSplitLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.havePoliLb.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.havePoliLb.mas_bottom).offset(11.5);
       
        make.height.equalTo(@0.5);
    }];
    
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.nameLb.mas_left);
        make.top.equalTo(self.upSplitLine.mas_bottom).offset(10);
        make.width.height.equalTo(@54);
        
    }];
    
    [self.locationLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.showImage.mas_right).offset(12);
        make.top.equalTo(self.showImage.mas_top);
        make.width.equalTo(@250);
        make.height.equalTo(@15);
    }];
    
    [self.locaImageV mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.locationLb.mas_left);
        make.bottom.equalTo(self.showImage.mas_bottom);
        make.height.width.equalTo(@15);
    }];
    
    [self.distanceLb mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.locaImageV.mas_right).offset(4);
        make.top.equalTo(self.locaImageV);
        make.width.equalTo(@150);
        make.height.equalTo(@15);
    }];
    
    [self.downSplitLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.showImage.mas_bottom).offset(10);
        make.height.equalTo(@0.5);
    }];
    
   [self.collecBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.contentView).offset(5);
        make.top.equalTo(self.downSplitLine.mas_bottom);
        make.width.mas_equalTo(DEAppWidth/2-7);
        make.height.equalTo(@35);
    }];
    
    [self.downSeparateLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.collecBtn.mas_top).offset(9);
        make.bottom.equalTo(self.collecBtn.mas_bottom).offset(-9);
        make.width.mas_equalTo(0.5);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.navigaBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.contentView.mas_right).offset(5);
        make.top.equalTo(self.collecBtn.mas_top);
        make.width.height.mas_equalTo(self.collecBtn);
    }];
    
    [self.footLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.collecBtn.mas_bottom);
        make.height.equalTo(@10);
    }];
    
}

#pragma mark - get Method
- (UILabel *)nameLb{
    if (_nameLb == nil) {
        
        _nameLb =[[UILabel alloc]init];
//        _nameLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _nameLb.text=@"进出口加工区充电点";
        _nameLb.textAlignment=NSTextAlignmentLeft;
        _nameLb.font=[UIFont systemFontOfSize:17];
        _nameLb.textColor= LHColor(34, 34, 34);
    }
    return _nameLb;
}
- (UILabel *)havePoliLb{
    if (_havePoliLb == nil) {
        
        _havePoliLb =[[UILabel alloc]init];
//        _havePoliLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _havePoliLb.text=@"交流4";
        _havePoliLb.textAlignment=NSTextAlignmentLeft;
        _havePoliLb.font=[UIFont systemFontOfSize:12];
        _havePoliLb.textColor = LHColor(157, 157, 157);
    }
    return _havePoliLb;
}
- (UILabel *)upSeparateLine{
    if (_upSeparateLine == nil) {
        
        _upSeparateLine =[[UILabel alloc]init];
        _upSeparateLine.backgroundColor= LHColor(157, 157, 157);
    }
    return _upSeparateLine;
}
- (UILabel *)havezhiPoliLb{
    if (_havezhiPoliLb == nil) {
        
        _havezhiPoliLb =[[UILabel alloc]init];
        //        _havePoliLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _havezhiPoliLb.text=@"直流0";
        _havezhiPoliLb.textAlignment=NSTextAlignmentLeft;
        _havezhiPoliLb.font=[UIFont systemFontOfSize:12];
        _havezhiPoliLb.textColor= LHColor(157, 157, 157);
    }
    return _havezhiPoliLb;
}
- (UIButton *)detailBtn{
    if (_detailBtn == nil) {
        _detailBtn = [[UIButton alloc]init];
        [_detailBtn setImage:[UIImage imageNamed:@"xiangqing"] forState:UIControlStateNormal];
        [_detailBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        _detailBtn.userInteractionEnabled = NO;
        
    }
    return _detailBtn;
}
-(UILabel *)upSplitLine{
    if (_upSplitLine == nil) {
        
        _upSplitLine =[[UILabel alloc]init];
        _upSplitLine.backgroundColor= LHColor(157, 157, 157);
    }
    return _upSplitLine;
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
- (UILabel *)locationLb{
    if (_locationLb == nil) {
        
        _locationLb =[[UILabel alloc]init];
        //        _locationLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _locationLb.text=@"杭州十二号大街15号";
        _locationLb.textAlignment=NSTextAlignmentLeft;
        _locationLb.font=[UIFont systemFontOfSize:13];
        _locationLb.textColor=LHColor(34, 34, 34);
    }
    return _locationLb;
}
- (UIImageView *)locaImageV{
    if (_locaImageV == nil) {
        _locaImageV = [[UIImageView alloc]init];
        _locaImageV.image = [UIImage imageNamed:@"location_icon"];
    }
    return _locaImageV;
}


- (UILabel *)distanceLb{
    if (_distanceLb == nil) {
        
        _distanceLb =[[UILabel alloc]init];
//        _distanceLb.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.6];
        _distanceLb.text=@"0.34km";
        _distanceLb.textAlignment=NSTextAlignmentLeft;
        _distanceLb.font=[UIFont systemFontOfSize:10];
        _distanceLb.textColor=LHColor(34, 34, 34);
    }
    return _distanceLb;
}
-(UILabel *)downSplitLine{
    if (_downSplitLine == nil) {
        
        _downSplitLine =[[UILabel alloc]init];
        _downSplitLine.backgroundColor= LHColor(157, 157, 157);
    }
    return _downSplitLine;
}
- (UIButton *)navigaBtn{
    if (_navigaBtn == nil) {
        _navigaBtn = [[UIButton alloc]init];
        [_navigaBtn setImage:[UIImage imageNamed:@"daohang"] forState:UIControlStateNormal];
        [_navigaBtn addTarget:self action:@selector(clickThtNaviBtn:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _navigaBtn;
}
-(UILabel *)downSeparateLine{
    if (_downSeparateLine == nil) {
        
        _downSeparateLine =[[UILabel alloc]init];
        _downSeparateLine.backgroundColor= LHColor(157, 157, 157);
    }
    return _downSeparateLine;
}
- (UIButton *)collecBtn{
    if (_collecBtn == nil) {
        _collecBtn = [[UIButton alloc]init];
        [_collecBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [_collecBtn addTarget:self action:@selector(clickThtCollecBtn:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _collecBtn;
}
-(UILabel *)footLine{
    if (_footLine == nil) {
        
        _footLine =[[UILabel alloc]init];
        _footLine.backgroundColor = commentColor;
    }
    return _footLine;
}
#pragma mark - 点击 Method

- (void)clickThtNaviBtn:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheNavigationButtonWithCDStation:)]) {
        [self.delegate clickTheNavigationButtonWithCDStation:self.model];
    }
}
- (void)clickThtCollecBtn:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTheCollectionButtonWithCDStation:)]) {
        [self.delegate clickTheCollectionButtonWithCDStation:self.model];
    }
}
#pragma mark - 自定义 Method

-(NSAttributedString *)text:(NSString *)str{
    
    NSDictionary *attributes =@{NSForegroundColorAttributeName:LHColor(157, 157, 157),NSFontAttributeName:[UIFont systemFontOfSize:12]};
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:str];
    [attString setAttributes:attributes range:NSMakeRange(0, str.length)];
    NSString *regularStr = @"([0-9]+(.[0-9]{2})?)";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regularStr options:NSRegularExpressionCaseInsensitive error:nil];
    if (expression) {
        NSArray *results = [expression matchesInString:str options:0 range:NSMakeRange(0, str.length)];
        for (int i = 0; i<results.count; i++) {
            
            NSTextCheckingResult *result = results[i];
            NSRange range = result.range;
             NSDictionary *numAttributes =@{NSForegroundColorAttributeName:LHColor(34, 34, 34),NSFontAttributeName:[UIFont systemFontOfSize:16]};
            [attString setAttributes:numAttributes range:range];
        }
    }
    return attString;
    
}
@end
