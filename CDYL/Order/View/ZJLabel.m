//
//  ZJLabel.m
//  ZJLabel
//
//  Created by iOS on 16/6/20.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "ZJLabel.h"
@interface ZJLabel ()

@property (nonatomic) CADisplayLink * myTimer;

@property (nonatomic,assign) CGRect MYframe;

@property (nonatomic,assign) CGFloat fa;

@property (nonatomic,assign) CGFloat bigNumber;

@end
@implementation ZJLabel
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _MYframe = frame;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)createTimer{
    if (!self.myTimer) {
        self.myTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
        [self.myTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)action{
    //让波浪移动效果
        _fa = _fa+10;
    if (_fa >= _MYframe.size.width * 4.0) {
        _fa = 0;
    }
    [self setNeedsDisplay];
 }

- (void)drawRect:(CGRect)rect{
    /****
    正弦型函数解析式：y=Asin（ωx+φ）+h
    各常数值对函数图像的影响：
    φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
    ω：决定周期（最小正周期T=2π/|ω|）
    A：决定峰值（即纵向拉伸压缩的倍数）
    h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 ****/
//    第一个
    CGContextRef context = UIGraphicsGetCurrentContext();
//    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    //画水
    CGContextSetLineWidth(context, 1);
    UIColor * blue = [UIColor colorWithRed:255.0/255 green:198.0/255 blue:0/255.0 alpha:1];
    CGContextSetFillColorWithColor(context, [blue CGColor]);
    float y= (1 - self.present) * rect.size.height;
    float y1= (1 - self.present) * rect.size.height;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=rect.size.width * 3.0;x++){
//正弦函数
        y=  sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI ) *_bigNumber + (1 - self.present) * rect.size.height ;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, rect.size.width , rect.size.height );
    CGPathAddLineToPoint(path, nil, 0, rect.size.height );
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);

//第二个
    CGMutablePathRef path1 = CGPathCreateMutable();
  //  float y1=200;
    //画水
    CGContextSetLineWidth(context, 1);
    UIColor * blue1 = [UIColor colorWithRed:255.0/255 green:150.0/255 blue:0.0/255 alpha:0.8];
    CGContextSetFillColorWithColor(context, [blue1 CGColor]);
    CGPathMoveToPoint(path1, NULL, 0, y1);
    for(float x=0;x<=rect.size.width;x++){
        y1= sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI  +M_PI ) *_bigNumber + (1 - self.present) * rect.size.height ;
        CGPathAddLineToPoint(path1, nil, x, y1);
    }
    CGPathAddLineToPoint(path1, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path1, nil, 0, rect.size.height);
    CGContextAddPath(context, path1);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path1);
    
}


- (void)setPresent:(CGFloat)present{
    _present = present;
    //启动定时器
      [self createTimer];
     //修改波浪的幅度
    if (present <= 0.5) {
        _bigNumber = _MYframe.size.height * 0.2 * present * 2;
    }else{
        _bigNumber = _MYframe.size.height * 0.2 * (1 - present) * 2;
    }
}
-(void)stopAnimation{
    [self.myTimer invalidate];
    self.myTimer = nil;
}
@end
