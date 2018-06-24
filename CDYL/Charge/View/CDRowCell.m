//
//  CDRowCell.m
//  CDYL
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDRowCell.h"
@interface CDRowCell ()
@property (nonatomic, strong) UILabel *rowLb;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSArray *numbers;
@end
@implementation CDRowCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubviews];
        [self addMasonrys];
    }
    return self;
}
- (void)addSubviews{
    [self.contentView addSubview:self.rowLb];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.slider];
   
}
- (void)addMasonrys{
    [self.rowLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@30);
        make.width.equalTo(@70);
    }];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.rowLb.mas_right).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(@25);
      
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.nameLb);
        make.top.equalTo(self.nameLb.mas_bottom).offset(0);
        make.height.equalTo(@30);
      
    }];
    
}

#pragma mark - Get Method
//-(NSArray *)numbers{
//    if (_numbers == nil) {
//       ;
//    }
//    return _numbers;
//}
-(UILabel *)rowLb{
    if (_rowLb == nil) {
        _rowLb = [[UILabel alloc]init];
        _rowLb.textColor = LHColor(109, 109, 109);
        _rowLb.font = [UIFont systemFontOfSize:15];
        
        _rowLb.textAlignment = NSTextAlignmentLeft;
    }
    return _rowLb;
}
-(UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.textColor = LHColor(34, 34, 34);
        _nameLb.numberOfLines = 0;
         _nameLb.text = @"5km";
        _nameLb.font = [UIFont systemFontOfSize:15];
        _nameLb.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLb;
}
-(UISlider *)slider{
    if (_slider == nil) {
        _slider = [[UISlider alloc]init];
        NSInteger numberOfSteps = 6;
        _slider.maximumValue = numberOfSteps;
        _slider.minimumTrackTintColor = _slider.maximumTrackTintColor = LHColor(188, 188, 188);
        _slider.minimumValue = 0;
        _slider.continuous = YES; // NO makes it call only once you let go
        [_slider addTarget:self action:@selector(valueChanged:)forControlEvents:UIControlEventValueChanged];
        [_slider setThumbImage:[UIImage imageNamed:@"Weslider"] forState:UIControlStateNormal];
        
    }
    return _slider;
}

- (void)valueChanged:(UISlider *)slider{
    NSUInteger index = (NSUInteger)(slider.value+0.5);
    [slider setValue:index animated:YES];
//    NSLog(@"number: %ld", index);
    NSString *row = [self.numbers objectAtIndex:index];
    if (_status == 100) {
         self.nameLb.text = [NSString stringWithFormat:@"%@km",row];
    }else{
         self.nameLb.text = [NSString stringWithFormat:@"%@min",row];
    }
   
    if (self.delagate &&[self.delagate respondsToSelector:@selector(changeTheSearchValue:)]) {
        [self.delagate changeTheSearchValue:row];
    }
}
-(void)setStatus:(CGFloat)status{
    _status = status;
    if (status == 100) {
        _nameLb.text = @"5km";
        _rowLb.text = @"搜索半径";
        _numbers =@[@(5), @(15), @(25), @(35), @(45), @(55), @(60)];
    }else{
        _nameLb.text = @"30min";
        _rowLb.text = @"充电时长";
        _numbers =@[@(30), @(60), @(90), @(120), @(150), @(180), @(210)];
    }
//    status = 100 为查找
//    status = 200 为预约设置
}
@end
