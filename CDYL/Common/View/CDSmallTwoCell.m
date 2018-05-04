//
//  CDSmallTwoCell.m
//  CDYL
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDSmallTwoCell.h"
#import <Masonry.h>
@interface CDSmallTwoCell()
@property (nonatomic, strong) UILabel *whatLb;
@property (nonatomic, strong) UILabel *nameLb;
@end
@implementation CDSmallTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.whatLb];
        [self.contentView addSubview:self.nameLb];
    }
    return self;
}
-(UILabel *)whatLb{
    if (_whatLb == nil) {
        _whatLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
        _whatLb.font = [UIFont systemFontOfSize:16];
        _whatLb.textAlignment = NSTextAlignmentLeft;
    }
    return _whatLb;
}
-(UILabel *)nameLb{
    if (_nameLb == nil) {
        _nameLb = [[UILabel alloc]initWithFrame:CGRectMake(DEAppWidth -200, 10, 170, 20)];
//        _nameLb.backgroundColor = [UIColor redColor];
        _nameLb.font = [UIFont systemFontOfSize:12];
        _nameLb.textColor = [UIColor lightGrayColor];
        _nameLb.textAlignment = NSTextAlignmentRight;
    }
    return _nameLb;
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.whatLb.text = [dic objectForKey:@"whatName"];
    self.nameLb.text = [dic objectForKey:@"Name"];
}
@end
