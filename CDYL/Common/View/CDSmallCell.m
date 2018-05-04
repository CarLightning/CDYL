//
//  CDSmallCell.m
//  CDYL
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDSmallCell.h"
@interface CDSmallCell()
@property (nonatomic, strong) UILabel *nameLb;
@end


@implementation CDSmallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubViews];
//        40*
    }
    return self;
}
- (void)setSubViews{
    UIImageView  *imageV=[[UIImageView alloc]init];
//    imageV.image = [UIImage imageNamed:@""];
    imageV.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:0.5];
    [self addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(12);
        make.top.mas_equalTo(self).offset(10);
        make.bottom.mas_equalTo(self).offset(-10);
        make.width.mas_equalTo(20);
        
    }];
    
    UILabel *nameLb=[[UILabel alloc]init];
    nameLb.font=[UIFont systemFontOfSize:16];
    nameLb.textAlignment=NSTextAlignmentLeft;
    nameLb.text= @"钱包";
    [self addSubview:nameLb];
    
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV.mas_right).offset(10);
        make.top.mas_equalTo(self).offset(10);
        make.bottom.mas_equalTo(self).offset(-10);
        make.width.mas_equalTo(100);
       
        
    }];
    self.nameLb = nameLb;
}
-(void)setName:(NSString *)name{
    _name = name;
    self.nameLb.text = name;
}
@end
