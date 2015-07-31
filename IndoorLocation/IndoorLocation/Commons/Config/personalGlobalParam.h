//
//  personalGlobalParam.h
//  YIVasMobile
//
//  Created by wshm on 15/1/11.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#ifndef YIVasMobile_personalGlobalParam_h
#define YIVasMobile_personalGlobalParam_h

#define VasHotLine          @"4008689666"

#define Yi_isNetworkRunning [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable

//登录成功记录值
#define hasRememberUserNameKey     @"hasRememberUserName"
#define tokenDefaultKey         @"tokenDefaultKey"
#define memberCodeDefaultKey    @"memberCodeDefaultKey"
#define userNameDefaultKey    @"userNameDefaultKey"
#define passwordDefaultKey  @"passwordDefaultKey"

/**
 *  用户token
 */
#define tokenDefaultValue [[NSUserDefaults standardUserDefaults] valueForKey:tokenDefaultKey]
/**
 *  用户memberCode
 */
#define memberCodeDefaultValue [[NSUserDefaults standardUserDefaults] valueForKey:memberCodeDefaultKey]
/**
 *  用户名、密码
 */
#define userNameDefaultValue [[NSUserDefaults standardUserDefaults] valueForKey:userNameDefaultKey]
#define passwordDefaultValue [[[NSUserDefaults standardUserDefaults] valueForKey:passwordDefaultValue]]
/**
 *  是否记住用户名
 */
#define hasRememberUserNameValue [[NSUserDefaults standardUserDefaults] valueForKey:hasRememberUserNameKey]

// yi notify message type
///**
// *  登录成功发出的消息
// */
//#define MessageTypeOfLoginSuccess @"MessageTypeOfLoginSuccess"
///**
// *  实名认证成功通知消息
// */
//#define MessageTypeOfAuthSuccess    @"MessageTypeOfAuthSuccess"
/**
 *  alerter提示框取消登录消息
 */
#define MessageTypeOfLoginCancel    @"MessageTypeOfLoginCancel"
/**
 *  alerter提示框取消登录消息 userinfo内容key
 */
#define MessageTypeOfLoginCancelJumpKey @"MessageTypeOfLoginCancelJumpKey"
///**
// *  修改用户信息成功消息
// */
//#define MessageTypeOfModifyUserInfoSuccess    @"MessageTypeOfModifyUserInfoSuccess"
///**
//*
//*需要刷新用户相关页面消息
//**
#define NeedRefreshPersonalView @"NeedRefreshPersonalView"

#define kNeedAlertLoginView @"NeedAlertLoginView"
#endif


