//
//  YIIBRecord.m
//  YIVasMobile
//  位置记录信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBRecord.h"

@implementation YIIBRecord
- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _recordid = [[dic objectForKey:@"id"] intValue];
        _placeid = [[dic objectForKey:@"placeid"] intValue];
        _floor = [[dic objectForKey:@"floor"] intValue];
        _coordinateX = [[dic objectForKey:@"coordinatex"] floatValue];
        _coordinateY = [[dic objectForKey:@"coordinatey"] floatValue];
        _name = [dic objectForKey:@"locationname"];
    }
    return self;
}
@end
