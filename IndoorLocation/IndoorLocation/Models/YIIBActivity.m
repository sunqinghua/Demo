//
//  YIIBActivity.m
//  YIVasMobile
//  室内导航活动信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBActivity.h"
#import "NSDictionary+YIIBParam.h"

@implementation YIIBActivity
- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _activityid = [dic safeObjectForKey:@"id"];
        _placeid = [dic safeObjectForKey:@"placeid"];
        _icon = [dic safeObjectForKey:@"icon"];
        _type = [[dic safeObjectForKey:@"activityType"] intValue];
        _begintime = [[dic safeObjectForKey:@"begintime"] doubleValue];
        _endtime = [[dic safeObjectForKey:@"endtime"] doubleValue];
        _name = [dic safeObjectForKey:@"activityName"];
        _desc = [dic safeObjectForKey:@"activityDesc"];
        _hotpoint = [dic safeObjectForKey:@"hotpoint"];
        _floor = [[dic safeObjectForKey:@"floor"] intValue];
        _shopid = [dic safeObjectForKey:@"shopid"];
        _shopname = [dic safeObjectForKey:@"shopname"];
        _coordinateX = [[dic safeObjectForKey:@"coordinatex"] floatValue];
        _coordinateY = [[dic safeObjectForKey:@"coordinatey"] floatValue];
    }
    return self;
}
@end
