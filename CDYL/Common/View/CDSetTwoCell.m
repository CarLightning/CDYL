//
//  CDSetTwoCell.m
//  CDYL
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDSetTwoCell.h"
@interface CDSetTwoCell ()
@property (nonatomic, strong) UILabel *nameLb;

@end
@implementation CDSetTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLb];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(@150);
            make.height.equalTo(@20);
        }];
    }
    return self;
}
-(UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]init];
        _nameLb.textColor = [UIColor redColor];
        _nameLb.text = @"退出我的账号";
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.font = [UIFont systemFontOfSize:16];
    }
    return _nameLb;
}
@end
