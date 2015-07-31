//
//  YMSignalView.m
//  mall
//
//  Created by HAO FENG on 14-10-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import "YIIBSignalView.h"

@implementation YIIBSignalView

+ (YIIBSignalView *)view
{
    return [[YIIBSignalView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _sigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        [self addSubview:_sigImageView];
        [_sigImageView setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"sig0"]]];
        _sigImageView.alpha = 0.7;
        _sigImageView.contentMode = UIViewContentModeCenter;
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 40, 10)];
        lbl.font = [UIFont boldSystemFontOfSize:8];
        lbl.text = @"定位信号";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor colorWithRed:48/255.f green:164/255.f blue:253/255.f alpha:1];
        [self addSubview:lbl];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateSignal:) name:@"SIGNAL_UPDATE" object:nil];
//        NSLog(@"********* init timer *********");
    }
    return self;
}

- (void)dealloc
{
    @synchronized(self) {
//        NSLog(@"********* dealloc *********");
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        if (_timer) {
//            NSLog(@"********* dealloc _timer not null *********");
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)didUpdateSignal:(NSNotification *)notification
{
    @synchronized(self) {
//        NSLog(@"********* didUpdateSignal timer:%@ *********", _timer);
        if (!_sigImageView) {
            return;
        }
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        int signal = [[notification.userInfo objectForKey:@"signal"] intValue];
//        NSLog(@"------- signal : %d ---------", signal);
        if (signal > -67) {
            [_sigImageView setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"sig3"]]];
        }
        else if (signal > -72) {
            [_sigImageView setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"sig2"]]];
        }
        else {
            [_sigImageView setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"sig1"]]];
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(noSignal) userInfo:nil repeats:NO];
    }
}

- (void)noSignal
{
    if (_sigImageView) {
        [_sigImageView setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"sig0"]]];
    }
}
@end
