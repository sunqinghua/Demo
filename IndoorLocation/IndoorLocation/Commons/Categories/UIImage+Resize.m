//
//  UIImage+Resize.m
//  weibo
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+ (UIImage *)defaultStrtch:(NSString *)imageName {
    UIImage *temp = [UIImage imageNamed:imageName];
    return [temp stretch:temp.size.width * 0.5f top:temp.size.height * 0.5f];
}

- (UIImage *)stretch:(NSInteger)left top:(NSInteger)top {
    NSInteger bottom = self.size.height - top - 1;
    NSInteger right = self.size.width - left - 1;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return [self stretch:insets];
}

- (UIImage *)stretch:(UIEdgeInsets)insets {
#ifdef  __IPHONE_6_0
    return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
#elif   __IPHONE_5_0
    return [self resizableImageWithCapInsets:insets];
#else
    return [self stretchableImageWithLeftCapWidth:insets.left topCapHeight:insets.top];
#endif
}

+ (UIImage *)composeInSize:(CGSize)size image1:(UIImage *)image1 rect1:(CGRect)rect1 image2:(UIImage *)image2 rect2:(CGRect)rect2 {
    UIGraphicsBeginImageContext(size);
    
    [image1 drawInRect:rect1];
    [image2 drawInRect:rect2];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height {
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

@end
