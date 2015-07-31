//
//  UIColor+HexString.h
//  VolunteerPlatform
//
//  Created by Coffee on 14-12-31.
//  Copyright (c) 2014年 nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
+ (UIColor*)colorWithHexString:(NSString*)hex;
+ (UIColor*)colorWithHexString:(NSString*)hex alpha:(float)alpha;
@end
