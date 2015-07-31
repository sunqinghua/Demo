//
//  YIIBUserLocationManager.h
//  YIVasMobile
//  室内导航-用户位置信息manager
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBRequestManager.h"
#import "YIIBCoordinate.h"

typedef void (^UploadUserLocationBlock)(NSString *result, NSString *error);
typedef void (^QueryPlaceFriendsBlock)(NSArray *friends, NSString *error);

@interface YIIBUserLocationManager : YIIBRequestManager

@property (nonatomic, copy) UploadUserLocationBlock uploadUserLocationBlock;
@property (nonatomic, copy) QueryPlaceFriendsBlock queryPlaceFriendsBlock;

- (void)uploadUserLocation:(YIIBCoordinate *)coordinate placeid:(int)placeid memberCode:(NSString *)memberCode terminalCode:(NSString *)terminalCode;
- (void)queryPlaceFriendsWithPlaceid:(int)placeid memberCode:(NSString *)memberCode terminalCode:(NSString *)terminalCode;
@end
