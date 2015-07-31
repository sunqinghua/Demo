//
//  YIIBPlaceManager.m
//  YIVasMobile
//  室内导航-商城信息Manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBPlaceManager.h"
#import "YIIBPlace.h"

@implementation YIIBPlaceManager
#pragma mark - request
- (void)queryPlaceInfoWithPlaceid:(int)placeid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:placeid] forKey:@"placeid"];
    [self postWithSerCode:API_CODE_PLACE_INFO params:params];
}

-(void)queryPlaceList{

    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSMutableDictionary *pageable = [NSMutableDictionary dictionary];
    //[pageable setObject:[NSNumber numberWithInt:(int)kListDataCount] forKey:@"pageSize"];
    [pageable setObject:@"0" forKey:@"pageNumber"];
    [params setObject:@"盈通" forKey:@"placeName"];
    [params setObject:pageable forKey:@"pageable"];
}

- (void)queryPlaceListWithCurLocation:(NSString *)curName{
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSMutableDictionary *pageable = [NSMutableDictionary dictionary];
    //[pageable setObject:[NSNumber numberWithInt:(int)kListDataCount] forKey:@"pageSize"];
    [pageable setObject:@"0" forKey:@"pageNumber"];
    [params setObject:curName forKey:@"placeName"];
    [params setObject:pageable forKey:@"pageable"];
    
    [self postWithSerCode:API_CODE_PLACE_LIST params:params];
}

#pragma mark - result
- (void)requestSuccessWithData:(NSDictionary *)data serCode:(int)serCode
{
    NSString *responseCode = [data objectForKey:KEY_RESPONSE_CODE];
    NSString *responseDesc = [data objectForKey:KEY_RESPONSE_DESC];
    switch (serCode) {
        case API_CODE_PLACE_INFO:
        {
            if (self.queryPlaceInfoBlock) {
                YIIBPlace *place = nil;
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    place = [[YIIBPlace alloc] initWithDic:[data objectForKey:KEY_RESULT]];
                }
                self.queryPlaceInfoBlock(place, responseDesc);
            }
        }
            break;
            
        case API_CODE_PLACE_LIST:
        {
            if (self.queryPlaceListBlock) {
                NSMutableArray *places = [NSMutableArray array];
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
//                    NSArray *dataAry = [data objectForKey:KEY_RESULT_LIST];
//                    places = [NSMutableArray array];
//                    for (NSDictionary *placeDic in dataAry) {
//                        [places addObject:[[YIIBPlace alloc] initWithDic:placeDic]];
//                    }
                    NSDictionary *resultList=[data objectForKey:KEY_RESULT_LIST];
                    NSArray *dataAry =[resultList objectForKey:@"rows"];
                    for (NSDictionary *placeDic in dataAry) {
                        [places addObject:[[YIIBPlace alloc] initWithDic:placeDic]];
                    }
                    self.queryPlaceListBlock(places, nil);
                }else{
                    self.queryPlaceListBlock(places, responseDesc);
                }
                
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
        case API_CODE_PLACE_INFO:
        {
            if (self.queryPlaceInfoBlock) {
                self.queryPlaceInfoBlock(nil, error);
            }
        }
            break;
            
        case API_CODE_PLACE_LIST:
        {
            if (self.queryPlaceListBlock) {
                self.queryPlaceListBlock(nil, error);
            }
        }
            break;
            
        default:
            break;
    }
}
@end
