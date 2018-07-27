//
//  CDRechangeCth.m
//  CDYL
//
//  Created by admin on 2018/6/25.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDRechangeCth.h"
#import "CDPayCell.h"
#import "CDPayView.h"
#import "CDPayHandle.h"

@interface CDRechangeCth ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableV;
/**
 选择的支付方式 1、支付宝 2、微信
 **/
@property (nonatomic, assign) NSInteger selectRow;
/**支付View**/
@property (nonatomic, strong) CDPayView *payView;
/**支付btn**/
@property (nonatomic, strong) UIButton *payBtn;


@end

@implementation CDRechangeCth

static NSString *const identifer = @"recharge";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectRow = 0;
    [self setSubViews];
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - get方法
-(NSArray *)array{
    if (_array == nil) {
        _array = @[@"支付宝支付",@"微信支付"];
    }
    return _array;
}
-(CDPayView *)payView{
    if (_payView == nil) {
        _payView = [[CDPayView alloc]initWithFrame:CGRectMake(0, 132.5+15.5, DEAppWidth, 143)];
        _payView.model = self.model;
    }
    return _payView;
}
-(UIButton *)payBtn{
    if (_payBtn == nil) {
        _payBtn=[[UIButton alloc]initWithFrame:CGRectMake(37, CGRectGetMaxY(self.payView.frame)+34, DEAppWidth-74, (DEAppWidth-74)*0.12)];
        _payBtn.backgroundColor = LHColor(255, 198, 80);
        [_payBtn addTarget:self action:@selector(clickThePayBtn) forControlEvents:UIControlEventTouchUpInside];
        [_payBtn setTitle:@"立即充值" forState:UIControlStateNormal];
        [_payBtn setTitleColor:LHColor(34, 34, 34) forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _payBtn.layer.cornerRadius = (DEAppWidth-74)*0.12/2;;
        _payBtn.layer.masksToBounds = YES;
    }
    return _payBtn;
}


#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CDPayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.Is_select = NO;
    NSString *name = self.array[indexPath.row];
    [cell reloadCellWith:name rowIndex:indexPath.row];
    if (indexPath.row == self.selectRow) {
        [cell selectBgShow:YES];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *Header = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, 32.5)];
    Header.text = @"  选择支付方式";
    Header.font = [UIFont systemFontOfSize:17];
    Header.textColor = LHColor(157, 157, 157);
    Header.backgroundColor = [UIColor clearColor];
    return Header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 32.5;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectRow = indexPath.row;
    [tableView reloadData];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - 自定义method
- (void)setSubViews{
    
    self.view.backgroundColor = LHColor(235, 235, 241);
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight) style:UITableViewStyleGrouped];
    tv.backgroundColor = [UIColor clearColor];
    tv.delegate=self;
    tv.dataSource=self;
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tv registerClass:[CDPayCell class] forCellReuseIdentifier:identifer];
    
    [self.view addSubview:tv];
    self.tableV = tv;
    [self.tableV addSubview:self.payView];
    [self.tableV addSubview:self.payBtn];
}
- (void)clickThePayBtn{
    if (self.payView.textFiled.text.length == 0) {
        [self showAlert:@"请输入正确的金额"];
    }else{
        [self.view endEditing:YES];
        NSString *string = self.payView.textFiled.text;
        
        if (self.selectRow == 0) {
            // 支付宝支付
            [self usedAlipay:string];
        }else{
            //微信支付
            NSString *payMoney = [self getWXpayMoney:string];
            [CDPayHandle WXPayWithMoney:payMoney];
        }
    }
}
- (void)keyboardWillShow:(NSNotification *)noti{
    CGRect oldrc = self.payView.frame;
    
    CGRect rc = [self.tableV convertRect:oldrc toView:self.view];
    CGFloat rcY = CGRectGetMaxY(rc);
    CGRect keyBoardRect=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (keyBoardRect.origin.y > rcY) {
    }else{
        NSInteger H = rcY-keyBoardRect.origin.y;
        
        [UIView animateWithDuration:duration animations:^{
            self.tableV.transform = CGAffineTransformMakeTranslation(0, -0-H);
        }];
    }
}
- (void)keyboardWillHide:(NSNotification *)noti{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.tableV.transform =CGAffineTransformIdentity;
    }];
    
}
-(void)showAlert:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (NSString *)getWXpayMoney:(NSString *)string{
    
    NSMutableString * payMoney = [[NSMutableString alloc]initWithString:@""];
    if (![string containsString:@"."]) {//不带小数点
        [payMoney appendString:string];
        [payMoney appendString:@"00"];
    }else{//带小数点
        NSString *lastStr = [string componentsSeparatedByString:@"."].lastObject;
        
        if (lastStr.length==1) {//小数点后只有一位
            
            if ([string hasPrefix:@"0"]) { //是否以0开头、如0.1
                payMoney = [[NSMutableString alloc]initWithString:lastStr];
                [payMoney appendFormat:@"0"];
            }else{
                NSString * newStr = [string stringByReplacingOccurrencesOfString:@"." withString:@""];
                [payMoney appendString:newStr];
                [payMoney appendString:@"0"];
            }
            
        }else if (lastStr.length == 2){//小数点后有两位
            if ([string hasPrefix:@"0"]) {//是否以0开头、如0.1
                if ([lastStr hasPrefix:@"0"]) { //是否以0开头、如0.01
                    NSString *lstr = [lastStr componentsSeparatedByString:@"0"].lastObject;
                    payMoney = [[NSMutableString alloc]initWithString:lstr];
                }else{
                    payMoney = [[NSMutableString alloc]initWithString:lastStr];
                }
            }else{
                NSString * newStr = [string stringByReplacingOccurrencesOfString:@"." withString:@""];
                [payMoney appendString:newStr];
            }
        }
    }
    return [payMoney copy];
}

- (void)usedAlipay:(NSString *)string{
//    http://183.129.254.28/webservice/services/IcCardWebService/genTransNo?cardId=3050120160821006&total_fee=0.01&accName=13136111092&accId=13136111092
    NSString *cardId = self.model.cardno;
    NSString *total_fee = string;
    NSString *accName = [CDUserInfor shareUserInfor].phoneNum;
    NSString *accId = [CDUserInfor shareUserInfor].phoneNum;
    [CDWebRequest requestgenTransNocardId:cardId total_fee:total_fee accName:accName accId:accId AndBack:^(NSDictionary *backDic) {
        NSString * orderNum =[NSString stringWithFormat:@"%@", backDic[@"message"]];
         [CDPayHandle AliPayWithMoney:total_fee outTradeNO:orderNum];
    } failure:^(NSString *err) {
        
    }];
    
}

@end
