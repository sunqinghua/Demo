//
//  UIImage+withColor.m
//  BTPass
//
//  Created by songbo on 14-2-18.
//  Copyright (c) 2014年 ection. All rights reserved.

//UIColor生成image


#import "UIImage+withColor.h"

@implementation UIImage (withColor)


//UIColor生成image
+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
