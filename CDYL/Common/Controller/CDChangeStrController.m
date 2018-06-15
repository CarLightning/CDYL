//
//  CDChangeStrController.m
//  CDYL
//
//  Created by admin on 2018/4/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDChangeStrController.h"

@interface CDChangeStrController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString  * oldStr;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation CDChangeStrController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
}
-(void)setSubViews{
    self.navigationController.navigationBarHidden = NO;
    NSString *titile = [self.typeDic objectForKey:@"whatName"];
    self.title = [NSString stringWithFormat:@"修改%@",titile];
    self.oldStr =[self.typeDic objectForKey:@"Name"];
    CGFloat black = 64+15;
    if (is_iphoneX) {
        black = 88+15;
    }
    UIView *iv = [[UIView alloc]initWithFrame:CGRectMake(0, black, DEAppWidth, 40)];
    iv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:iv];
    UITextField *tf=[[UITextField alloc]initWithFrame:CGRectMake(15, 0, DEAppWidth-30, 40)];
    tf.delegate = self;
    tf.backgroundColor = [UIColor whiteColor];
    tf.text = self.oldStr;
    tf.font = [UIFont systemFontOfSize:16];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.returnKeyType = UIReturnKeyDone;
    [self keyBoardModel:tf];
    [tf becomeFirstResponder];
    [iv addSubview:tf];
    self.textField = tf;
  
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheRightItem)];
    item.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = item;
    self.rightItem = item;
}
-(void)keyBoardModel:(UITextField *)tf{
    switch (self.cthType) {
        case 100:
           tf.keyboardType = UIKeyboardTypeDefault;
            break;
        case 102:
            tf.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case 103:
             tf.keyboardType = UIKeyboardTypeURL;
            break;
        case 104:
             tf.keyboardType = UIKeyboardTypeNumberPad;
            break;
       
    }
}
-(void)clickTheRightItem{
    
     [self editConmplement:self.cthType];
}
-(void)editConmplement:(NSInteger)type{
    [self.view endEditing:YES];
    switch (type) {
        case 100: // 修改姓名
            [self changeNameString];
            break;
        case 102: // 修改身份证号
            [self changeIdCardNum];
            break;
        case 103: // 修改邮箱
            [self changeEmail];
            break;
        case 104: // 修改电话
            [self changeIphoneNum];
            break;
        
    }
    
}
-(void)changeNameString{
    if (self.textField.text.length >0) {
        [CDUserInfor shareUserInfor].userName = self.textField.text;
        [[CDUserInfor shareUserInfor] updateInforWithAll:NO];
        [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:1] animated:YES];
    }else{
        [self showAlert:@"不能为空"];
    }
}

-(void)changeIdCardNum{
    
    if (self.textField.text.length >0) {
        BOOL IS_ok = [CDXML CheckIsIdentityCard:self.textField.text];
        if (IS_ok) {
            [CDUserInfor shareUserInfor].idCardNum = self.textField.text;
            [[CDUserInfor shareUserInfor] updateInforWithAll:NO];
            [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:1] animated:YES];
    }else{
        [self showAlert:@"号码有误"];
    }
    }else{
        [self showAlert:@"不能为空"];
    }
}

-(void)changeIphoneNum{
    
    if (self.textField.text.length >0) {
        BOOL IS_ok = [CDXML phoneNumberIsTrue:self.textField.text];
        if (IS_ok) {
            [CDUserInfor shareUserInfor].emergencyPhoneNum = self.textField.text;
            [[CDUserInfor shareUserInfor] updateInforWithAll:NO];
            [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:1] animated:YES];
        }else{
            [self showAlert:@"号码有误"];
        }
    }else{
        [self showAlert:@"不能为空"];
    }
}
-(void)changeEmail{
    
    if (self.textField.text.length >0) {
        BOOL IS_ok = [CDXML isValidateEmail:self.textField.text];
        if (IS_ok) {
            [CDUserInfor shareUserInfor].Email = self.textField.text;
            [[CDUserInfor shareUserInfor] updateInforWithAll:NO];
            [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:1] animated:YES];
        }else{
            [self showAlert:@"Emile输入有误"];
        }
    }else{
        [self showAlert:@"不能为空"];
    }
}
-(void)showAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action1];
   
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark - TextFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *text = [[NSMutableString alloc]initWithString:textField.text];
    if ([string isEqualToString:@""]) {
        [text replaceCharactersInRange:range withString:string];
    }else{
        [text appendString:string];
    }
    NSLog(@"NewString :%@",text);
    if (![text isEqualToString:self.oldStr] && ![text isEqualToString:@""]) {
        self.rightItem.enabled = YES;
    }else{
        self.rightItem.enabled = NO;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.rightItem.enabled = NO;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self editConmplement:self.cthType];
    return YES;
}

@end
