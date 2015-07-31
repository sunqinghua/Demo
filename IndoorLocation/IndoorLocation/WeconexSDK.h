//
//  WeconexSDK.h
//  IndoorLocation
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIIBMapViewController.h"
#import "YIIBNavigationViewController.h"



@interface WeconexSDK : NSObject

/*
 @method
 @abstract WeconexSDK入口类的初始化函数。
 @param ApiKey 应用的ApiKey
 */

+(WeconexSDK *)initWithApiKey:(NSString*)ApiKey;


/*!
 @method
 @abstract 获取初始化Frontia的app Key。
 @result   app Key。
 */

+(NSString *)getApiKey;

/*!
 @method
 @abstract 显示定位View函数。
 */

+(YIIBMapViewController *)getLocationViewController;


/*!
 @method
 @abstract 显示导航View函数。
 */

+(YIIBNavigationViewController *)getNavigationViewController;

@end
