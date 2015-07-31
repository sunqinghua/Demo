//
//  YMCompass.m
//  mall
//
//  Created by HAO FENG on 14-10-30.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import "YIIBCompass.h"
#import "YMBeaconLocate.h"

@implementation YIIBCompass

+ (YIIBCompass *)view
{
    return [[YIIBCompass alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"icon_compass_background"]]];
        background.frame = CGRectMake(0, 0, 41, 41);
        [self addSubview:background];
        UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"icon_compass"]]];
        indicator.frame = CGRectMake(0, 0, 30, 30);
        indicator.center = CGPointMake(20.5, 20.5);
        [self addSubview:indicator];
        _arrowImageView = indicator;
//        [self didUpdateHeading];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateHeading) name:NOTIFICATION_UPDATE_HEADING object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setCompassTransform:(CGAffineTransform)compassTransform
{
    _compassTransform = compassTransform;
    _arrowImageView.transform = CGAffineTransformIdentity;
    _arrowImageView.transform = _compassTransform;
}

- (void)didUpdateHeading
{
    _arrowImageView.transform = CGAffineTransformIdentity;
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*(360 - [YMBeaconManager sharedManager].currentHeading.magneticHeading)/180.0);
    _arrowImageView.transform = transform;
}

@end
