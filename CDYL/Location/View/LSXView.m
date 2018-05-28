//
//  LSXView.m
//  LSX
//
//  Created by admin on 2016/11/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LSXView.h"

@implementation LSXView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"%s完成初始话",__func__);
    }
    return self;
}

- (IBAction)moreThing:(id)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(clickTheMoreBtnWithStationModel:)]) {
        [self.delegate clickTheMoreBtnWithStationModel:self.model];
    }
}

-(void)setModel:(CDStation *)model{
    _model = model;
    self.where.text = model.name;
    self.location.text = model.addr;
    self.distence.text = model.distance;
}
#pragma mark - 导航开始

@end
