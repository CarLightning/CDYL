//
//  CDClipView.m
//  CDYL
//
//  Created by admin on 2018/6/1.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDClipView.h"
#define MAXScale 2.0   //最大放大比例
#define MINScale 1.0   //最小缩放比例
@interface CDClipView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *clipV;     //截图框
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *igView;
@property (nonatomic, strong) NSMutableArray *btnArray;



@end
@implementation CDClipView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.btnArray = [NSMutableArray array];
        [self addSubViews];
    
    }
    return self;
}
- (void)addSubViews {
     [self addSubview:self.scrollView];
     [self.scrollView addSubview:self.igView];
     [self addSubview:self.clipV];
    [self addButton];
    [self reloadHeadImage];
}
- (void)addButton {
    for (int i = 0; i < 2; i++) {
        
        CGRect frame = CGRectMake(0 + i * (DEAppWidth - 50), DEAppHeight - 60, 50, 60);
        NSString *title = i == 0 ? @"取消" : @"确定";
        UIButton *btn = [self createButton:frame title:title tag:i];
        btn.hidden = YES;
        [self addSubview:btn];
        [self.btnArray addObject:btn];
    }
}
- (UIButton *)createButton:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)btnAction:(UIButton *)btn {
    if (btn.tag == 0) {//取消
        [self reloadHeadImage];
    } else {
        if (self.delagate &&[self.delagate respondsToSelector:@selector(didSaveImage:)]) {
            [self.delagate didSaveImage:[self cropImage]];
        }
    }
}
-(UIView *)clipV{
    if (_clipV == nil) {
        _clipV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEAppWidth, DEAppHeight)];
        _clipV.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        _clipV.userInteractionEnabled = NO;
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
         UIBezierPath *arrPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, DEAppHeight/2-DEAppWidth/2, DEAppWidth, DEAppWidth) cornerRadius:DEAppWidth/2];
        [rectPath appendPath:[arrPath bezierPathByReversingPath]];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path =rectPath.CGPath;
        _clipV.layer.mask = shapeLayer;
    }
    return _clipV;
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, DEAppHeight/2-DEAppWidth/2, DEAppWidth, DEAppWidth)];
        _scrollView.maximumZoomScale = MAXScale;
        _scrollView.minimumZoomScale = MINScale;
        _scrollView.delegate = self;
        _scrollView.bouncesZoom = YES;
        _scrollView.zoomScale = 1;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.layer.masksToBounds = NO;
    }
    return _scrollView;
}
-(UIImageView *)igView{
    if (_igView == nil) {
        _igView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _igView.userInteractionEnabled = YES;
    }
    return _igView;
}
-(void)reloadHeadImage{
    
    NSString *file =[[NSFileManager defaultManager] headImagePath:NO];
    BOOL headPath = [[NSFileManager defaultManager]fileExistsAtPath:file];
    if (headPath) {
        NSData *data = [[NSFileManager defaultManager]contentsAtPath:file];
        UIImage *image = [UIImage imageWithData:data];
        [self setHeadimage:image];
    }else{
       
        [self setHeadimage:[UIImage imageNamed:@"headIg"]];
    }
    
}
-(void)setHeadimage:(UIImage *)Headimage{
    _Headimage = Headimage;
     CGFloat scale = Headimage.size.height / Headimage.size.width;
     CGFloat height = DEAppWidth * scale;
     CGFloat y = (height - DEAppWidth) / 2.f;
    self.igView.frame = CGRectMake(0, 0, DEAppWidth, height);
    self.igView.image = Headimage;
    
    self.scrollView.contentSize = CGSizeMake(DEAppWidth, height);
    self.scrollView.contentOffset = CGPointMake(0, y);
}
-(void)setIs_ShowBtn:(BOOL)is_ShowBtn{
    for (UIButton *btn in self.btnArray) {
        btn.hidden = NO;
    }
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.igView;
}
- (UIImage *)cropImage {
    
    CGPoint offset = self.scrollView.contentOffset;
    
    float zoom = self.igView.frame.size.width/self.Headimage.size.width;
    
    zoom = zoom / [UIScreen mainScreen].scale;
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    if (self.igView.frame.size.height < self.scrollView.frame.size.height) {
        offset = CGPointMake(offset.x + (width - self.igView.frame.size.height)/2.0, 0);
        width = height = self.igView.frame.size.height;
    }
    
    CGRect rec = CGRectMake(offset.x/zoom, offset.y/zoom,width/zoom,height/zoom);
    CGImageRef imageRef =CGImageCreateWithImageInRect([self.Headimage CGImage],rec);
    UIImage * image = [[UIImage alloc]initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}

@end
