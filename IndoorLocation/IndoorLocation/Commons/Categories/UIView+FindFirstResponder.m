//
//  UIView+FindFirstResponder.m
//  IOS动画和事件的综合—自定义键盘
//
//  Created by songbo on 14-2-11.
//  Copyright (c) 2014年 ection. All rights reserved.
//

#import "UIView+FindFirstResponder.h"

@implementation UIView (FindFirstResponder)

+(UITextField*)findFirstResponder:(UIView *)view{
    for (UIView *child in view.subviews){
        if ([child respondsToSelector:@selector(isFirstResponder)]&&[child isFirstResponder]) {
            return (UITextField *)child;
        }
        UITextField * field=[self findFirstResponder:child];
        if (field) {
            return field;
        }
    }
    return nil;
}
@end
