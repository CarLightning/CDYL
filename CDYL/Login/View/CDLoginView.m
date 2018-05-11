//
//  CDLoginView.m
//  CDYL
//
//  Created by admin on 2018/4/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDLoginView.h"
@interface CDLoginView()

@property (nonatomic, strong) UIImageView *phoneImage;
@property (nonatomic, strong) UIImageView *pwImage;
@property (nonatomic, strong) UILabel *uplb;
@property (nonatomic, strong) UILabel *downlb;
@property (nonatomic, strong) UILabel *showLb;
@end

@implementation CDLoginView{
    CGFloat _showWight;
}

-(instancetype)initWithFrame:(CGRect)frame wight:(CGFloat)wight{
    self = [super initWithFrame:frame];
    _showWight = wight;
    if (self) {
        [self setSubViews];
        
        [self makeMasonry];
    }
    return self;
}
- (void)setSubViews {
    UILabel *lb =[[UILabel alloc]init];
    lb.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5];
    [self addSubview:lb];
    
    UILabel *downlb =[[UILabel alloc]init];
    downlb.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5];;
    [self addSubview:downlb];
    
    UILabel *showlb =[[UILabel alloc]init];
    showlb.textColor=[UIColor blackColor];

    showlb.text = @"+86";
    [self addSubview:showlb];
    
    
    UIImageView *phoneImage =[[UIImageView alloc]init];
    phoneImage.image        = [UIImage imageNamed:@"phoneImage"];
//    phoneImage.backgroundColor= [[UIColor orangeColor]colorWithAlphaComponent:0.5];
    [self addSubview:phoneImage];
    
    UIImageView *pwImage =[[UIImageView alloc]init];
    pwImage.image        = [UIImage imageNamed:@"pwImage"];
//     pwImage.backgroundColor= [[UIColor orangeColor]colorWithAlphaComponent:0.5];
    [self addSubview:pwImage];
    
    UITextField *phonetf =[[UITextField alloc]init];
    phonetf.placeholder  = @"手机号";
    phonetf.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:phonetf];
    
    UITextField *pwtf =[[UITextField alloc]init];
    pwtf.placeholder  = @"密码";
    pwtf.secureTextEntry = YES;
    pwtf.keyboardType = UIKeyboardTypeURL;
    [self addSubview:pwtf];
    
    self.uplb       = lb;
    self.downlb     = downlb;
    self.showLb     = showlb;
    self.phoneTf    = phonetf;
    self.pWordTf    = pwtf;
    self.phoneImage = phoneImage;
    self.pwImage    = pwImage;
    
}
-(void)makeMasonry {
    [self.phoneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.height.width.mas_equalTo(25);
        make.top.mas_equalTo(15);
    }];
    [self.showLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneImage.mas_right).offset(0);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(_showWight);
    }];
    [self.phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.showLb.mas_right).offset(6);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(15);
    }];
    [self.uplb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(44);
    }];
    [self.pwImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.height.width.mas_equalTo(25);
        make.top.mas_equalTo(44+15);
    }];
    [self.pWordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pwImage.mas_right).offset(6);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(15+44);
    }];
    [self.downlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(self).offset(-15);
        make.top.mas_equalTo(88);
    }];
  
}
@end
