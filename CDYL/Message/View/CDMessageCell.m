//
//  CDMessageCell.m
//  CDYL
//
//  Created by admin on 2018/6/15.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDMessageCell.h"
#import <YYText.h>
#import "UserMessage.h"

@interface CDMessageCell ()
/** 时间frame */
@property (nonatomic, strong) YYLabel *timeLb;
/** 内容frame */
@property (nonatomic, strong) YYLabel  *textLB;
/** 提示frame */
@property (nonatomic, strong) YYLabel  *noticeLb;
/** 背景frame */
@property (nonatomic, strong) UIView  *bgIv;
/** 头像frame */
@property (nonatomic, strong) UIImageView  *headView;
@end
@implementation CDMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = commentColor;
        [self setSubViews];
    }
    return self;
}
- (void)setSubViews{
    
    self.timeLb = [[YYLabel alloc]init];
    self.timeLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:11.0f];
    self.timeLb.textAlignment = NSTextAlignmentCenter;
    self.timeLb.textColor = LHColor(34 ,34, 34);
    [self.contentView addSubview:self.timeLb];
    
    
    self.bgIv = [[UIView alloc]init];
    self.bgIv.backgroundColor = LHColor(255 ,255, 255) ;
    [self.contentView addSubview:self.bgIv];
    self.bgIv.layer.cornerRadius = 10;
    self.bgIv.layer.masksToBounds = YES;
    
    
    self.noticeLb = [[YYLabel alloc]init];
    self.noticeLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:13.0f];
    self.noticeLb.textAlignment = NSTextAlignmentLeft;
    self.noticeLb.textColor = LHColor(34, 34, 34);
    [self.contentView addSubview:self.noticeLb];
    
    
    self.textLB = [[YYLabel alloc]init];
    self.textLB.numberOfLines = 0 ;
    self.textLB.textAlignment = NSTextAlignmentLeft;
    self.textLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheMessage:)];
    tap.numberOfTapsRequired = 2;
    [self.textLB addGestureRecognizer:tap];
    [self.contentView addSubview:self.textLB];
    
    
    self.headView = [[UIImageView alloc]init];
//    self.headView.backgroundColor = LHColor(218, 218, 218);
    self.headView.image = [UIImage imageNamed:@"headIg"];
    [self.contentView addSubview:self.headView];
    self.headView.layer.cornerRadius = 35/2;
    self.headView.layer.masksToBounds = YES;
    
}
-(void)setFrameModel:(MsgCellFrame *)frameModel{
    _frameModel = frameModel;
    
    //转化
    _frameModel = frameModel;
    UserMessage *message = frameModel.model;
    
    //时间
     self.timeLb.frame = frameModel.timeFrame;
     self.timeLb.text = message.msg_time;
//    NSLog(@"%@",message.msg_time);
    
    //提醒
     self.noticeLb.frame = frameModel.noticeFrame;
     self.noticeLb.text = @"提醒:";
    
    //内容
     self.textLB.frame = frameModel.textLBFrame;
     self.textLB.attributedText = message.attributedText;
    
    //头像
     self.bgIv.frame = frameModel.bgIvFrame;
     self.headView.frame = frameModel.headViewFrame;
}
-  (void)tapTheMessage:(UITapGestureRecognizer *)tap{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(tapZoomTheMessage:)]) {
         UserMessage *message = _frameModel.model;
        [self.delegate tapZoomTheMessage:message.info];
    }
}
@end
