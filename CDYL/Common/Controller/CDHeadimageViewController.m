//
//  CDHeadimageViewController.m
//  CDYL
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDHeadimageViewController.h"
#import "CDUserInfor.h"
#import "CDClipView.h"
#import "UIImage+CDResize.h"
@interface CDHeadimageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CDClipViewDelagate>
@property (nonatomic, strong) UIImagePickerController *pickCtl;

@property (nonatomic, strong) CDClipView *clipView;

@end

@implementation CDHeadimageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setSubViews];
    [self getDataSource];
    
}
-(void)setSubViews{
    self.title = @"个人头像";
   self.clipView = [[CDClipView alloc]initWithFrame:self.view.bounds];
    self.clipView.delagate = self;
    [self.view addSubview:self.clipView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickTheitem)];
    self.navigationItem.rightBarButtonItem = item;
    
}

-(void)getDataSource{
    
    
}
- (void)clickTheitem {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.pickCtl setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:self.pickCtl animated:YES completion:nil];
    }];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.pickCtl setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
         [self presentViewController:self.pickCtl animated:YES completion:nil];
    }];
     UIAlertAction *action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];

}

-(UIImagePickerController *)pickCtl{
    if (_pickCtl == nil) {
        _pickCtl = [[UIImagePickerController alloc]init];
        [_pickCtl setDelegate:self];
    }
    return _pickCtl;
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image =info[UIImagePickerControllerOriginalImage];
    
    UIImage *newIg = [image resizeImage:image];
   
    self.clipView.Headimage = newIg;
    self.clipView.is_ShowBtn = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - CDClipViewDelagate
-(void)didSaveImage:(UIImage *)image{
    self.clipView.hidden = YES;
     NSArray *subs = self.navigationController.childViewControllers;
    [self.navigationController popToViewController:[subs objectAtIndex:subs.count-2] animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self saveNewHeadImage:image];
    });
}

-(void)saveNewHeadImage:(UIImage *)newIg
{
    NSData * ImageData = UIImageJPEGRepresentation(newIg, 0.5f);
    NSString *file = [[NSFileManager defaultManager] headImagePath:YES];
    [ImageData writeToFile:file atomically:YES];
    [CDUserInfor shareUserInfor].headImagePath = file;
    [[CDUserInfor shareUserInfor] updateInforWithAll:NO];
}




@end
