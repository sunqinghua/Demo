//
//  YIIBPlace.m
//  YIVasMobile
//  商场（地点）信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBPlace.h"
#import "NSDictionary+YIIBParam.h"

@implementation YIIBPlace
- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _placeid = [[dic safeObjectForKey:@"id"] intValue];
        _name = [dic safeObjectForKey:@"placeName"];
        _desc = [dic safeObjectForKey:@"placeDesc"];
        _province = [dic safeObjectForKey:@"province"];
        _city = [dic safeObjectForKey:@"city"];
        _district = [dic safeObjectForKey:@"district"];
        _address = [dic safeObjectForKey:@"address"];
        _picture = [dic safeObjectForKey:@"picture"];
        _longitude = [[dic safeObjectForKey:@"longitude"] floatValue];
        _latitude = [[dic safeObjectForKey:@"latitude"] floatValue];
        _topfloor = [[dic safeObjectForKey:@"topfloor"] intValue];
        _lowfloor = [[dic safeObjectForKey:@"lowfloor"] intValue];
        _welcome = [dic safeObjectForKey:@"welcomeword"];
        _telephone = [dic safeObjectForKey:@"telephone"];
        _brief = [dic safeObjectForKey:@"placeBrief"];
        _url = [dic safeObjectForKey:@"officialhomepage"];
    }
    return self;
}
@end
