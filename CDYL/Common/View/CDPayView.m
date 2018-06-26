//
//  CDPayView.m
//  CDYL
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 admin. All rights reserved.
//
#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

#import "CDPayView.h"
@interface CDPayView () <UITextFieldDelegate>
/**充值金额**/
@property (nonatomic, strong) UILabel *showLb;
/**money图片**/
@property (nonatomic, strong) UIImageView *moneyBg;
/**输入金额**/
@property (nonatomic, strong) UITextField *textFiled;
/**分割线**/
@property (nonatomic, strong) UILabel *lineLb;
/**可用余额**/
@property (nonatomic, strong) UILabel *moneyLb;
@end
@implementation CDPayView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addsubviews];
        [self addMasonrys];
    }
    return self;
}
- (void)addsubviews {
    [self addSubview:self.showLb];
    [self addSubview:self.moneyBg];
    [self addSubview:self.textFiled];
    [self addSubview:self.lineLb];
    [self addSubview:self.moneyLb];
}
- (void)addMasonrys {
    
    [self.showLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17.5);
        make.top.equalTo(self).offset(15);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    [self.moneyBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.showLb.mas_left);
        make.top.equalTo(self.showLb.mas_bottom).offset(32);
        make.width.height.equalTo(@16);
    }];
    
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyBg.mas_left).offset(25);
        make.top.equalTo(self.moneyBg.mas_top).offset(-2);
        make.bottom.equalTo(self.moneyBg.mas_bottom).offset(2);
        make.right.equalTo(self.mas_right);
    }];
    
    [self.lineLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyBg.mas_bottom).offset(12);
        make.left.right.equalTo(self.textFiled);
        make.height.equalTo(@0.5);
    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineLb.mas_bottom).offset(14);
        make.left.equalTo(self.moneyBg.mas_left);
        make.height.equalTo(@20);
    }];
}
-(UILabel *)showLb{
    if (_showLb == nil) {
        _showLb = [[UILabel alloc]init];
        _showLb.text = @"充值金额(元)";
        _showLb.font = [UIFont systemFontOfSize:17];
        _showLb.textColor = LHColor(34, 34, 34);
    }
    return _showLb;
}
-(UIImageView *)moneyBg{
    if (_moneyBg == nil) {
        _moneyBg = [[UIImageView alloc]init];
        _moneyBg.image = [UIImage imageNamed:@"yuanBg"];
    }
    return _moneyBg;
}
-(UITextField *)textFiled{
    if (_textFiled == nil) {
        _textFiled = [[UITextField alloc]init];
        _textFiled.font = [UIFont systemFontOfSize:18];
        _textFiled.delegate = self;
        _textFiled.textColor = LHColor(34, 34, 34);
        _textFiled.keyboardType = UIKeyboardTypeDecimalPad;
        // 就下面这两行是重点
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"输入金额" attributes: @{NSForegroundColorAttributeName:LHColor(200, 200, 200),
                                            NSFontAttributeName:_textFiled.font
                                            }];
        _textFiled.attributedPlaceholder = attrString;
    }
    return _textFiled;
}
-(UILabel *)lineLb{
    if (_lineLb == nil) {
        _lineLb = [[UILabel alloc]init];
        _lineLb.backgroundColor = LHColor(226, 226, 226);
    }
    return _lineLb;
}
-(UILabel *)moneyLb{
    if (_moneyLb == nil) {
        _moneyLb = [[UILabel alloc]init];
        _moneyLb.text = @"可用余额：200元";
        _moneyLb.font = [UIFont systemFontOfSize:14];
        _moneyLb.textColor = LHColor(157, 157, 157);
    }
    return _moneyLb;
}
-(void)setModel:(CDMoneyCardInfor *)model{
    _model = model;
    _moneyLb.text = [NSString stringWithFormat:@"可用余额：%@元",model.haveMoney];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 10) {
        return range.location < 11;
    }else{
        BOOL isHaveDian = YES;
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            isHaveDian=NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                //首字母不能为小数点
                if([textField.text length]==0){
                    if(single == '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                        
                    }
                }
                if([textField.text length]==1 && [textField.text isEqualToString:@"0"]){
                    if(single != '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                } if (single=='.')
                {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian=YES;
                        return YES;
                    }else{
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                    
                }else {
                    if (isHaveDian)//存在小数点
                    {
                        //判断小数点的位数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        NSInteger tt=range.location-ran.location;
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    else
                    {
                        return YES;
                    }
                }
                
            }else{//输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
            
        } else {
            return YES;
            
        }
        
    }
    
}
@end
