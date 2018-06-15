//
//  CDchargeCell.m
//  CDYL
//
//  Created by admin on 2018/6/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDchargeCell.h"
@interface CDchargeCell ()
@property (nonatomic, strong) UILabel *statusLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *moneyLb;
@end
@implementation CDchargeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubs];
        [self add_masonry];
    }
    return self;
}
- (void)addSubs{
    [self.contentView addSubview:self.statusLb];
     [self.contentView addSubview:self.timeLb];
     [self.contentView addSubview:self.moneyLb];
}
-(void)add_masonry{
    [self.statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@20);
    }];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.statusLb);
        make.top.equalTo(self.statusLb.mas_bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
        make.width.equalTo(@120);
        make.height.equalTo(@35);
    }];
}

-(UILabel *)statusLb{
    if (_statusLb == nil) {
        _statusLb = [[UILabel alloc]init];
        _statusLb.textColor = LHColor(34, 34, 34);
        _statusLb.font = [UIFont systemFontOfSize:17];
        _statusLb.textAlignment = NSTextAlignmentLeft;
    }
    return _statusLb;
}
-(UILabel *)timeLb{
    if (_timeLb == nil) {
        _timeLb = [[UILabel alloc]init];
        _timeLb.textColor = LHColor(157, 157, 157);
        _timeLb.font = [UIFont systemFontOfSize:12];
        _timeLb.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLb;
}
-(UILabel *)moneyLb{
    if (_moneyLb == nil) {
        _moneyLb = [[UILabel alloc]init];
        _moneyLb.textColor = LHColor(34, 34, 34);
        _moneyLb.font = [UIFont systemFontOfSize:22];
        _moneyLb.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLb;
}

-(void)setType:(NSUInteger)type{
    _type = type;
}
-(void)setStatus:(NSString *)status{
    if (_type == 1) {
        if ([status isEqualToString:@"1"]) {
            self.statusLb.text = @"在线充值";
        }else{
            self.statusLb.text = @"现场充值";
        }
    }else{
        if ([status isEqualToString:@"1"]) {
            self.statusLb.text = @"已支付";
        }else{
            self.statusLb.text = @"未支付";
        }
    }
}
-(void)setTime:(NSString *)time{
    self.timeLb.text = [self getTime:time];
}
-(void)setMoney:(NSString *)money{
    CGFloat count = money.floatValue;
    self.moneyLb.text = [NSString stringWithFormat:@"%.2f元",count];
}

- (NSString *)getTime:(NSString *)old{
    NSDateFormatter *forma = [[NSDateFormatter alloc]init];
    [forma setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval secs = old.longLongValue/1000;
    NSDate *oldDtate = [NSDate dateWithTimeIntervalSince1970:secs];
    NSString *str = [forma stringFromDate:oldDtate];
    return str;
}
@end
