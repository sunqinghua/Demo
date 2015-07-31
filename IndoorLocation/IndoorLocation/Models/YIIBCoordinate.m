//
//  YIIBCoordinate.m
//  YIVasMobile
//  坐标信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBCoordinate.h"

@implementation YIIBCoordinate
- (id)initWithX:(float)x y:(float)y floor:(int)floor
{
    if (self = [super init]) {
        _x = x;
        _y = y;
        _floor = floor;
    }
    return self;
}

- (BOOL)isEqual:(YIIBCoordinate*)c{
    if (self.x==c.x&&self.y==c.y&&self.floor==c.floor) {
        return true;
    }

    return false;
}
@end
