//
//  YIIBUserLocationManager.m
//  YIVasMobile
//  室内导航-用户位置信息manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBUserLocationManager.h"
#import "YIIBUser.h"


@implementation YIIBUserLocationManager
#pragma mark - request
- (void)uploadUserLocation:(YIIBCoordinate *)coordinate placeid:(int)placeid memberCode:(NSString *)memberCode terminalCode:(NSString *)terminalCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:placeid] forKey:@"placeid"];
    [params setObject:memberCode forKey:@"memberCode"];
    [params setObject:terminalCode forKey:@"terminalCode"];
    [params setObject:[NSNumber numberWithInt:coordinate.floor] forKey:@"floor"];
    [params setObject:[NSNumber numberWithFloat:coordinate.x] forKey:@"coordinatex"];
    [params setObject:[NSNumber numberWithFloat:coordinate.y] forKey:@"coordinatey"];
    [self postWithSerCode:API_CODE_UPLOAD_LOCATION params:params];
}

- (void)queryPlaceFriendsWithPlaceid:(int)placeid memberCode:(NSString *)memberCode terminalCode:(NSString *)terminalCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:memberCode forKey:@"memberCode"];
    [params setObject:terminalCode forKey:@"terminalCode"];
    [params setObject:[NSNumber numberWithInt:placeid] forKey:@"placeid"];
    [self postWithSerCode:API_CODE_PLACE_FRIENDS params:params];
}

#pragma mark - result
- (void)requestSuccessWithData:(NSDictionary *)data serCode:(int)serCode
{
    NSString *responseCode = [data objectForKey:KEY_RESPONSE_CODE];
    NSString *responseDesc = [data objectForKey:KEY_RESPONSE_DESC];
    switch (serCode) {
        case API_CODE_UPLOAD_LOCATION:
        {
            if (self.uploadUserLocationBlock) {
                self.uploadUserLocationBlock(responseCode, responseDesc);
            }
        }
            break;
            
        case API_CODE_PLACE_FRIENDS:
        {
            if (self.queryPlaceFriendsBlock) {
                NSMutableArray *friends = nil;
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    NSArray *dataAry = [data objectForKey:KEY_RESULT_LIST];
                    friends = [NSMutableArray array];
                    for (NSDictionary *friendDic in dataAry) {
                        [friends addObject:[[YIIBUser alloc] initWithPlaceFriendDic:friendDic]];
                    }
                }
                self.queryPlaceFriendsBlock(friends, responseDesc);
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
        case API_CODE_UPLOAD_LOCATION:
        {
            if (self.uploadUserLocationBlock) {
                self.uploadUserLocationBlock(nil, error);
            }
        }
            break;
            
        case API_CODE_PLACE_FRIENDS:
        {
            if (self.queryPlaceFriendsBlock) {
                self.queryPlaceFriendsBlock(nil, error);
            }
        }
            break;
            
        default:
            break;
    }
}
@end
