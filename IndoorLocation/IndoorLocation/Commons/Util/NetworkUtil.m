//
//  NetworkUtil.m
//  YIVasMobile
//
//  Created by apple on 15/6/9.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "NetworkUtil.h"

@implementation NetworkUtil

#pragma mark 判断是否联网 

+(BOOL)isConnectNetWork
{
    BOOL isExistenceNetwork = YES;
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork=NO;
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            //NSLog(@"正在使用wifi网络");
            break;
    }
    return isExistenceNetwork;
}

#pragma mark 检查当前网络状态

+(NetworkStatus)checkCurrentNetWorkStatus
{
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
            NSLog(@"没有网络");
            return NotReachable;
            break;
        case ReachableViaWWAN:
            NSLog(@"正在使用3G网络");
            return ReachableViaWWAN;
            break;
        case ReachableViaWiFi:
           // NSLog(@"正在使用wifi网络");
            return ReachableViaWiFi;
            break;
        default:
            NSLog(@"正在使用3G网络");
            return ReachableViaWiFi;
            break;
    }
}


@end
