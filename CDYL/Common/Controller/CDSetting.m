//
//  CDSetting.m
//  CDYL
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDSetting.h"
#import "CDSetOneCell.h"
#import "CDSetTwoCell.h"

@interface CDSetting ()<UITableViewDelegate, UITableViewDataSource,setOneCellDelagate>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSArray *sourceArr;

@end

@implementation CDSetting

static NSString *oneidenty = @"SETONECELL";
static NSString *twoidenty = @"SETTWOCELL";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceArr = @[@"消息推送",@"清除缓存",@"关于APP"];
    self.navigationItem.title = @"设置";
    UITableView *tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
    tv.delegate=self;
    tv.dataSource=self;
    [tv registerClass:[CDSetOneCell class] forCellReuseIdentifier:oneidenty];
    [tv registerClass:[CDSetTwoCell class] forCellReuseIdentifier:twoidenty];
    tv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tv];
    self.tableV = tv;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTheUserNotiOpenState:) name:UIApplicationDidBecomeActiveNotification object:nil];
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
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CDSetOneCell *cell  = [tableView dequeueReusableCellWithIdentifier:oneidenty forIndexPath:indexPath];
        cell.delagate = self;
        [cell showName:self.sourceArr[indexPath.row]];
        return cell;
    }else{
        CDSetTwoCell *cell  = [tableView dequeueReusableCellWithIdentifier:twoidenty forIndexPath:indexPath];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, 35)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {
        //清除缓存
        [self  clearFile];
    }else if(indexPath.section == 0 && indexPath.row == 2){
        //关于APP
        CDBaseViewController *basecth = [[NSClassFromString (@"CDAboutApp") alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:basecth animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }else if (indexPath.section == 1){
        // 退出登录
        if (![CDXML isLogin]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前未登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
           
            [alert addAction:action1];
          
            [self presentViewController:alert animated:YES completion:nil];

        }else{
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要退出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        __weak typeof(self) weakself = self;
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself loginOut];
        }];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }
    }
}
#pragma mark - setOneCellDelagate
- (void)didTheSwitchBtn:(UISwitch *)sw{
    if (sw.on) {
        sw.on = !sw.on;
    }
    [self goToAppSystemSetting];
}
- (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url];
        }
    }
}
#pragma mark - 自定义method
//退出登录
-(void)loginOut{
    [[CDUserInfor shareUserInfor]logOut];
    [self.navigationController popViewControllerAnimated:YES];
}
//清理缓存
-(void)clearFile{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    NSLog ( @"cachpath = %@" , cachPath);
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}
-(void)clearCachSuccess{
    NSLog ( @"清理成功");
    NSIndexPath *index=[NSIndexPath indexPathForRow:1 inSection:0];//刷新
    [self.tableV reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.text = @"清理成功";
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)checkTheUserNotiOpenState:(NSNotification *)noti{
    [self.tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}
@end
