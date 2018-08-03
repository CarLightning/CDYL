//
//  CDAboutApp.m
//  CDYL
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDAboutApp.h"
#import "LSXAboutTableViewCell.h"

@interface CDAboutApp ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *souceArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footView;

@end
static NSString *const cellID = @"AboutCell";

@implementation CDAboutApp

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:241.0/255 alpha:1];
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight) style:UITableViewStyleGrouped];
    tv.delegate = self;
    tv.dataSource = self;
    tv.backgroundColor = [UIColor clearColor];
    
    [tv registerClass:[LSXAboutTableViewCell class] forCellReuseIdentifier:cellID];
    tv.tableHeaderView = self.headerView;
    tv.tableFooterView = self.footView;
    [self.view addSubview:tv];
}

-(NSArray *)souceArray {
    if (_souceArray == nil) {
        _souceArray = @[@"微信公众号",@"客服电话",@"联系邮箱",@"商务合作",@"公司网站",];
    }
    return _souceArray;
}
-(UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, 150)];
        UIImageView *iview = [[UIImageView alloc]initWithFrame:CGRectMake((DEAppWidth-70)/2, 20, 70, 70)];
        //        iview.backgroundColor = [UIColor whiteColor];
        iview.image = [UIImage imageNamed:@"logo.png"];
        [_headerView addSubview:iview];
        
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake((DEAppWidth-150)/2, CGRectGetMaxY(iview.frame)+10, 150, 20)];
        NSString * app_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        lb.text=[NSString stringWithFormat:@"版本：%@",app_version];
        lb.font=[UIFont systemFontOfSize:16];
        lb.textAlignment=NSTextAlignmentCenter;
        lb.textColor=[UIColor grayColor];
        [_headerView addSubview:lb];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *linelb=[[UILabel alloc]initWithFrame:CGRectMake(0, 149.5, DEAppWidth, 0.5)];
        linelb.textColor=[UIColor grayColor];
        [_headerView addSubview:linelb];
    }
    return _headerView;
}
-(UIView *)footView{
    if (_footView == nil) {
        CGFloat footH = 0;
        if (is_iphoneX) {
            footH =  DEAppHeight-88-34-375;
        }else{
            footH = DEAppHeight-64-375;
        }
        
        _footView  =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, footH)];
        _footView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:241.0/255 alpha:1];
        
        UILabel *rightlb=[[UILabel alloc]initWithFrame:CGRectMake(0, footH-75, DEAppWidth, 15)];
        rightlb.text=@"Copyright©2014-2018";
        
        rightlb.font=[UIFont systemFontOfSize:12];
        rightlb.textAlignment=NSTextAlignmentCenter;
        rightlb.textColor=[UIColor grayColor];
        [_footView addSubview:rightlb];
        
        UILabel *lbConpary=[[UILabel alloc]initWithFrame:CGRectMake(0, footH-60, DEAppWidth, 15)];
        lbConpary.text=@"浙江硕维新能源技术有限公司";
        
        lbConpary.font=[UIFont systemFontOfSize:12];
        lbConpary.textAlignment=NSTextAlignmentCenter;
        lbConpary.textColor=[UIColor grayColor];
        [_footView addSubview:lbConpary];
        
    }
    return _footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.souceArray.count;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSXAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.name = self.souceArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
