//
//  YIIBMapManager.m
//  YIVasMobile
//  室内导航-地图信息Manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBMapManager.h"

@implementation YIIBMapManager
#pragma mark - request
- (void)queryMapsWithPlaceid:(int)placeid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:placeid] forKey:@"placeid"];
    [self postWithSerCode:API_CODE_PLACE_MAP params:params];
}

- (void)queryFloorMapWithPlaceid:(int)placeid floor:(int)floor
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:placeid] forKey:@"placeid"];
    [params setObject:[NSNumber numberWithInt:floor] forKey:@"floor"];
    [self postWithSerCode:API_CODE_FLOOR_MAP params:params];
}

#pragma mark - result
- (void)requestSuccessWithData:(NSDictionary *)data serCode:(int)serCode
{
    NSString *responseCode = [data objectForKey:KEY_RESPONSE_CODE];
    NSString *responseDesc = [data objectForKey:KEY_RESPONSE_DESC];
    switch (serCode) {
        case API_CODE_PLACE_MAP:
        {
            if (self.queryPlaceMapsBlock) {
                NSMutableArray *floorMaps = nil;
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    NSArray *dataAry = [data objectForKey:KEY_RESULT_LIST];
                    floorMaps = [NSMutableArray array];
                    for (NSDictionary *floorMapDic in dataAry) {
                        [floorMaps addObject:[[YIIBFloorMap alloc] initWithDic:floorMapDic]];
                    }
                }
                self.queryPlaceMapsBlock(floorMaps, responseDesc);
            }
        }
            break;
            
        case API_CODE_FLOOR_MAP:
        {
            if (self.queryFloorMapBlock) {
                YIIBFloorMap *floorMap = nil;
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    floorMap = [[YIIBFloorMap alloc] initWithDic:[data objectForKey:KEY_RESULT]];
                }
                self.queryFloorMapBlock(floorMap, responseDesc);
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)requestFailedWithError:(NSString *)error serCode:(int)serCode
{
    switch (serCode) {
        case API_CODE_PLACE_MAP:
        {
            if (self.queryPlaceMapsBlock) {
                self.queryPlaceMapsBlock(nil, error);
            }
        }
            break;
            
        case API_CODE_FLOOR_MAP:
        {
            if (self.queryFloorMapBlock) {
                self.queryFloorMapBlock(nil, error);
            }
        }
            break;
            
        default:
            break;
    }
}

@end
