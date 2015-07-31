//
//  YIIBFloorMap.h
//  YIVasMobile
//  楼层地图信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBFloorMap : NSObject
@property (nonatomic, assign) int mapid;                // 地图id
@property (nonatomic, assign) int placeid;              // 商场id
@property (nonatomic, assign) int floor;                // 所在楼层
@property (nonatomic, strong) NSArray *maps;            // YMMap 数组
- (id)initWithDic:(NSDictionary *)dic;
@end
