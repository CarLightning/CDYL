//
//  CDHeaderController.m
//  CDYL
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDHeaderController.h"
#import "CDBigTwoCell.h"
#import "CDSmallTwoCell.h"
#import "CDHeadimageViewController.h"
#import "CDChangeStrController.h"

@interface CDHeaderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableview;
@end

static  NSString *const BigCELL = @"CDBIGTWOCELL";
static  NSString *const SmallCELL = @"CDSMALLTWOCELL";
@implementation CDHeaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    
    
}
-(NSArray *)array{
    if (_array == nil) {
        NSString *userName = [CDUserInfor shareUserInfor].userName;
         NSString *phoneNum = [CDUserInfor shareUserInfor].phoneNum;
         NSString *idCardNum = [CDUserInfor shareUserInfor].idCardNum;
         NSString *Email = [CDUserInfor shareUserInfor].Email;
         NSString *emergencyPhoneNum = [CDUserInfor shareUserInfor].emergencyPhoneNum;
        
        _array = @[ @{@"whatName":@"头像",@"Name":@""}
                        ,@{@"whatName":@"姓名",@"Name":userName }
                        ,@{@"whatName":@"手机号",@"Name":phoneNum}
                        ,@{@"whatName":@"身份证号",@"Name":idCardNum}
                        ,@{@"whatName":@"电子邮箱",@"Name":Email}
                        ,@{@"whatName":@"紧急联系方式",@"Name":emergencyPhoneNum}];
    }
    return _array;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview reloadData];
}
- (void)setSubViews{
    
    self.view.backgroundColor = LHColor(235, 235, 241);
    self.navigationItem.title = @"个人信息";
    
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)style:UITableViewStyleGrouped];
    tv.backgroundColor = [UIColor clearColor];
    tv.delegate=self;
    tv.dataSource=self;
    
    [tv registerClass:[CDBigTwoCell class] forCellReuseIdentifier:BigCELL];
    [tv registerClass:[CDSmallTwoCell class] forCellReuseIdentifier:SmallCELL];
    [self.view addSubview:tv];
    self.tableview = tv;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CDBigTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:BigCELL];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         cell.dic = self.array[indexPath.section];
        [cell reloadHeadImage];
        return cell;
    }else{
        CDSmallTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:SmallCELL forIndexPath:indexPath];
        if (!(indexPath.row == 1)) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.dic = self.array[indexPath.row+1];
        return cell;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *Header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, 20)];
    Header.backgroundColor = [UIColor clearColor];
    return Header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 20.0f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]init];
    
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 76.0f;
    }else{
        return 50.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CDBaseViewController *baseCth;
  
    
    
    if (indexPath.section == 0) {
       baseCth= [[CDHeadimageViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:baseCth animated:YES];
    }else if (!(indexPath.row==1)){
        CDSmallTwoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
       
         baseCth= [[CDChangeStrController alloc]init];
        baseCth.typeDic = cell.dic;
        baseCth.cthType = indexPath.row+100;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:baseCth animated:YES];
    }
   
 
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
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.array = nil;
    
}
@end
