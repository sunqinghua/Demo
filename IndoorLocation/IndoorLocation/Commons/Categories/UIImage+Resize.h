//
//  UIImage+Resize.h
//  weibo
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)
- (UIImage *)stretch:(NSInteger)left top:(NSInteger)top;
- (UIImage *)stretch:(UIEdgeInsets)insets;
+ (UIImage *)defaultStrtch:(NSString *)imageName;
- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height;

// image1是底部的
+ (UIImage *)composeInSize:(CGSize)size image1:(UIImage *)image1 rect1:(CGRect)rect1 image2:(UIImage *)image2 rect2:(CGRect)rect2;
@end
