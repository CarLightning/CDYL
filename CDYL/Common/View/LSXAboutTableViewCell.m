//
//  LSXAboutTableViewCell.m
//  LSX
//
//  Created by admin on 2018/4/12.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "LSXAboutTableViewCell.h"
@interface LSXAboutTableViewCell()
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *showLb;
@end


@implementation LSXAboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, self.bounds.size.height)];
        lb.font=[UIFont systemFontOfSize:16];
        lb.textAlignment=NSTextAlignmentLeft;
        lb.textColor=LHColor(34, 34, 34);
        [self addSubview:lb];
        self.nameLb = lb;
        
        UILabel *showLb=[[UILabel alloc]initWithFrame:CGRectMake(DEAppWidth-20-200, 0, 200, self.bounds.size.height)];
        showLb.font=[UIFont systemFontOfSize:14];
        showLb.textAlignment=NSTextAlignmentRight;
        showLb.textColor=LHColor(255, 189, 80);
        [self addSubview:showLb];
        self.showLb = showLb;
        
    }
    return self;
}

-(void)setName:(NSString *)name{
    _name = name;
    self.nameLb.text = name;
    if ([name isEqualToString:@"微信公众号"]) {
        self.showLb.text = @"车电云联";
    }else if ([name isEqualToString:@"客服电话"]){
         self.showLb.text = @"1571-86898502";
    }else if ([name isEqualToString:@"联系邮箱"]){
         self.showLb.text = @"540864802@qq.com";
    }else if ([name isEqualToString:@"商务合作"]){
         self.showLb.text = @"540864802@qq.com";
    }else if ([name isEqualToString:@"公司网站"]){
         self.showLb.text = @"www.cdyl.com";
    }else if ([name isEqualToString:@"平安车险"]){
        self.showLb.text = @"Tel:95511";
    }else if ([name isEqualToString:@"太平洋车险"]){
        self.showLb.text = @"Tel:400 609 5500";
    }else if ([name isEqualToString:@"阳光车险"]){
        self.showLb.text = @"Tel:95510";
    }else if ([name isEqualToString:@"特斯拉"]){
        self.showLb.text = @"Tel:400 910 0707";
    }else if ([name isEqualToString:@"北汽新能源"]){
        self.showLb.text = @"Tel:400 650 6766";
    }else if ([name isEqualToString:@"比亚迪"]){
        self.showLb.text = @"Tel:400 830 3666";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
