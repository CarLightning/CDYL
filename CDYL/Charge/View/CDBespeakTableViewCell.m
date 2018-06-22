//
//  CDBespeakTableViewCell.m
//  CDYL
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBespeakTableViewCell.h"

@interface CDBespeakTableViewCell ()
@property (nonatomic, strong) UILabel *frontLb;
@property (nonatomic, strong) UILabel *backLb;
@end
@implementation CDBespeakTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        [self addMasonrys];
    }
    return self;
}
- (void)addSubviews{
    [self.contentView addSubview:self.frontLb];
    [self.contentView addSubview:self.backLb];
}
- (void)addMasonrys{
    [self.frontLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    [self.backLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@55);
        make.width.equalTo(@250);
    }];
}

#pragma mark - Get Method
-(UILabel *)frontLb{
    if (_frontLb == nil) {
        _frontLb = [[UILabel alloc]init];
        _frontLb.textColor = LHColor(109, 109, 109);
        _frontLb.font = [UIFont systemFontOfSize:15];
        _frontLb.textAlignment = NSTextAlignmentLeft;
    }
    return _frontLb;
}

-(UILabel *)backLb{
    if (_backLb == nil) {
        _backLb = [[UILabel alloc]init];
        _backLb.textColor = LHColor(34, 34, 34);
        _backLb.numberOfLines = 0;
        _backLb.font = [UIFont systemFontOfSize:15];
        _backLb.textAlignment = NSTextAlignmentCenter;
    }
    return _backLb;
}
- (void)reloadCellWithRow:(NSUInteger)row arr:(NSArray *)arr{
    if (_status == 100) {
        if (row == 0) {
            self.frontLb.text = @"城市";
        }else if (row == 1) {
            self.frontLb.text = @"位置";
        }else if (row == 2) {
            self.frontLb.text = @"预约时间";
        }
        
    }else{
        self.frontLb.text = @"充电开始于";
    }
    if ( arr.count>0) {
        self.backLb.text = arr[row];
    }
    
    
}

-(void)setStatus:(CGFloat)status{
    _status = status;
    
    //    status = 100 为查找
    //    status = 200 为预约设置
}
@end
