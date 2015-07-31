//
//  WeconexSDK.m
//  IndoorLocation
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "WeconexSDK.h"

static NSString *apiKey;

@implementation WeconexSDK

+ (WeconexSDK *)initWithApiKey:(NSString *)ApiKey
{
    static WeconexSDK *sharedWeconexManagerInstance = nil;
    static dispatch_once_t predicate;
    apiKey=ApiKey;
    dispatch_once(&predicate, ^{
        sharedWeconexManagerInstance = [[self alloc] init];
    });
    return sharedWeconexManagerInstance;
}

+(YIIBMapViewController *)getLocationViewController{
    return [[YIIBMapViewController alloc]init];
}

+(YIIBNavigationViewController *)getNavigationViewController{
    return [[YIIBNavigationViewController alloc]init];
}


+(NSString *)getApiKey{
    return apiKey;
}

@end
