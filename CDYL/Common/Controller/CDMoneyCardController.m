//
//  CDMonerCardController.m
//  CDYL
//
//  Created by admin on 2018/5/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDMoneyCardController.h"
#import "CDMoneyCardInfor.h"
#import "CDMoneyCard.h"
#import "CDOneCardCth.h"

@interface CDMoneyCardController ()<MoneyCardDelegate>
@property (nonatomic, strong) NSArray *cards; //卡数据
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL is_exist;

@property (nonatomic, strong) NSMutableArray *cardArr; //装卡的数组

@end

@implementation CDMoneyCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.is_exist = NO;
    self.cardArr = [NSMutableArray array];
    self.title = @"钱包";
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator= NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.scrollView .bounces=YES;
    self.scrollView.alwaysBounceVertical=YES;
    
    [self.view addSubview:self.scrollView];
    
    [self reloadCradInformation];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)reloadCradInformation {
    NSString *userNo = [CDUserInfor shareUserInfor].phoneNum;
    NSString *pWord = [CDUserInfor shareUserInfor].userPword;
    __block typeof(self) weakself = self;
    [CDWebRequest requestGetUserCardWithidentity:@"1" cardNo:userNo Pass:pWord AndBack:^(NSDictionary *backDic) {
        NSString *is_ok = [NSString stringWithFormat:@"%@",backDic[@"success"]];
        
        if ([is_ok isEqualToString:@"1"]) {
            
            weakself.cards = [CDMoneyCardInfor arrayOfModelsFromDictionaries:backDic[@"list"] error:nil];
            if (weakself.cards.count>0) {
                [weakself reloadData:weakself.cards];
            }else{
                [weakself showEmptyViewWith:@"请先办理充值卡"];
            }
            
        }
    } failure:^(NSString *err) {
        [weakself showEmptyViewWith:err];
    }];
}
- (void)reloadData:(NSArray *)arr {
    
    
    arr =  [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        CDMoneyCardInfor *dic1 = obj1;
        CDMoneyCardInfor *dic2 = obj2;
        NSString *haveMoney1 = dic1.haveMoney;
        NSString *haveMoney2 = dic2.haveMoney;
        float money1 = haveMoney1.floatValue;
        float money2 = haveMoney2.floatValue;
        if (money1>money2) {
            return  NSOrderedDescending;
        }else{
            return  NSOrderedAscending;
        }
    }];
    NSMutableArray *lastArr = [[NSMutableArray alloc]initWithArray:arr];
    
    for (CDMoneyCardInfor *isDefault in lastArr) {
        BOOL  is_default = isDefault.isdefaultt;
        if (is_default) {
            
            [lastArr removeObject:isDefault];
            [lastArr insertObject:isDefault atIndex:0];
            break;
        }
    }
    CGFloat block = 20;
    
    for (int i = 0 ; i<lastArr.count; i++) {
        if (!self.is_exist){
            if (i == lastArr.count-1) {
                self.is_exist = YES;
            }
            CDMoneyCard *card = [[CDMoneyCard alloc]initWithFrame:CGRectMake(0, block+170*i, DEAppWidth, 150)];
            card.delegate = self;
            card.model = lastArr[i];
            [self.scrollView addSubview:card];
            [self.cardArr addObject:card];
            if (i%2 == 0) {
                card.transform = CGAffineTransformMakeTranslation(-DEAppWidth, 0);
            }else {
                card.transform = CGAffineTransformMakeTranslation(DEAppWidth,0);
            }
            [UIView animateWithDuration:0.5 delay:i*0.03 usingSpringWithDamping:0.75 initialSpringVelocity:3 options:0 animations:^{
                card.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }else{
            CDMoneyCard *card = self.cardArr[i];
            card.model = lastArr[i];
            if (i%2 == 0) {
                card.transform = CGAffineTransformMakeTranslation(-DEAppWidth, 0);
            }else {
                card.transform = CGAffineTransformMakeTranslation(DEAppWidth,0);
            }
            [UIView animateWithDuration:0.5 delay:i*0.03 usingSpringWithDamping:0.75 initialSpringVelocity:3 options:0 animations:^{
                card.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
- (void)clickTheMoneyCard:(CDMoneyCardInfor *)model{
    
    CDOneCardCth *cth = [[CDOneCardCth alloc]init];
    cth.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cth animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)clickTheDefaultButton:(CDMoneyCardInfor *)model{
    
    NSString *userNo = [CDUserInfor shareUserInfor].phoneNum;
    NSString *pWord = [CDUserInfor shareUserInfor].userPword;
    NSString *cardId = model.cardno;
    __weak typeof(self) weakself = self;
    [CDWebRequest requesSetDefaultCardnumidentity:@"1" cardNo:userNo pass:pWord cardId:cardId AndBack:^(NSDictionary *backDic) {
        [weakself reloadCradInformation];
        [[CDUserInfor shareUserInfor]updateInforWithAll:YES];
    } failure:^(NSString *err) {
        NSLog(@"%@",err);
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
        //当前视图控制器在栈中，故为push操作
        NSLog(@"push");
    } else if ([viewControllers indexOfObject:self] == NSNotFound) {
        //当前视图控制器不在栈中，故为pop操作
        self.navigationController.navigationBarHidden = YES;
    }
}
@end
