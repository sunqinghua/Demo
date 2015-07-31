//
//  YIIBFloorMap.m
//  YIVasMobile
//  楼层地图信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBFloorMap.h"
#import "YIIBMap.h"

@implementation YIIBFloorMap
- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _mapid = [[dic objectForKey:@"id"] intValue];
        _placeid = [[dic objectForKey:@"placeid"] intValue];
        _floor = [[dic objectForKey:@"floor"] intValue];
        NSMutableArray *maps = [NSMutableArray array];
        YIIBMap *map1 = [[YIIBMap alloc] init];
        map1.image = [dic objectForKey:@"image1"];
        map1.scale = [[dic objectForKey:@"scale1"] floatValue];
        map1.width = [[dic objectForKey:@"width1"] intValue];
        map1.height = [[dic objectForKey:@"height1"] intValue];
        [maps addObject:map1];
        
        YIIBMap *map2 = [[YIIBMap alloc] init];
        map2.image = [dic objectForKey:@"image2"];
        map2.scale = [[dic objectForKey:@"scale2"] floatValue];
        map2.width = [[dic objectForKey:@"width2"] intValue];
        map2.height = [[dic objectForKey:@"height2"] intValue];
        if (map2.scale != map1.scale) {
            [maps addObject:map2];
        }
        
        YIIBMap *map3 = [[YIIBMap alloc] init];
        map3.image = [dic objectForKey:@"image3"];
        map3.scale = [[dic objectForKey:@"scale3"] floatValue];
        map3.width = [[dic objectForKey:@"width3"] intValue];
        map3.height = [[dic objectForKey:@"height3"] intValue];
        if (map3.scale != map2.scale) {
            [maps addObject:map3];
        }
        _maps = [NSArray arrayWithArray:maps];
    }
    return self;
}
@end
