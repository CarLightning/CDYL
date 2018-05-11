//
//  CDBigCell.m
//  CDYL
//
//  Created by admin on 2018/4/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBigCell.h"

@interface CDBigCell ()
@property (nonatomic, strong) UILabel  * nameLb;
@property (nonatomic, strong) UILabel  * phoneLb;
@property (nonatomic, strong) UIImageView  * headIg;
@end

@implementation CDBigCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubVies];
      
//        82
    }
    return self;
}
-(void)reloadHeadImage{
    
    NSString *file =[[NSFileManager defaultManager] headImagePath:NO];
    BOOL headPath = [[NSFileManager defaultManager]fileExistsAtPath:file];
    if (headPath) {
        NSData *data = [[NSFileManager defaultManager]contentsAtPath:file];
        self.headIg.image = [[UIImage alloc]initWithData:data];
    }else{
        self.headIg.backgroundColor =[[UIColor orangeColor]colorWithAlphaComponent:0.5];
    }
    self.nameLb.text = [CDUserInfor shareUserInfor].userName;
    self.phoneLb.text = [@"账号：" stringByAppendingString:[CDUserInfor shareUserInfor].phoneNum];
}
- (void)setSubVies{
    
//    375*62
    UIImageView *headIg = [[UIImageView alloc]initWithFrame:CGRectMake(13, 12, 60, 60)];
    
    [self addSubview:headIg];
    headIg.layer.cornerRadius = 5;
    headIg.layer.masksToBounds = YES;
    
    
  
    UILabel *nameLb=[[UILabel alloc]init];
    nameLb.font=[UIFont systemFontOfSize:16];
    nameLb.text = @"张飞";
    nameLb.textAlignment=NSTextAlignmentLeft;
     [self addSubview:nameLb];
    
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headIg.mas_right).offset(12);
        make.top.mas_equalTo(headIg.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    
    UILabel *phoneLb=[[UILabel alloc]init];
    phoneLb.font=[UIFont systemFontOfSize:14];
    phoneLb.text = @"账号：13136111092";
    phoneLb.textAlignment=NSTextAlignmentLeft;
    [self addSubview:phoneLb];
    
    [phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLb.mas_left);
        make.top.mas_equalTo(nameLb.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    self.headIg = headIg;
    self.nameLb = nameLb;
    self.phoneLb = phoneLb;
    
}


@end
