//
//  YIIBShopManager.m
//  YIVasMobile
//  室内导航-商铺信息Manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBShopManager.h"

@implementation YIIBShopManager
#pragma mark - request
- (void)queryShopsWithPlaceid:(int)placeid terminalCode:(NSString *)terminalCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:terminalCode forKey:@"terminalCode"];
    [params setObject:[NSNumber numberWithInt:placeid] forKey:@"placeid"];
    [self postWithSerCode:API_CODE_PLACE_SHOPS params:params];
}

- (void)queryShopInfoWithId:(NSString *)shopid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:shopid forKey:@"id"];
    [self postWithSerCode:API_CODE_SHOP_INFO params:params];
}

#pragma mark - result
- (void)requestSuccessWithData:(NSDictionary *)data serCode:(int)serCode
{
    NSString *responseCode = [data objectForKey:KEY_RESPONSE_CODE];
    NSString *responseDesc = [data objectForKey:KEY_RESPONSE_DESC];
    switch (serCode) {
        case API_CODE_PLACE_SHOPS:
        {
            if (self.queryPlaceShopsBlock) {
                NSMutableArray *shops = nil;
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    NSArray *dataAry = [data objectForKey:KEY_RESULT_LIST];
                    shops = [NSMutableArray array];
                    for (NSDictionary *shopDic in dataAry) {
                        [shops addObject:[[YIIBShop alloc] initWithDic:shopDic]];
                    }
                }
                self.queryPlaceShopsBlock(shops, responseDesc);
            }
        }
            break;
            
        case API_CODE_SHOP_INFO:
        {
            if (self.queryShopInfo) {
                YIIBShop *shop = nil;
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    shop = [[YIIBShop alloc] initWithDic:[data objectForKey:KEY_RESULT]];
                }
                self.queryShopInfo(shop, responseDesc);
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
        case API_CODE_PLACE_SHOPS:
        {
            if (self.queryPlaceShopsBlock) {
                self.queryPlaceShopsBlock(nil, error);
            }
        }
            break;
            
        case API_CODE_SHOP_INFO:
        {
            if (self.queryShopInfo) {
                self.queryShopInfo(nil, error);
            }
        }
            break;
            
        default:
            break;
    }
}
@end
