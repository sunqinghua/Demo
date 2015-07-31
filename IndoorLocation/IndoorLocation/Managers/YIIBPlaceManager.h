//
//  YIIBPlaceManager.h
//  YIVasMobile
//  室内导航-商城信息Manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBRequestManager.h"

@class YIIBPlace;

typedef void (^QueryPlaceInfoBlock)(YIIBPlace *place, NSString *error);
typedef void (^QueryPlaceListBlock)(NSArray *places, NSString *error);

@interface YIIBPlaceManager : YIIBRequestManager

@property (nonatomic, copy) QueryPlaceInfoBlock queryPlaceInfoBlock;
@property (nonatomic, copy) QueryPlaceListBlock queryPlaceListBlock;

- (void)queryPlaceInfoWithPlaceid:(int)placeid;
- (void)queryPlaceListWithCurLocation:(NSString *)curName;
- (void)queryPlaceList;
@end
