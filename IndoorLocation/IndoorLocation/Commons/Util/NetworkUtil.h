//
//  NetworkUtil.h
//  YIVasMobile
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkUtil : NSObject

#pragma mark  检查网络状况
/**
 *  @return 返回是否联网
 */
+(BOOL)isConnectNetWork;


#pragma mark 检查当前网络状态
/**
 *  NotReachable = 0,ReachableViaWiFi = 2,ReachableViaWWAN = 1
 *
 *  @return 网络状态
 */

+(NetworkStatus)checkCurrentNetWorkStatus;

@end
