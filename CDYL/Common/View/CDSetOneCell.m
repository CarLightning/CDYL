//
//  CDSetOneCell.m
//  CDYL
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDSetOneCell.h"

@interface CDSetOneCell ()
@property (nonatomic, strong) UILabel *nameLb;
//文本显示
@property (nonatomic, strong) UILabel *showLb;
//更多的箭头
@property (nonatomic, strong) UIImageView *moveIv;
//switch开关
@property (nonatomic, strong) UISwitch *sw;
@end
@implementation CDSetOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.showLb];
        [self.contentView addSubview:self.moveIv];
        [self.contentView addSubview:self.sw];
        [self add_masonrys];
    }
    return self;
}
- (void)add_masonrys{
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    [self.showLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    [self.moveIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.equalTo(@15);
    }];
    [self.sw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
}
-(UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.textColor = LHColor(34, 34, 34);
        _nameLb.font = [UIFont systemFontOfSize:16];
        _nameLb.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLb;
}
-(UILabel *)showLb{
    if (_showLb == nil) {
        _showLb = [[UILabel alloc]init];
        _showLb.textColor = LHColor(34, 34, 34);
        _showLb.font = [UIFont systemFontOfSize:15];
        _showLb.textAlignment = NSTextAlignmentRight;
        _showLb.text = @"0.00MB";
        _showLb.hidden = YES;
    }
    return _showLb;
}
-(UIImageView *)moveIv{
    if (_moveIv == nil) {
        _moveIv =[[UIImageView alloc]init];
        _moveIv.image = [UIImage imageNamed:@"moveBack"];
        _moveIv.hidden = YES;
    }
    return _moveIv;
}
-(UISwitch *)sw{
    if (_sw == nil) {
        _sw = [[UISwitch alloc]init];
        [_sw addTarget:self action:@selector(ClickTheSwitch:) forControlEvents:UIControlEventValueChanged];
        _sw.hidden = YES;
    }
    return _sw;
}
- (void)ClickTheSwitch:(UISwitch *)stch{
    if (self.delagate &&[self.delagate respondsToSelector:@selector(didTheSwitchBtn:)]) {
        [self.delagate didTheSwitchBtn:stch];
    }
}
-(void)showName:(NSString *)name{
    self.nameLb.text = name;
    if ([name isEqualToString:@"消息推送"]) {
        self.showLb.hidden = self.moveIv.hidden = YES;
        self.sw.hidden = NO;
        [self.sw setOn:[CDXML isUserNotificationEnable] animated:YES];
    }else if ([name isEqualToString:@"清除缓存"]) {
        self.sw.hidden = self.moveIv.hidden = YES;
        self.showLb.hidden = NO;
        self.showLb.text = [NSString stringWithFormat:@"%.2fMB",[CDXML filePath]];
    }else if ([name isEqualToString:@"关于APP"]) {
        self.sw.hidden = self.showLb.hidden = YES;
        self.moveIv.hidden = NO;
    }
}




@end
