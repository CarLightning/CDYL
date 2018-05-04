//
//  CDLoginView.h
//  CDYL
//
//  Created by admin on 2018/4/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDLoginView : UIView
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UITextField *pWordTf;

-(instancetype)initWithFrame:(CGRect)frame wight:(CGFloat)wight;
@end
