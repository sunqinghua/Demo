//
//  UIColor+HexString.m
//  VolunteerPlatform
//
//  Created by Coffee on 14-12-31.
//  Copyright (c) 2014年 nd. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)
+ (UIColor*)colorWithHexString:(NSString*)hex
{
    return [[self class] colorWithHexString:hex alpha:1.0];
}
+ (UIColor*)colorWithHexString:(NSString*)hex alpha:(float)alpha {
    if (alpha > 1.0) {
        alpha = 1.0;
    }
    if (alpha < 0) {
        alpha = 0;
    }
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end
