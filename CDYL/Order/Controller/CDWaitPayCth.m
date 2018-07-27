//
//  CDWaitPayCth.m
//  CDYL
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDWaitPayCth.h"

#import "WaitPayVIew.h"

@interface CDWaitPayCth ()
@property (nonatomic, strong) WaitPayVIew *orderView;
@property (nonatomic, strong) NSDictionary *sourceDic;
@property (nonatomic, strong) UIButton *orderBtn;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CDWaitPayCth

- (void)viewDidLoad {
    [super viewDidLoad];  
    
    [self.view addSubview:self.scrollView];
    
    self.orderView = [[NSBundle mainBundle]loadNibNamed:@"WaitPayVIew" owner:self options:nil].lastObject;
    self.orderView.frame = CGRectMake(0, 0, DEAppWidth, 340);

    [self.scrollView addSubview:self.orderView];
    
    [self.scrollView addSubview:self.orderBtn];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSource];
}
-(UIButton *)orderBtn{
    if (_orderBtn == nil) {
        _orderBtn=[[UIButton alloc]init];
        _orderBtn.frame = CGRectMake(60, CGRectGetMaxY(self.orderView.frame)+40, DEAppWidth-56*2, (DEAppWidth-120)*0.146);
        _orderBtn.backgroundColor = LHColor(255, 198, 80);
        [_orderBtn addTarget:self action:@selector(clickTheOrderBtn) forControlEvents:UIControlEventTouchUpInside];
        [_orderBtn setTitle:@"确认付款" forState:UIControlStateNormal];
        [_orderBtn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
        [_orderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _orderBtn.layer.cornerRadius = (DEAppWidth-120)*0.146/2;;
        _orderBtn.layer.masksToBounds = YES;
    }
    return _orderBtn;
}


-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        CGFloat Height = 64;
        if (is_iphoneX) {
            Height = 88;
        }
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        _scrollView .bounces=YES;
        _scrollView.hidden = YES;
        _scrollView.alwaysBounceVertical=YES;
    }
    return _scrollView;
}

#pragma mark - CDBarViewDelagate
-(void)popUpViewController{
    
    NSArray *subs = self.navigationController.childViewControllers;
    [self.navigationController popToViewController:[subs objectAtIndex:subs.count-2] animated:YES];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - 自定义
//确认付款
-(void)clickTheOrderBtn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择支付方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"余额支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIAlertController *alertpay = [UIAlertController alertControllerWithTitle:@"请输入支付密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __block UITextField *tf = nil;
        [alertpay addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            tf = textField;
            
        }];
        UIAlertAction *actionOne=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.view endEditing:YES];
            [self showPayStatus:tf.text];
        }];
        UIAlertAction *actionTwo=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertpay addAction:actionOne];
        [alertpay addAction:actionTwo];
        [self presentViewController:alertpay animated:YES completion:nil];

    }];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"手机支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击手机支付");
        
        
    }];
    UIAlertAction *action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];

    
    
    
}
- (void)getSource{
    [self hiddenAllBaseView];
    if (![CDXML isLogin]) {
        [self showEmptyViewWith:@"待登录"];
    }else{
       
    NSString *cardNum = [CDUserInfor shareUserInfor].phoneNum;
    NSString *pass = [CDUserInfor shareUserInfor].userPword;
    __weak typeof(self) weakself = self;
    [CDWebRequest requestgetqueryCardBillWithidentity:@"1" cardNo:cardNum Pass:pass AndBack:^(NSDictionary *backDic) {
        NSArray *arr =backDic[@"list"];
        if (arr.count>0) {
            weakself.scrollView.hidden = NO;
            weakself.sourceDic = backDic[@"list"][0];
            weakself.orderView.sourceDic = weakself.sourceDic;
            [weakself haveWaitPayorder:YES];
        }else{
            [weakself haveWaitPayorder:NO];
        }
       
    } failure:^(NSString *err) {
        
    }];
}
}
- (void)haveWaitPayorder:(BOOL)is_have{
    if (is_have) {
        self.orderView.hidden = self.orderBtn.hidden = NO;
    }else{
         self.orderView.hidden = self.orderBtn.hidden = YES;
         [self showEmptyViewWith:@"没有待支付订单"];
    }
}
-(void)showPayStatus:(NSString *)pass{
    __weak typeof(self) weakself = self;
    NSString *passStr = [CDXML md5:pass];
    NSString *bill = [NSString stringWithFormat:@"%@",self.sourceDic[@"billId"]];
    NSString *cardId = [NSString stringWithFormat:@"%@",self.sourceDic[@"cardNo"]];
   
   
    [CDWebRequest requestpayChargeRecordidentity:@"1" billId:bill cardId:cardId payPass:passStr AndBack:^(NSDictionary *backDic) {
      
       [weakself alertShow:@"支付成功"];
        
    } failure:^(NSString *err) {
        [weakself alertShow:err];
    }];
}
-(void)alertShow:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([message isEqualToString:@"支付成功"]) {
              [self getSource];
        }
    }];
    
    [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
