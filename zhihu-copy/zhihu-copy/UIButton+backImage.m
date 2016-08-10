//
//  UIButton+backImage.m
//  zhihu-copy
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 Apple. All rights reserved.
//
#define GetColorFromHex(hexColor) \
[UIColor colorWithRed:((hexColor >> 16) & 0xFF) / 255.0 \
green:((hexColor >>  8) & 0xFF) / 255.0 \
blue:((hexColor >>  0) & 0xFF) / 255.0 \
alpha:((hexColor >> 24) & 0xFF) / 255.0]



#import "UIButton+backImage.h"



@implementation UIButton (backImage)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
