//
//  NSUserDefaults+Extensions.m
//  YIVasMobile
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "NSUserDefaults+Extensions.h"

@implementation NSUserDefaults (Extensions)


+ (void)syncSetObject:(id)value forKey:(NSString *)keyName
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:keyName];
    
    [userDefaults synchronize];
}

+ (NSString *)stringWithKey:(NSString *)keyName

{
    NSString *string=[[NSUserDefaults standardUserDefaults] valueForKey:keyName];
    
    return string;
}



@end
