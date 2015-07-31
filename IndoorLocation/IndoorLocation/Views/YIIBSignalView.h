//
//  YMSignalView.h
//  mall
//
//  Created by HAO FENG on 14-10-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YIIBSignalView : UIView
{
    UIImageView *_sigImageView;
    NSTimer *_timer;
}
+ (YIIBSignalView *)view;
@end
