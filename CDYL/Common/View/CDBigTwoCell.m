//
//  CDBigTwoCell.m
//  CDYL
//
//  Created by admin on 2018/4/24.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CDBigTwoCell.h"
@interface CDBigTwoCell()
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *headLB;
@end
@implementation CDBigTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self.contentView addSubview:self.headLB];
        [self.contentView addSubview:self.headView];
        
    }
    return self;
}

-(void)reloadHeadImage{
    
    NSString *file =[[NSFileManager defaultManager] headImagePath:NO];
    BOOL headPath = [[NSFileManager defaultManager]fileExistsAtPath:file];
    if (headPath) {
        NSData *data = [[NSFileManager defaultManager]contentsAtPath:file];
        self.headView.image = [[UIImage alloc]initWithData:data];
    }else{
        self.headView.backgroundColor =[[UIColor orangeColor]colorWithAlphaComponent:0.5];
    }
}
-(UIImageView *)headView{
    return _headView ? _headView : (_headView = ({
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(DEAppWidth -100, 8, 60, 60)];
        
        iv.layer.cornerRadius = 5;
        iv.layer.masksToBounds = YES;
        iv;
    }));
}
-(UILabel *)headLB{
    if (_headLB == nil) {
        _headLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 29, 150, 20)];
     
        _headLB.text = @"头像";
        _headLB.font = [UIFont systemFontOfSize:16];
        _headLB.textAlignment = NSTextAlignmentLeft;
    }
    return _headLB;
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.headLB.text = [dic objectForKey:@"whatName"];
    [self reloadHeadImage];
}
@end
