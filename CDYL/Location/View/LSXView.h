//
//  LSXView.h
//  LSX
//
//  Created by admin on 2016/11/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDStation.h"

@protocol showViewDelegate <NSObject>
// 点击更多按钮
- (void)clickTheMoreBtnWithStationModel:(CDStation *)model;

@end


@interface LSXView : UIView
@property (weak, nonatomic) IBOutlet UILabel *where;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *distence;
@property (nonatomic, weak) id <showViewDelegate>  delegate;
@property (nonatomic, strong) CDStation *model;



@end
