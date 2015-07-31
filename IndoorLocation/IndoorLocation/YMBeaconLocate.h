//
//  YMBeaconLocate.h
//  ytlocation
//
//  Created by darren on 14-12-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define NOTIFICATION_UPDATE_HEADING     @"NOTIFICATION_UPDATE_HEADING"

@protocol YMBeaconLocationDelegate <NSObject>
/* 进入商场 */
- (void)didEnterPlaceid:(int)placeid;
/* 离开商场 */
- (void)didExitPlaceid:(int)placeid;
/* 位置更新回调 */
- (void)didMovetoX:(float)x y:(float)y floor:(int)floor;
@end

@protocol YMFindUserDelegate <NSObject>
- (void)didFindUserIds:(NSDictionary *)userids;
@end

@interface YMBeaconManager : NSObject

@property (nonatomic, weak) id<YMBeaconLocationDelegate> locationDelegate;
@property (nonatomic, weak) id<YMFindUserDelegate> findUserDelegate;
/* 是否支持指南针 */
@property (nonatomic, assign) BOOL headingAvailable;
/* 定位是否可用 */
@property (nonatomic, assign) BOOL locateAvailable;
/* 蓝牙是否可用 */
@property (nonatomic, assign) BOOL bluetoothAvailable;
/* 当前朝向 */
@property (nonatomic, strong) CLHeading *currentHeading;

/* 当前位置信息 */
@property (nonatomic, readonly) float x;
@property (nonatomic, readonly) float y;
@property (nonatomic, readonly) int floor;
@property (nonatomic, readonly) int placeid;

+ (YMBeaconManager *)sharedManager;
/* 开始定位 */
- (void)startUpdateLocation;
/* 停止定位 */
- (void)stopUpdateLocation;
/* 开始广播用户id */
- (void)startAdvertisingUserid:(int)userid;
/* 停止广播用户id */
- (void)stopAdvertising;
@end