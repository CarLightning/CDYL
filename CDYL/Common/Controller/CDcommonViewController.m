//
//  CDcommonViewController.m
//  CDYL
//
//  Created by admin on 2017/6/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CDcommonViewController.h"
#import "CDBigCell.h"
#import "CDSmallCell.h"
#import "CDHeaderController.h"
/*************************/
#import "CDNav.h"
#import "CDViewController.h"

@interface CDcommonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation CDcommonViewController

static NSString *const bigcellID = @"bigCommentcell";
static NSString *const smallcellID = @"smallCommentcell";
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setSubViews];
    self.array = @[@"",@"钱包",@"收藏",@"设置"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)setSubViews{
    
    self.view.backgroundColor = LHColor(235, 235, 241);
    self.navigationItem.title = @"Me";
    
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)style:UITableViewStyleGrouped];
    tv.backgroundColor = [UIColor clearColor];
    tv.delegate=self;
    tv.dataSource=self;
    
    [tv registerClass:[CDBigCell class] forCellReuseIdentifier:bigcellID];
    [tv registerClass:[CDSmallCell class] forCellReuseIdentifier:smallcellID];
    [self.view addSubview:tv];
    self.tableview = tv;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CDBigCell *cell = [tableView dequeueReusableCellWithIdentifier:bigcellID];;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell reloadHeadImage];
        return cell;
    }else{
        CDSmallCell *cell = [tableView dequeueReusableCellWithIdentifier:smallcellID forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.name = self.array[indexPath.section];
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
        return 82.0f;
    }else{
        return 40.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CDBaseViewController *basecth;
    if ([cell isKindOfClass:[CDBigCell class]]) {
        
           basecth  = [[CDHeaderController alloc]init];
       
        
    }else{
        switch (indexPath.section) {
            case 1: // 钱包
            {
                CDViewController *cview = [[CDViewController alloc]init];
                CDNav *navi = [[CDNav alloc]initWithRootViewController:cview];
                [self presentViewController:navi animated:YES completion:nil];
            }
                break;
            case 2: // 收藏
            {
                
            }
                break;
            case 3: // 设置
            {
                
            }
                break;
        }
    }
    self.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:basecth animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
