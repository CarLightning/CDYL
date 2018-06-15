//
//  CDCellView.h
//  CDYL
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDCellViewDelegate <NSObject>

-(void)userTapTheCellIndex:(NSUInteger)index;

@end
@interface CDCellView : UIView
@property (nonatomic, weak) id <CDCellViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame showUpLb:(BOOL)showUp showLineLb:(BOOL)showline cellName:(NSString *)nameStr;
-(void)reloadNotifiImage:(NSString *)name;

@end
