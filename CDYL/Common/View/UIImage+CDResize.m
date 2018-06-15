//
//  UIImage+CDResize.m
//  CDYL
//
//  Created by admin on 2018/6/7.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIImage+CDResize.h"

@implementation UIImage (CDResize)
- (UIImage *)resizeImage:(UIImage *)image{
    CGSize size = image.size;
    CGFloat igWight = image.size.width;
    CGFloat igHeight = image.size.height;
    
    CGFloat ratio = size.height/size.width;
    float newWight = DEAppWidth;
    float newHeight = DEAppWidth *ratio;
    
    if (igWight != newWight || igHeight != newHeight) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWight, newHeight), YES, [UIScreen mainScreen].scale);
        [self drawInRect:CGRectMake(0, 0, newWight, newHeight)];
        UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resized;
    }
    return self;
}
@end
