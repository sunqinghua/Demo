//
//  YIIBShopManager.h
//  YIVasMobile
//  室内导航-商铺信息Manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBRequestManager.h"
#import "YIIBShop.h"

typedef void (^QueryPlaceShopsBlock)(NSArray *shops, NSString *error);
typedef void (^QueryShopInfo)(YIIBShop *shop, NSString *error);

@interface YIIBShopManager : YIIBRequestManager

@property (nonatomic, copy) QueryPlaceShopsBlock queryPlaceShopsBlock;
@property (nonatomic, copy) QueryShopInfo queryShopInfo;

- (void)queryShopsWithPlaceid:(int)placeid terminalCode:(NSString *)terminalCode;
- (void)queryShopInfoWithId:(NSString *)shopid;
@end
