//
//  CDHeadView.h
//  CDYL
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CDHeadViewDelagate <NSObject>
 - (void)didClickTheEditBtn;
@end;
@interface CDHeadView : UIView
@property (nonatomic, weak) id <CDHeadViewDelagate> delegate;

- (void)reloadData;
@end
