//
//  UIView+FindFirstResponder.h
//  IOS动画和事件的综合—自定义键盘
//
//  Created by songbo on 14-2-11.
//  Copyright (c) 2014年 ection. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindFirstResponder)

//找出第一响应者
+(UITextField*)findFirstResponder:(UIView *)view;

@end
