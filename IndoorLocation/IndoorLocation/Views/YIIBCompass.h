//
//  YMCompass.h
//  mall
//
//  Created by HAO FENG on 14-10-30.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YMBeaconManager.h"

@interface YIIBCompass : UIView
{
    UIImageView *_arrowImageView;
}
@property (nonatomic, assign) CGAffineTransform compassTransform;
+ (YIIBCompass *)view;
@end
