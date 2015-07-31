//
//  YMMeIndicator.m
//  mall
//  我的指示器
//  Created by HAO FENG on 14-8-28.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import "YIIBMeIndicator.h"
#import "YMBeaconLocate.h"

@implementation YIIBMeIndicator

+ (YIIBMeIndicator *)view
{
    return [[YIIBMeIndicator alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor=[UIColor greenColor];
        
        UIImageView *me = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_me"]]];
        me.frame = CGRectMake(10, 10, 20, 20);
        [self addSubview:me];
        _me=me;
        
        UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_me_indicator"]]];
        indicator.frame = CGRectMake(0, 0, 40, 40);
        [self addSubview:indicator];
        _indicator = indicator;
        
        
        _me.frame=CGRectMake(0, 0, 40, 40);
        _indicator.frame=CGRectMake(-20, -20, 80, 80);
        
        if (![YMBeaconManager sharedManager].headingAvailable) {
            [indicator setHidden:YES];
        }
        _lblFloor = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 24, 16)];
        _lblFloor.textColor = [UIColor whiteColor];
        _lblFloor.backgroundColor = [UIColor colorWithRed:24/255.f green:180/255.f blue:237/255.f alpha:1];
        _lblFloor.layer.cornerRadius = 5;
        _lblFloor.font = [UIFont systemFontOfSize:14];
        _lblFloor.center = CGPointMake(20, 46);
        _lblFloor.textAlignment = NSTextAlignmentCenter;
        _lblFloor.clipsToBounds = YES;
        _lblFloor.text = @"B2";
        [self addSubview:_lblFloor];
        _followHeading = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateHeading) name:NOTIFICATION_UPDATE_HEADING object:nil];
    }
    return self;
}



- (void)setFloorStr:(NSString *)floorStr
{
    _floorStr = floorStr;
    _lblFloor.text = _floorStr;
}

- (void)setHideFloor:(BOOL)hideFloor
{
    _hideFloor = hideFloor;
    [_lblFloor setHidden:_hideFloor];
}

- (void)didUpdateHeading
{
    
    NSLog(@"indicator.frame=%@",NSStringFromCGRect(_indicator.frame));
    
    if (_followHeading) {
        _indicator.transform = CGAffineTransformIdentity;
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*([YMBeaconManager sharedManager].currentHeading.magneticHeading)/180.0);
        _indicator.transform = transform;
        
//        if ([YMBeaconManager sharedManager].currentHeading.magneticHeading > 90 && [YMBeaconManager sharedManager].currentHeading.magneticHeading < 270) {
//            _lblFloor.center = CGPointMake(20, -8);
//        }
//        else {
//            _lblFloor.center = CGPointMake(20, 46);
//        }
    }
    
}

- (void)setFollowHeading:(BOOL)followHeading
{
    _followHeading = followHeading;
    if (_followHeading) {
        _indicator.transform = CGAffineTransformIdentity;
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI*([YMBeaconManager sharedManager].currentHeading.magneticHeading)/180.0);
        _indicator.transform = transform;
    }
    else {
        _indicator.transform = CGAffineTransformIdentity;
        _lblFloor.center = CGPointMake(20, 46);
    }
}

-(void)meIndicatorSacleChange:(NSInteger)scale{
    switch (scale) {
        case 0:{
            _me.frame=CGRectMake(10, 10, 20, 20);
            _indicator.frame=CGRectMake(0, 0, 40, 40);
            _indicator.image=[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_me_indicator"]];
        }break;
        case 1:{
            _me.frame=CGRectMake(5, 5, 30, 30);
            _indicator.frame=CGRectMake(-10, -10, 60, 60);
            _indicator.image=[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_me_indicator"]];
        }break;
        case 2:{
            _me.frame=CGRectMake(0, 0, 40, 40);
            _indicator.frame=CGRectMake(-20, -20, 80, 80);
            _indicator.image=[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_me_indicator"]];
        }break;
            
        default:
            break;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
