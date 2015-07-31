//
//  YIIBEdge.m
//  YIVasMobile
//  区域信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBEdge.h"

@implementation YIIBEdge

#define CHECK_TIME_IN   1
#define CHECK_TIME_OUT  1

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _centerX = [[[dic objectForKey:@"edgeDefine"] objectForKey:@"circlecenter_x"] floatValue];
        _centerY = [[[dic objectForKey:@"edgeDefine"] objectForKey:@"circlecenter_y"] floatValue];
        _radius = [[[dic objectForKey:@"edgeDefine"] objectForKey:@"circle_radius"] floatValue];
        _edgeid = [[dic objectForKey:@"edgeId"] intValue];
        _placeid = [[dic objectForKey:@"placeid"] intValue];
        _floor = [[dic objectForKey:@"floor"] intValue];
        _type = [[dic objectForKey:@"edgeType"] intValue];
        _name = [dic objectForKey:@"edgeName"];
        _desc = [dic objectForKey:@"edgeDesc"];
        _locationType=[[dic objectForKey:@"edgeLocationType"]intValue];
    }
    return self;
}

- (void)processX:(float)x y:(float)y floor:(int)floor
{
    BOOL inRange = ((x - _centerX) * (x - _centerX) + (y - _centerY) * (y - _centerY)) <= _radius * _radius;
    if (floor != self.floor) {
        inRange = NO;
    }
    if (self.inRange) {// 在区域内
        if (!inRange) {// 超出半径
            _inRangeTime ++;
            if (_inRangeTime >= CHECK_TIME_OUT) {
                // 出区域
                self.inRange = NO;
                if ([self.delegate respondsToSelector:@selector(edgeDidExit:)]) {
                    [self.delegate edgeDidExit:self];
                }
                _inRangeTime = 0;
            }
        }
        else {// 半径内
            _inRangeTime = 0;
        }
    }
    else {// 在区域外
        if (inRange) {// 进入半径范围
            _outRangeTime ++;
            if (_outRangeTime >= CHECK_TIME_IN) {
                // 进入区域
                self.inRange = YES;
                self.lastInTime = [[NSDate date] timeIntervalSince1970];
                if ([self.delegate respondsToSelector:@selector(edgeDidEnter:)]) {
                    [self.delegate edgeDidEnter:self];
                }
                _outRangeTime = 0;
            }
        }
        else {// 出半径
            _outRangeTime = 0;
        }
    }
}
@end
