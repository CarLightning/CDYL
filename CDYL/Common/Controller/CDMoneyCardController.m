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
@interface CDMoneyCardController ()<MoneyCardDelegate>
@property (nonatomic, strong) NSArray *cards;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CDMoneyCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"钱包";
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator= NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.scrollView .bounces=YES;
    self.scrollView.alwaysBounceVertical=YES;

    [self.view addSubview:self.scrollView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadCradInformation];
}
- (void)reloadCradInformation {
    NSString *userNo = [CDUserInfor shareUserInfor].phoneNum;
    NSString *pWord = [CDUserInfor shareUserInfor].userPword;
    __block typeof(self) weakself = self;
    [CDWebRequest requestGetUserCardWithidentity:@"1" cardNo:userNo Pass:pWord AndBack:^(NSDictionary *backDic) {
        NSString *is_ok = [NSString stringWithFormat:@"%@",backDic[@"success"]];
        
        if ([is_ok isEqualToString:@"1"]) {
            
            weakself.cards = [CDMoneyCardInfor arrayOfModelsFromDictionaries:backDic[@"list"] error:nil];
            [weakself reloadData:weakself.cards];
        }
    } failure:^(NSString *err) {
        
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
        CDMoneyCard *card = [[CDMoneyCard alloc]initWithFrame:CGRectMake(0, block+170*i, DEAppWidth, 150)];
        card.delegate = self;
        card.model = lastArr[i];
        [self.scrollView addSubview:card];
    }
}
- (void)clickTheMoneyCard:(CDMoneyCardInfor *)model{
    

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

@end
