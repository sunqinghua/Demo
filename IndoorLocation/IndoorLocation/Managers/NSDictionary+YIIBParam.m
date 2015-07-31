//
//  NSDictionary+YIIBParam.m
//  YIVasMobile
//
//  Created by darren on 14-12-20.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "NSDictionary+YIIBParam.h"

@implementation NSDictionary (YIIBParam)
- (NSTimeInterval)timeIntervalForKey:(id)aKey
{
    NSString *timeStr = [self objectForKey:aKey];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [formatter dateFromString:timeStr];
    return [date timeIntervalSince1970];
}

- (id)safeObjectForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if ([obj isEqual:[NSNull null]]) {
        obj = nil;
    }
    return obj;
}
@end
