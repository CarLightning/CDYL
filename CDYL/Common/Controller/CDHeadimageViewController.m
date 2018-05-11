//
//  CDHeadimageViewController.m
//  CDYL
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDHeadimageViewController.h"
#import "CDUserInfor.h"

@interface CDHeadimageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *pickCtl;
@property (nonatomic, strong) UIImageView *igview;

@end

@implementation CDHeadimageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubViews];
    [self getDataSource];
    [self reloadHeadImage];
}
-(void)setSubViews{
    self.title = @"个人头像";
    UIImageView *igview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppWidth)];
    igview.center = self.view.center;
    igview.contentMode = UIViewContentModeScaleAspectFill;
    igview.clipsToBounds = YES;
    [self.view addSubview:igview];
    
    self.igview = igview;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickTheitem)];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)reloadHeadImage{
    
    NSString *file =[[NSFileManager defaultManager] headImagePath:NO];
    BOOL headPath = [[NSFileManager defaultManager]fileExistsAtPath:file];
    if (headPath) {
        NSData *data = [[NSFileManager defaultManager]contentsAtPath:file];
        self.igview.image = [[UIImage alloc]initWithData:data];
    }else{
        self.igview.backgroundColor =[[UIColor orangeColor]colorWithAlphaComponent:0.5];
    }
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image =info[UIImagePickerControllerOriginalImage];
    NSURL * url = info [UIImagePickerControllerMediaURL];
    NSData *ImageData = [NSData data];
    if ([[url description]hasSuffix:@"PNG"]) {
        ImageData = UIImagePNGRepresentation(image);
    }else{
        ImageData = UIImageJPEGRepresentation(image, 0.5f);
    }
    self.igview.image = image;
    NSString *file = [[NSFileManager defaultManager] headImagePath:YES];
    [ImageData writeToFile:file atomically:YES];
    [CDUserInfor shareUserInfor].headImagePath = file;
    [[CDUserInfor shareUserInfor] updateInforWithAll:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
