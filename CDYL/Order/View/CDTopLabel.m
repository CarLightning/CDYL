//
//  CDTopLabel.m
//  CDYL
//
//  Created by admin on 2018/6/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDTopLabel.h"

@implementation CDTopLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = LHColor(34, 34, 34);
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setScale:(CGFloat )scale{
    _scale = scale;
    //      R G B
    // 默认：0.134  0.134  0.134
    // 红色：1      0      0
    
    CGFloat  const MHTopicLabelColor = 0.134f;
    CGFloat red = MHTopicLabelColor + (1-MHTopicLabelColor)*scale;
    CGFloat green = MHTopicLabelColor + (0 - MHTopicLabelColor) * scale;
    CGFloat blue = MHTopicLabelColor + (0 - MHTopicLabelColor) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
