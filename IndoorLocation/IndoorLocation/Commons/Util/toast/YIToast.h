//
//  YIToast.h
//  YIVasMobile
//
//  Created by wshm on 15/1/11.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

typedef NS_ENUM(NSInteger, YIToastDuration) {
    kWTShort = 1,
    kWTLong = 5
};

@interface YIToast : UIView

+ (void)showWithText:(NSString *)text;
+ (void)showWithImage:(UIImage *)image;

+ (void)showWithText:(NSString *)text duration:(YIToastDuration)duration;
+ (void)showWithImage:(UIImage *)image duration:(YIToastDuration)duration;

+ (void)showText:(NSString*)text;
@end