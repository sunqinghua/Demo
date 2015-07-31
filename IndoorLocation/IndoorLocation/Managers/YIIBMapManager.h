//
//  YIIBMapManager.h
//  YIVasMobile
//  室内导航-地图信息Manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBRequestManager.h"
#import "YIIBFloorMap.h"

typedef void (^QueryPlaceMapsBlock)(NSArray *maps, NSString *error);
typedef void (^QueryFloorMapBlock)(YIIBFloorMap *map, NSString *error);

@interface YIIBMapManager : YIIBRequestManager

@property (nonatomic, copy) QueryPlaceMapsBlock queryPlaceMapsBlock;
@property (nonatomic, copy) QueryFloorMapBlock queryFloorMapBlock;

- (void)queryMapsWithPlaceid:(int)placeid;
- (void)queryFloorMapWithPlaceid:(int)placeid floor:(int)floor;
@end
